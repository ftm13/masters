package edu.stanford.nlp.sempre.fbalignment.unary;

import edu.stanford.nlp.io.IOUtils;
import edu.stanford.nlp.sempre.freebase.FbFormulasInfo;
import edu.stanford.nlp.sempre.Formula;
import edu.stanford.nlp.sempre.fbalignment.bipartite.rep.BipartiteEdge;
import edu.stanford.nlp.sempre.fbalignment.bipartite.rep.UnlabeledEdge;
import edu.stanford.nlp.sempre.fbalignment.jung.DirectedSparseGraphVertexAccess;
import edu.stanford.nlp.sempre.freebase.lexicons.EntrySource;
import edu.stanford.nlp.sempre.freebase.lexicons.LexicalEntry;
import edu.stanford.nlp.sempre.freebase.UnaryLexicon;
import edu.stanford.nlp.sempre.freebase.utils.FileUtils;
import edu.stanford.nlp.sempre.freebase.utils.FreebaseUtils;
import edu.stanford.nlp.util.ArrayUtils;
import edu.stanford.nlp.util.CollectionUtils;
import edu.stanford.nlp.util.Pair;
import edu.stanford.nlp.util.Sets;
import fig.basic.LogInfo;
import fig.basic.Option;
import fig.exec.Execution;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

//import edu.stanford.nlp.sempre.freebase.lexicons.normalizers.UnaryNormalizer;


/**
 * Creating unary alignments. input is a unary tuples file where first arg is
 * linked to an ID Steps: 1. Collect all IDs in the unary tuple files 2. find
 * for every ID all unaries it belongs to by going through the datadump tuple
 * file 3. Go over the unary tuple file and create nodes and edges
 * <p/>
 * After creating the alignment file, the lexicon file is created by combining
 * the alignment file with the unary info string file
 *
 * @author jonathanberant
 */
public class UnaryAlignmentManager implements Runnable {

  @Option(gloss = "Path to unary linked extractions file")
  public static String unaryTupleFile;
  @Option(gloss = "Path to freebase datadump file")
  public static String datadumpFile;
  @Option(gloss = "Path to output alignment file")
  public static String outAlignmentFile;
  @Option(gloss = "Path to output lexicon file")
  public static String outLexFile;
  @Option(gloss = "Path to unary info string file")
  public static String unaryInfoStringFile;

  private Set<String> relevantIds; // generated by step 1
  private Map<String, Set<String>> idToUnariesMap; // generated by step 2
  private DirectedSparseGraphVertexAccess<UnaryAlignmentNode, BipartiteEdge> bigraph; // generated by step3


  private static final int CLASS_INDEX = 2;
  private static final int ID_INDEX = 3;
  private static final Set<String> unaries = ArrayUtils.asSet(new String[]{"fb:type.object.type", "fb:people.person.profession"});

  /**
   * Collect all the IDs for which we need to fine the unaries.
   *
   * @throws IOException
   */
  public void step1GetIdsInTupleFile() throws IOException {
    LogInfo.log("Unary tuple file: " + unaryTupleFile);
    relevantIds = FileUtils.loadSetFromTabDelimitedFile(unaryTupleFile, ID_INDEX);
    LogInfo.log("Step1: Number of relevant IDs is " + relevantIds.size());
  }

  public void step2GetIdToUnaries() throws IOException {

    idToUnariesMap = new HashMap<String, Set<String>>();
    int i = 0;
    for (String line : IOUtils.readLines(datadumpFile)) {

      String[] tokens = line.split("\t");
      if (tokens.length < 3)
        continue;
      String id = tokens[0];
      String property = tokens[1];
      String value = tokens[2].substring(0, tokens[2].length() - 1); // rid of the period at the end

      if (relevantIds.contains(id) && unaries.contains(property)) {

        String unary = property + " " + value;
        Set<String> currentUnaries = idToUnariesMap.get(id);
        if (currentUnaries == null) {
          currentUnaries = new TreeSet<String>();
          idToUnariesMap.put(id, currentUnaries);
        }
        currentUnaries.add(unary);
        if (i % 1000 == 0)
          LogInfo.log("Added unary: " + unary + ", to id: " + id + ", Current unaries: " + currentUnaries);

      }
      i++;
      if (i % 1000000 == 0)
        LogInfo.log("Number of lines: " + i + ", current line: " + line);
    }
    LogInfo.log("Step2: Number of freebase IDs mapped to unaries " + idToUnariesMap.size());
  }

  public void step3GenerateBigraph() throws IOException {

    bigraph = new DirectedSparseGraphVertexAccess<UnaryAlignmentNode, BipartiteEdge>();
    BufferedReader reader = IOUtils.getBufferedFileReader(unaryTupleFile);
    String line;

    while ((line = reader.readLine()) != null) {

      String[] tokens = FreebaseUtils.DELIMITER_PATTERN.split(line);
      String id = tokens[ID_INDEX];
      String nl = tokens[CLASS_INDEX].toLowerCase();
      // String nl = normalizer.normalizeAndStem(tokens[CLASS_INDEX]);
      Set<String> unaries = idToUnariesMap.get(id);
      if (unaries == null)
        continue; // if this is a mid for which we did not find any unaries

      UnaryAlignmentNode nlNode = new NlUnaryAlignmentNode(nl);
      for (String unary : unaries) {

        FbUnaryAlignmentNode fbNode = new FbUnaryAlignmentNode("(" + unary + ")"); // unaries don't have the parenthesis
        if (!FbUnaryNodeFilter.filter(fbNode)) {

          // find nl node
          if (bigraph.containsVertex(nlNode)) {
            nlNode = bigraph.getRealVertex(nlNode);
          }
          // find fb node
          if (bigraph.containsVertex(fbNode)) {
            fbNode = (FbUnaryAlignmentNode) bigraph.getRealVertex(fbNode);
          }
          // create an edge between them
          BipartiteEdge edge = bigraph.findEdge(nlNode, fbNode);
          if (edge == null) {
            edge = new UnlabeledEdge();
            bigraph.addEdge(edge, nlNode, fbNode);
          }
          edu.uci.ics.jung.graph.util.Pair<UnaryAlignmentNode> endPoints = bigraph.getEndpoints(edge);
          endPoints.getFirst().addId(id);
          endPoints.getSecond().addId(id);
        }
      }
    }
    reader.close();
    LogInfo.log("Step 3: number of bigraph nodes: " + bigraph.getVertexCount() + ", number of bigraph edges: " + bigraph.getEdgeCount());
  }

  public void step4SaveAlignmentFile() throws IOException {

    PrintWriter pw = IOUtils.getPrintWriter(outAlignmentFile);
    pw.println("NL_description\tFB_desc\tIntersection_size\tNL_size\tFB_size\tscore\tsample");

    for (UnaryAlignmentNode nlNode : bigraph.getVertices()) {
      for (UnaryAlignmentNode fbNode : bigraph.getSuccessors(nlNode)) {

        Set<String> intersection = Sets.intersection(nlNode.getIds(), fbNode.getIds());
        Set<String> union = Sets.union(nlNode.getIds(), fbNode.getIds());
        int intersectionSize = intersection.size();
        Collection<String> sample = CollectionUtils.sampleWithoutReplacement(intersection, Math.min(5, intersection.size()));
        double score = (double) intersectionSize / (union.size() + 5);
        if (nlNode.getIdsCount() > 0 && fbNode.getIdsCount() > 0 && score > 0.000) {
          pw.println(
                  nlNode.getDescription() + "\t" + fbNode.getDescription() + "\t" + intersectionSize + "\t" + nlNode.getIdsCount()
                          + "\t" + fbNode.getIdsCount() + "\t" + score + "\t" + sample);
        }
      }
    }
    pw.close();
  }


  public static void main(String[] args) throws IOException {

    Execution.run(
            args,
            "UnaryAlignmentManager", new UnaryAlignmentManager());
  }

 // todo - all these static methods were moved from UnaryLexicon to make it simpler - we can replace all of these just by
 // generating the correct json file directly and not through unary lexicon
  private static Map<String, Map<Pair<Formula, String>, LexicalEntry.UnaryLexicalEntry>> generateFromStringFileNlToFormulaMap(String stringFile) {

    Map<String, Map<Pair<Formula, String>, LexicalEntry.UnaryLexicalEntry>> res = new HashMap<>();
    FbFormulasInfo ffi = FbFormulasInfo.getSingleton();

    int i = 0;
    for (String line : IOUtils.readLines(stringFile)) {

      String[] tokens = line.split("\t");
      String nl = tokens[3].toLowerCase();
      Formula formula = Formula.fromString(tokens[1]);
      if (ffi.getUnaryInfo(formula) == null) {
        LogInfo.log("Skipping on formula since info is missing from schema: " + formula);
      } else {
        FbFormulasInfo.UnaryFormulaInfo uInfo = ffi.getUnaryInfo(formula);

        Map<Pair<Formula, String>, LexicalEntry.UnaryLexicalEntry> formulaToAlignmentInfoMap = res.get(nl);
        if (formulaToAlignmentInfoMap == null) {
          formulaToAlignmentInfoMap = new HashMap<>();
          res.put(nl, formulaToAlignmentInfoMap);
        }
        LexicalEntry.UnaryLexicalEntry uEntry =
                formulaToAlignmentInfoMap.get(new Pair<>(formula, EntrySource.STRING_MATCH.toString()));
        if (uEntry == null) {

          uEntry = new LexicalEntry.UnaryLexicalEntry(nl, nl, new TreeSet<>(uInfo.descriptions), formula, EntrySource.STRING_MATCH, uInfo.popularity,
                  new TreeMap<>(), uInfo.types);
          formulaToAlignmentInfoMap.put(new Pair<>(formula, EntrySource.STRING_MATCH.toString()), uEntry);
        }
        i++;
        if (i % 1000 == 0)
          LogInfo.log("Adding mapping from nl: " + nl + " to formula " + formula.toString());
      }
    }
    return res;
  }

  public static void saveUnaryLexiconFromStringFileAndAlignmentFile(String alignmentFile, String stringFile, String lexiconFile) throws IOException {
    UnaryLexicon lexicon = fromStringFileAndAlignmentFile(alignmentFile, stringFile);
    lexicon.save(lexiconFile);
  }

  /**
   * @param alignmentFile - file containing alignment from stemmed NL to
   *                      Freebase unaries
   * @param stringFile    - file containing string info and popularity about all
   *                      Freebase unaries
   */
  public static UnaryLexicon fromStringFileAndAlignmentFile(String alignmentFile, String stringFile) {

    LogInfo.begin_track("Generating nl to info from string match file");
    Map<String, Map<Pair<Formula, String>, LexicalEntry.UnaryLexicalEntry>> nlToFormulaAndAlignmentMap =
            generateFromStringFileNlToFormulaMap(stringFile);
    LogInfo.end_track();
    LogInfo.begin_track("Adding alignment info");
    addAlignmentInfo(alignmentFile, nlToFormulaAndAlignmentMap);
    LogInfo.end_track();
   // todo(joberant)
    throw new RuntimeException("This is broken right now because unary lexicon does not have that constructor");
  }

  private static void addAlignmentInfo(String alignmentFile,
                                       Map<String, Map<Pair<Formula, String>, LexicalEntry.UnaryLexicalEntry>> nlToFormulaAndAlignmentMap) {

    int i = 0;
    for (String line : IOUtils.readLines(alignmentFile)) {
      i++;
      if (i == 1)
        continue;
      String[] tokens = line.split("\t");
      String nl = tokens[0]; // it is already stemmed and normalized
      Formula formula = Formula.fromString(tokens[1]);
      Map<String, Double> features = new TreeMap<>();
      features.put(UnaryLexicon.INTERSECTION, Double.parseDouble(tokens[2]));
      features.put(UnaryLexicon.NL_SIZE, Double.parseDouble(tokens[3]));
      features.put(UnaryLexicon.FB_SIZE, Double.parseDouble(tokens[4]));

      addEntry(nl, EntrySource.ALIGNMENT.toString(), formula, features, nlToFormulaAndAlignmentMap);
      if (i % 10000 == 0)
        LogInfo.log("Number of lines: " + i);
    }
  }

  private static void addEntry(String nl, String source, Formula formula, Map<String, Double> featureMap,
                               Map<String, Map<Pair<Formula, String>, LexicalEntry.UnaryLexicalEntry>> lexemeToEntryMap) {

    FbFormulasInfo ffi = FbFormulasInfo.getSingleton();
    if (ffi.getUnaryInfo(formula) == null) {
      LogInfo.warnings("Missing info for unary: %s ", formula);
    } else {
      FbFormulasInfo.UnaryFormulaInfo uInfo = ffi.getUnaryInfo(formula);
      LexicalEntry.UnaryLexicalEntry uEntry = new LexicalEntry.UnaryLexicalEntry(nl, nl,  new TreeSet<>(uInfo.descriptions), formula, EntrySource.parseSourceDesc(source),
              uInfo.popularity, new TreeMap<>(featureMap), uInfo.types);

      Map<Pair<Formula, String>, LexicalEntry.UnaryLexicalEntry> formulaToAlignmentInfoMap = lexemeToEntryMap.get(nl);
      if (formulaToAlignmentInfoMap == null) {
        formulaToAlignmentInfoMap = new HashMap<>();
        formulaToAlignmentInfoMap.put(new Pair<>(formula, source), uEntry);
        lexemeToEntryMap.put(nl, formulaToAlignmentInfoMap);
      } else {
       // assumes same name and formula appear only once in the file
        formulaToAlignmentInfoMap.put(new Pair<>(formula, source), uEntry);
      }
    }
  }

  @Override
  public void run() {
    try {
      UnaryAlignmentManager uam = new UnaryAlignmentManager();
      LogInfo.begin_track("getting the releveant ids");
      uam.step1GetIdsInTupleFile();
      LogInfo.end_track();
      LogInfo.begin_track("getting id to unaries");
      uam.step2GetIdToUnaries();
      LogInfo.end_track();
      LogInfo.begin_track("Generating graph");
      uam.step3GenerateBigraph();
      LogInfo.end_track();
      LogInfo.begin_track("Saving graph");
      uam.step4SaveAlignmentFile();
      LogInfo.end_track();
      saveUnaryLexiconFromStringFileAndAlignmentFile(outAlignmentFile, unaryInfoStringFile, outLexFile);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }

  }

}