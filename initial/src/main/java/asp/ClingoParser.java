package asp;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by ftm13 on 18/04/17.
 * Parses the output of CLingo ASP version 4.3.0
 * Current functionality supports parsing
 */
public class ClingoParser {

    public PredicateTree parsePredicate(String pred) {
        //System.out.println(pred);
        int firstRoundBracket = pred.indexOf('(');
        if(firstRoundBracket == -1) {
            //System.out.println("Found a literal " + pred);
            return new PredicateTree(pred, true);
        } else {
            // ex name = holdsAt
            String name = pred.substring(0, firstRoundBracket);
            //System.out.println(name);

            PredicateTree predTree = new PredicateTree(name, false);

            // Remove the outer brackets
            // Remaining is like on(b1,s1),1 -> i.e. the arguments of holdsAt
            String remaining = pred.substring(firstRoundBracket + 1, pred.length() - 1);

            //System.out.println(remaining);

            // Split them into individual arguments
            // ex on(b1,s1) and 1 and then parse each recursively
            List<String> args = splitPredArgs(remaining);

            for (String arg : args) {
                //System.out.print(arg + ' ');
                PredicateTree childArg = parsePredicate(arg);
                childArg.parent = predTree;
                predTree.args.add(childArg);
            }

            return predTree;

        }
    }

    public List<String> splitPredArgs(String remaining) {
        int start = 0;
        int brackets = 0;
        List<String> args = new LinkedList<String>();

        for(int i = 0; i < remaining.length(); i++) {

            // Deal with open and closed brackets first
            if(remaining.charAt(i) == '(') {
                brackets++;
            } else if(remaining.charAt(i) == ')') {
                brackets--;
                if(brackets == 0) {
                    args.add(remaining.substring(start, i + 1));

                    // Check if there is anything left
                    if( (i+1) < remaining.length()) {
                        // The next element must be a comma which we can skip
                        assert (remaining.charAt(i+1) == ',');
                        start = i + 2;
                        i = i + 1;
                    } else {
                        // We are done so just return
                        return args;
                    }
                }
            } else if(remaining.charAt(i) == ',' && brackets == 0) {
                // Deal with commas outside brackets
                args.add(remaining.substring(start, i));

                // Since the current elem is a coma we set start to i+1
                start = i + 1;
            }
        }

        // Add very last element as well as this is not accounted for
        args.add(remaining.substring(start, remaining.length()));
        //System.out.println("The args are" + args.toString());

        return args;
    }

    public class PredicateTree {
        public String name;
        public boolean isLiteral = false;
        public PredicateTree parent = null;
        public List<PredicateTree> args = new LinkedList<PredicateTree>();

        public PredicateTree(String name) {
            this.name = name;
        }

        public PredicateTree(String pred, boolean isLiteral) {
            this.name = pred;
            this.isLiteral = isLiteral;
        }
    }
}
