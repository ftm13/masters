package asp;

import java.util.List;

/**
 * Created by ftm13 on 26/04/17.
 * initialState is an ASP encoding of the initial state of the blocks
 * finalState is an ASP encoding of the final state of the blocks
 */
public class BlocksTrainingExample implements ITrainingExample {
    private List<String> initialState;
    private List<String> finalState;
    private String action;
    private boolean positive = true;

    public List<String> getInitialState() {
        return initialState;
    }

    public List<String> getFinalState() {
        return finalState;
    }

    public String getAction() {
        return action;
    }

    public boolean isPositive() {
        return positive;
    }

    public BlocksTrainingExample() {
        // Do nothing this is for the json
    }
    public BlocksTrainingExample(List<String> initialState, List<String> finalState, String action, boolean positive) {
        this.initialState = initialState;
        this.finalState = finalState;
        this.action = action;
        this.positive = positive;
    }

    @Override
    public String generateContext() {
        StringBuilder stringBuilder = new StringBuilder();
        String lineSeparator = System.lineSeparator();

        String type = (positive) ? "#pos({}, {}, {" : "#neg({}, {}, {";
        stringBuilder.append(type).append(lineSeparator);

        // Append the initial state
        initialState.forEach(s -> stringBuilder.append(s).append(lineSeparator));

        // Append the action we are trying to learn
        stringBuilder.append(action).append(lineSeparator);

        // Append the goal state
        finalState.forEach(s -> stringBuilder.append(s).append(lineSeparator));

        // Append the final stuff
        stringBuilder.append("}).").append(lineSeparator);

        return stringBuilder.toString();
    }
}
