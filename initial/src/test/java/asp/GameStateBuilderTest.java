package asp;

import org.junit.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.assertTrue;

/**
 * Below is the mapping between colors and numbers:
 * cyan - 0
 * brown - 1
 * red - 2
 * orange - 3
 * yellow - 4
 */
public class GameStateBuilderTest {
    private ClingoParser parser = new ClingoParser();
    private GameStateBuilder gameStateBuilder = new GameStateBuilder(parser);

    @Test
    public void testBuildSimple() {
        List<String> predicates = Arrays.asList(
                "holdsAt(on(b1,s1),1)",
                "holdsAt(on(b2,s2),1)",
                "holdsAt(block_col(b1,red),1)",
                "holdsAt(block_col(b2,yellow),1)"
        );

        List<List<Integer>> wall = gameStateBuilder.build(predicates, 1);
        assertTrue("The output does not match!", wall.toString().equals("[[2], [4]]"));
    }

    @Test
    public void testBuildTime() {
        List<String> predicates = Arrays.asList(
                "holdsAt(on(b1,s1),1)",
                "holdsAt(on(b2,s2),1)",
                "holdsAt(block_col(b1,red),1)",
                "holdsAt(block_col(b2,yellow),1)",
                "holdsAt(on(b1,s1),2)",
                "holdsAt(on(b2,s2),2)",
                "holdsAt(block_col(b1,brown),2)",
                "holdsAt(block_col(b2,orange),2)"
        );

        List<List<Integer>> wall = gameStateBuilder.build(predicates, 2);
        assertTrue("The output does not match!", wall.toString().equals("[[1], [3]]"));
    }

    @Test
    public void testBuildScenario1() {
        List<String> predicates = Arrays.asList(
                "holdsAt(on(b1,s1),1)",
                "holdsAt(on(b2,b1),1)",
                "holdsAt(on(b3,b2),1)",
                "holdsAt(on(b4,s2),1)",
                "holdsAt(block_col(b1,brown),1)",
                "holdsAt(block_col(b2,orange),1)",
                "holdsAt(block_col(b3,red),1)",
                "holdsAt(block_col(b4,yellow),1)"
        );

        List<List<Integer>> wall = gameStateBuilder.build(predicates, 1);
        assertTrue("The output does not match!", wall.toString().equals("[[1, 3, 2], [4]]"));
    }

    @Test
    public void testEmptyStack() {
        List<String> predicates = Arrays.asList(
                "holdsAt(on(b1,s1),1)",
                "holdsAt(on(b2,b1),1)",
                "holdsAt(block_col(b1,red),1)",
                "holdsAt(block_col(b2,yellow),1)"
        );
    }

}