package server;

import asp.BlocksTrainingExample;
import asp.ITrainingExample;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;

/**
 * Created by ftm13 on 26/04/17.
 */
public class BlocksTrainingExampleTest {
    @Test
    public void generateContext() throws Exception {
//        #pos({}, {}, {
//                holdsAt(on(b1, s1), 1).
//                        holdsAt(on(b2, b1), 1).
//
//                        holdsAt(block_col(b1, red), 1).
//                        holdsAt(block_col(b2, black), 1).
//
//                        happensAt(remove_col(red), 1).
//
//                        goalState(on(b1, s1)).
//                        goalState(on(b2, b1)).
//
//                        goalState(block_col(b1, red)).
//                        goalState(block_col(b2, black)).
//        }).

        List<String> original = Arrays.asList(
                "holdsAt(on(b1, s1), 1).",
                "holdsAt(on(b2, b1), 1).",
                "holdsAt(block_col(b1, red), 1).",
                "holdsAt(block_col(b2, black), 1)."
                );

        List<String> target = Arrays.asList(
                "goalState(on(b1, s1)).",
                "goalState(on(b2, b1)).",
                "goalState(block_col(b1, red)).",
                "goalState(block_col(b2, black))."
        );

        String action = "happensAt(remove_col(red), 1).";

        ITrainingExample example = new BlocksTrainingExample(original, target, action, true);
        System.out.println(example.generateContext());
    }

}