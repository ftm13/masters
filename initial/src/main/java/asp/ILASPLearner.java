package asp;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by ftm13 on 27/04/17.
 */
public class ILASPLearner {
    private KnowledgeBase knowledgeBase;

    // Initialise with the biases with the ones we have as per usual
    private List<String> biases = new LinkedList<>(Arrays.asList(
            "#modeh(initAt(on(var(block), var(block)), var(time))).",
            "#modeh(terminateAt(on(var(block), var(block)), var(time))).",
            "#modeb(1, holdsAt(on(var(block), var(block)), var(time))).",
            "#modeb(1, holdsAt2(covered(var(block)), var(time))).",
            "#modeb(1, holdsAt(block_col(var(block), var(col)), var(time))).",
            "#maxv(4)."
    ));

    private List<ITrainingExample> trainingExamples = new LinkedList<>();
    private String action = "";

    // Initialises the default values for everything
    public ILASPLearner() {
        KnowledgeBase kb = new
                KnowledgeBase("/home/ftm13/SpringBoot/gs-spring-boot/initial/src/main/resources/kb.lp");

        List<String> rules = Arrays.asList(
                // Facts
                "time(1..2).",
                "col(black).",
                "col(brown).",
                "col(red).",
                "col(cyan).",
                "col(yellow).",
                "col(orange).",

                // Event calculus rules
                "holdsAt(F, T+1) :- initAt(F,T), time(T).",
                "holdsAt(F, T+1) :- holdsAt(F, T), not terminateAt(F, T), time(T).",
                "holdsAt(F,1) :- initState(F).",

                // Constraints
                ":- holdsAt(F, 2), not goalState(F).",
                ":- not holdsAt(F,2), goalState(F).",

                "holdsAt2(covered(B), T) :- holdsAt(on(B2, B), T), time(T)."
        );

        rules.forEach(r -> kb.addRule(r));

        this.knowledgeBase = kb;

    }

    public ILASPLearner(KnowledgeBase knowledgeBase) {
        this.knowledgeBase = knowledgeBase;
    }

    public KnowledgeBase getKnowledgeBase() {
        return knowledgeBase;
    }

    public void setKnowledgeBase(KnowledgeBase knowledgeBase) {
        this.knowledgeBase = knowledgeBase;
    }

    public List<ITrainingExample> getTrainingExamples() {
        return trainingExamples;
    }


    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public void addExample(ITrainingExample e) {
        trainingExamples.add(e);
    }

    public void addBias(String bias) {
        biases.add(bias);
    }

    public String getHypothesis() {
        try {
            String ilaspfile = "/home/ftm13/SpringBoot/gs-spring-boot/initial/src/main/resources/learningTask.las";

            // Write the learning task to the file
            PrintWriter writer = new PrintWriter(ilaspfile, "UTF-8");

            // Add the knowledge base to the file
            writer.println(knowledgeBase.toAsp());

            // Add the biases
            biases.forEach(b -> writer.println(b));

            //TODO: eventually take into account the action
           // writer.println(action);

            trainingExamples.forEach(e -> writer.println(e.generateContext()));
            writer.close();

            // Run ILASP on quiet mode
            Process p = Runtime.getRuntime().
                    exec("/home/ftm13/bin/ILASP -q -ml=4 " + ilaspfile);
            p.waitFor();

            // Read the ILASP output
            BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line = reader.readLine();
            StringBuilder hypothesisBuilder = new StringBuilder();

            while (line != null) {
                hypothesisBuilder.append(line);
                line = reader.readLine();
            }

            return hypothesisBuilder.toString();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


}
