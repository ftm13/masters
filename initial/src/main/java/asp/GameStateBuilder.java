package asp;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by ftm13 on 20/04/17.
 */
public class GameStateBuilder {

    private ClingoParser parser;

    public GameStateBuilder(ClingoParser parser) {
        this.parser = parser;
    }

    // If on(b1,b2) holds then b2 -> b1 in the map
    Map<String, String> blockCoveredBy = new HashMap<String, String>();

    Map<String, Integer> blockColour = new HashMap<String, Integer>();

    List<String> stacks = new ArrayList<>();

    // Builds the state of the game at a specified time
    public List<List<Integer>> build (List<String> predicates, int time) {
        blockColour.clear();
        blockCoveredBy.clear();
        stacks.clear();

        List<ClingoParser.PredicateTree> predicateTrees = predicates.stream()
                                                                    .map(p -> parser.parsePredicate(p))
                                                                    .collect(Collectors.toList());

        for(ClingoParser.PredicateTree p : predicateTrees) {
            visit(p, time);
        }

        // Sort the stacks in order
        Comparator<String> stackStringComparator = new Comparator<String>() {
            @Override
            public int compare(String o1, String o2) {
                Integer s1Number = Integer.parseInt(o1.substring(1));
                Integer s2Number = Integer.parseInt(o2.substring(1));

                return s1Number.compareTo(s2Number);
            }
        };

        stacks.sort(stackStringComparator);

        List<List<Integer>> wall = new LinkedList<List<Integer>>();

        // Build each stack and and it to the wall
        for(String s : stacks) {
            List<Integer> stack = new ArrayList<>();

            String curr = s;
            while(true) {
                String block = this.blockCoveredBy.get(curr);
                if(block == null) {
                    break;
                }
                stack.add(blockColour.get(block));
                curr = block;
            }

            wall.add(stack);
        }

        return wall;
    }

    private void visit(ClingoParser.PredicateTree p, int t) {
        switch (p.name) {
            case "holdsAt": visitHoldsAt(p, t);
                            break;
            case "on": visitOn(p, t);
                       break;
            case "block_col": visitBlockColor(p, t);
                               break;
        }
    }

    // In ASP: holdsAt(F,T)
    private void visitHoldsAt(ClingoParser.PredicateTree p, int t) {
        // HoldsAt has to arguments, a Fluent F and a time t
        int time = Integer.parseInt(p.args.get(1).name);

        // Visit the fluent
        if(time == t) p.args.forEach(pred -> visit(pred, t));
    }

    // In ASP: on(b1,b2). When a block is sitting directly above a stack then b2 is of the form s1, s2 etc.
    private void visitOn(ClingoParser.PredicateTree p, int t) {
        // Add b2 -> b1 in the blockCovered by map
        String b1 = p.args.get(0).name;
        String b2 = p.args.get(1).name;

        blockCoveredBy.put(b2, b1);

        // Check if b2 is a stack
        if (b2.charAt(0) == 's') {
            stacks.add(b2);
        }
    }

    // In ASP: block_col(b, col)
    private void visitBlockColor(ClingoParser.PredicateTree p, int t) {
        String block = p.args.get(0).name;
        String col = p.args.get(1).name;

        blockColour.put(block, getColor(col));
    }

    private int getColor(String col) {
        switch (col) {
            case "cyan": return 0;
            case "brown": return 1;
            case "red": return  2;
            case "orange": return 3;
            case "yellow": return 4;
            default: return -1;
        }
    }

}
