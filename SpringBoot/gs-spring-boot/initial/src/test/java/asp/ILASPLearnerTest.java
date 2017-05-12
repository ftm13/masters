package asp;

import org.junit.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

/**
 * Created by ftm13 on 27/04/17.
 */
public class ILASPLearnerTest {
    @Test
    public void testRemoveCol() throws Exception {

        // Create the knowledge base
        KnowledgeBase kb = new
                KnowledgeBase("/home/ftm13/SpringBoot/gs-spring-boot/initial/src/main/resources/testLearner.lp");

        ILASPLearner learner = new ILASPLearner(kb);

        learner.addBias("#modeb(1, happensAt(remove_col(var(col)), var(time))).");

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

        //Create the examples
        List<String> initialState = Arrays.asList(
                "holdsAt(on(b1, s1), 1).",
                "holdsAt(on(b2, b1), 1).",
                "holdsAt(on(b3, s2), 1).",
                "holdsAt(on(b4, b3), 1).",

                "holdsAt(block_col(b1, red), 1).",
                "holdsAt(block_col(b2, black), 1).",
                "holdsAt(block_col(b3, red), 1).",
                "holdsAt(block_col(b4, black), 1)."
        );

        List<String> targetState = Arrays.asList(
                "goalState(on(b1, s1)).",
                "goalState(on(b3, s2)).",

                "goalState(block_col(b1, red)).",
                "goalState(block_col(b2, black)).",
                "goalState(block_col(b3, red)).",
                "goalState(block_col(b4, black))."
        );

        String action = "happensAt(remove_col(black), 1).";

        ITrainingExample ex1 = new BlocksTrainingExample(initialState, targetState, action, true);
        learner.addExample(ex1);

        initialState = Arrays.asList(
                "holdsAt(on(b1, s1), 1).",
                "holdsAt(on(b2, b1), 1).",
                "holdsAt(on(b3, s2), 1).",
                "holdsAt(on(b4, b3), 1).",

                "holdsAt(block_col(b1, red), 1).",
                "holdsAt(block_col(b2, red), 1).",
                "holdsAt(block_col(b3, red), 1).",
                "holdsAt(block_col(b4, black), 1)."
        );

        targetState = Arrays.asList(
                "goalState(on(b1, s1)).",
                "goalState(on(b2, b1)).",
                "goalState(on(b3, s2)).",

                "goalState(block_col(b1, red)).",
                "goalState(block_col(b2, red)).",
                "goalState(block_col(b3, red)).",
                "goalState(block_col(b4, black))."
        );

        action = "happensAt(remove_col(black), 1).";

        ITrainingExample ex2 = new BlocksTrainingExample(initialState, targetState, action, true);
        learner.addExample(ex2);

        initialState = Arrays.asList(
                "holdsAt(on(b1, s1), 1).",
                "holdsAt(on(b2, b1), 1).",
                "holdsAt(on(b3, b2), 1).",
                "holdsAt(on(b4, s2), 1).",

                "holdsAt(block_col(b1, red), 1).",
                "holdsAt(block_col(b2, red), 1).",
                "holdsAt(block_col(b3, red), 1).",
                "holdsAt(block_col(b4, black), 1)."
        );

        targetState = Arrays.asList(
                "goalState(on(b1, s1)).",
                "goalState(on(b2, b1)).",
                "goalState(on(b4, s2)).",

                "goalState(block_col(b1, red)).",
                "goalState(block_col(b2, red)).",
                "goalState(block_col(b3, red)).",
                "goalState(block_col(b4, black))."
        );

        action = "happensAt(remove_col(red), 1).";

        ITrainingExample ex3 = new BlocksTrainingExample(initialState, targetState, action, true);
        learner.addExample(ex3);

        initialState = Arrays.asList(
                "holdsAt(on(b1, s1), 1).",
                "holdsAt(on(b2, b1), 1).",

                "holdsAt(block_col(b1, red), 1).",
                "holdsAt(block_col(b2, black), 1)."
        );

        targetState = Arrays.asList(
                "goalState(on(b1, s1)).",
                "goalState(on(b2, b1)).",

                "goalState(block_col(b1, red)).",
                "goalState(block_col(b2, black))."
        );

        action = "happensAt(remove_col(red), 1).";

        ITrainingExample ex4 = new BlocksTrainingExample(initialState, targetState, action, true);
        learner.addExample(ex4);

        initialState = Arrays.asList(
                "holdsAt(on(b1, s1), 1).",
                "holdsAt(on(b2, s2), 1).",
                "holdsAt(on(b3, s3), 1).",
                "holdsAt(on(b4, s4), 1).",

                "holdsAt(block_col(b1, red), 1).",
                "holdsAt(block_col(b2, red), 1).",
                "holdsAt(block_col(b3, red), 1).",
                "holdsAt(block_col(b4, black), 1)."
        );

        targetState = Arrays.asList(
                "goalState(on(b4, s4)).",

                "goalState(block_col(b1, red)).",
                "goalState(block_col(b2, red)).",
                "goalState(block_col(b3, red)).",
                "goalState(block_col(b4, black))."
        );

        action = "happensAt(remove_col(red), 1).";

        ITrainingExample ex5 = new BlocksTrainingExample(initialState, targetState, action, true);
        learner.addExample(ex5);

        initialState = Arrays.asList(
                "holdsAt(on(b1, s1), 1).",
                "holdsAt(on(b2, b1), 1).",

                "holdsAt(block_col(b1, red), 1).",
                "holdsAt(block_col(b2, black), 1)."
        );

        targetState = Arrays.asList(
                "goalState(on(b2, s1)).",

                "goalState(block_col(b1, red)).",
                "goalState(block_col(b2, black))."
        );

        action = "happensAt(remove_col(red), 1).";

        ITrainingExample ex6 = new BlocksTrainingExample(initialState, targetState, action, false);
        learner.addExample(ex6);

        initialState = Arrays.asList(
                "holdsAt(on(b1, s1), 1).",
                "holdsAt(block_col(b1, red), 1)."
        );

        targetState = Arrays.asList(
                "goalState(block_col(b1, red))."
        );

        action = "happensAt(remove_col(black), 1).";

        ITrainingExample ex7 = new BlocksTrainingExample(initialState, targetState, action, false);
        learner.addExample(ex7);

        String hyp = learner.getHypothesis();

        assert(hyp.equals("terminateAt(on(V0, V1), V2) :- holdsAt(on(V0, V1), V2), " +
                "not holdsAt2(covered(V0), V2), " +
                "holdsAt(block_col(V0, V3), V2), happensAt(remove_col(V3), V2)."));
    }
}