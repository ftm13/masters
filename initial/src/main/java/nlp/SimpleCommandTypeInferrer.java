package nlp;
import edu.stanford.nlp.coref.CorefCoreAnnotations;
import edu.stanford.nlp.coref.data.CorefChain;
import edu.stanford.nlp.ling.CoreAnnotations.*;
import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.ling.IndexedWord;
import edu.stanford.nlp.pipeline.*;
import edu.stanford.nlp.semgraph.SemanticGraph;
import edu.stanford.nlp.semgraph.SemanticGraphCoreAnnotations;
import edu.stanford.nlp.semgraph.SemanticGraphEdge;
import edu.stanford.nlp.trees.*;
import edu.stanford.nlp.trees.TreeCoreAnnotations.*;
import edu.stanford.nlp.util.CoreMap;
import edu.stanford.nlp.util.Index;

import java.util.*;

public class SimpleCommandTypeInferrer {

    public StanfordCoreNLP pipeline;

    SimpleCommandTypeInferrer() {
        // creates a StanfordCoreNLP object, with POS tagging, lemmatization, NER, parsing, and coreference resolution
        Properties props = new Properties();
        props.setProperty("annotators", "tokenize, ssplit, pos, lemma, ner, parse, dcoref");
        this.pipeline = new StanfordCoreNLP(props);
    }

    // Assumes at least one command is sent and each command contains 1 sentence
    // The name of the command is a combination between the predicate and the direct object
    public String findPredicateName(List<String> commands) {
        assert(!commands.isEmpty());
        String fstCommand = commands.get(0);

        // create an empty Annotation just with the given text
        Annotation document = new Annotation(fstCommand);

        // run all Annotators on this text
        pipeline.annotate(document);

        // these are all the sentences in this document
        // a CoreMap is essentially a Map that uses class objects as keys and has values with custom types
        List<CoreMap> sentences = document.get(SentencesAnnotation.class);

        Tree tree = null;
        SemanticGraph dependencies = null;

        TreebankLanguagePack tlp = new PennTreebankLanguagePack();
        // Uncomment the following line to obtain original Stanford Dependencies
        // tlp.setGenerateOriginalDependencies(true);
        GrammaticalStructureFactory gsf = tlp.grammaticalStructureFactory();

        for(CoreMap sentence: sentences) {
            // this is the parse tree of the current sentence
            tree = sentence.get(TreeAnnotation.class);

            System.out.println(tree);

            // this is the Stanford dependency graph of the current sentence
            GrammaticalStructure gs = gsf.newGrammaticalStructure(tree);
            Collection tdl = gs.typedDependenciesCCprocessed();
            dependencies = new SemanticGraph(tdl);

            break; //We assume only one sentence for now
        }

        // TODO: What to do if the stuff is null??

        // The root predicate forms the first part of the name
        StringBuilder builder = new StringBuilder();
        String rootName = dependencies.getFirstRoot().originalText();
        builder.append(rootName);

        // Append an underscore:
        builder.append("_");

        // Append the direct object
        List<SemanticGraphEdge> dirObjs = dependencies.findAllRelns(UniversalEnglishGrammaticalRelations.DIRECT_OBJECT);
        String dirObj = dirObjs.get(0).getDependent().originalText();
        builder.append(dirObj);

        // Check if the dir object has any adjectives or other sorts of determiners
        IndexedWord dirObjIndex = dirObjs.get(0).getDependent();
        IndexedWord adjOfDirObjIndex = dependencies.getChildWithReln(dirObjIndex, UniversalEnglishGrammaticalRelations.ADJECTIVAL_MODIFIER);

        if (adjOfDirObjIndex != null && !isColour(adjOfDirObjIndex.originalText())) {
            String adjofDirObj = adjOfDirObjIndex.originalText();

            builder.append("_").append(adjofDirObj);
        }

        return builder.toString();
    }

    private boolean isColour(String s) {
        List<String> colours = Arrays.asList("red", "blue", "yellow", "orange", "brown");
        return colours.contains(s);
    }


    public static void main(String[] args) {

        SimpleCommandTypeInferrer cmdInferrer = new SimpleCommandTypeInferrer();

        // read some text in the text variable
        String text = "remove the tallest tower";

        // create an empty Annotation just with the given text
        Annotation document = new Annotation(text);

        // run all Annotators on this text
        cmdInferrer.pipeline.annotate(document);

        // these are all the sentences in this document
        // a CoreMap is essentially a Map that uses class objects as keys and has values with custom types
        List<CoreMap> sentences = document.get(SentencesAnnotation.class);

        TreebankLanguagePack tlp = new PennTreebankLanguagePack();
        // Uncomment the following line to obtain original Stanford Dependencies
        // tlp.setGenerateOriginalDependencies(true);
        GrammaticalStructureFactory gsf = tlp.grammaticalStructureFactory();

        for(CoreMap sentence: sentences) {
            // traversing the words in the current sentence
            // a CoreLabel is a CoreMap with additional token-specific methods
            for (CoreLabel token: sentence.get(TokensAnnotation.class)) {
                // this is the text of the token
                String word = token.get(TextAnnotation.class);
                // this is the POS tag of the token
                String pos = token.get(PartOfSpeechAnnotation.class);
                System.out.println(pos);
                // this is the NER label of the token
                String ne = token.get(NamedEntityTagAnnotation.class);
            }

            // this is the parse tree of the current sentence
            Tree tree = sentence.get(TreeAnnotation.class);

            System.out.println(tree);

            // this is the Stanford dependency graph of the current sentence
            SemanticGraph dependencies = sentence.get(SemanticGraphCoreAnnotations.CollapsedCCProcessedDependenciesAnnotation.class);

            System.out.println(dependencies);
            System.out.println(dependencies.getFirstRoot().originalText());
            System.out.println(dependencies.toList());
            GrammaticalRelation directObject = EnglishGrammaticalRelations.DIRECT_OBJECT;
            List<SemanticGraphEdge> allRelns = dependencies.findAllRelns(directObject);
            System.out.println(allRelns);

            System.out.println("Let's see if it works!!");
            // Second try yaay!!
            tree = sentence.get(TreeAnnotation.class);
            GrammaticalStructure gs = gsf.newGrammaticalStructure(tree);
            Collection tdl = gs.typedDependenciesCCprocessed();
            dependencies = new SemanticGraph(tdl);

            System.out.println(dependencies.edgeIterable().iterator().next().getRelation());

            allRelns = dependencies.findAllRelns(UniversalEnglishGrammaticalRelations.DIRECT_OBJECT);
            System.out.println(allRelns.get(0).getDependent().originalText());
            System.out.println(allRelns);
        }

        // This is the coreference link graph
        // Each chain stores a set of mentions that link to each other,
        // along with a method for getting the most representative mention
        // Both sentence and token offsets start at 1!
        Map<Integer, CorefChain> graph =
                        document.get(CorefCoreAnnotations.CorefChainAnnotation.class);

    }

}