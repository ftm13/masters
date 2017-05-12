package asp;

import java.util.List;

/**
 * Created by ftm13 on 09/05/17. This is a blocks world scenario.
 * It has a set of predicates that describe the initial state and
 * an action.
 * The clingo wrapper will then be used in order to generate the
 * required results after performing a given action
 */
public class Scenario {
    private List<String> predicates;
    private String action;

    public List<String> getPredicates() {
        return predicates;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public void setPredicates(List<String> predicates) {
        this.predicates = predicates;
    }
}
