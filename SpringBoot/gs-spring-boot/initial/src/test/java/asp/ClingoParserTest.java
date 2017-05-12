package asp;

import org.junit.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.assertTrue;

/**
 * Created by ftm13 on 18/04/17.
 */
public class ClingoParserTest {

    private ClingoParser parser = new ClingoParser();

    @Test
    public void testSplitPredArgs() {
        String pred1 = "arg1";
        List<String> res1 = Arrays.asList("arg1");

        String pred2 = "arg1,arg2";
        List<String> res2 = Arrays.asList("arg1", "arg2");

        String pred3 = "on(b1,b2),t";
        List<String> res3 = Arrays.asList("on(b1,b2)", "t");

        List<String> predicates = Arrays.asList(pred1, pred2, pred3);
        List<List<String>> results = Arrays.asList(res1, res2, res3);

        for(int i = 0; i < predicates.size(); i++) {
            List<String> args = parser.splitPredArgs(predicates.get(i));
            assertTrue("Lists are not equal! " + args.toString() + " " +
                    results.get(i).toString(), args.equals(results.get(i)));
        }
    }

    @Test
    public void testParsePredicate() {
        String predicate = "holdsAt(on(b1,b2),2)";

        ClingoParser.PredicateTree predicateTree = parser.parsePredicate(predicate);

        assert (predicateTree.name.equals("holdsAt"));
        assert (predicateTree.args.size() == 2);

        ClingoParser.PredicateTree leftArg = predicateTree.args.get(0);
        assert (leftArg.name.equals("on"));
        assert (leftArg.args.size() == 2);

        ClingoParser.PredicateTree leftArg1 = leftArg.args.get(0);
        assert (leftArg1.args.size() == 0);
        assert (leftArg1.name.equals("b1"));

        ClingoParser.PredicateTree leftArg2 = leftArg.args.get(1);
        assert (leftArg2.args.size() == 0);
        assert (leftArg2.name.equals("b2"));

        ClingoParser.PredicateTree rightArg = predicateTree.args.get(1);
        assert (rightArg.args.size() == 0);
        assert (rightArg.name.equals("2"));
    }

}