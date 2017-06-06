package server;

import asp.*;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class BlocksLearningController {
    private final String KB_FILE_NAME = "/home/ftm13/masters/initial/src/main/resources/kb.lp";

    ILASPLearner learner = new ILASPLearner(KB_FILE_NAME);
    ClingoWrapper wrapper = new ClingoWrapper("/home/ftm13/masters/Logic/remove_1.lp");
    GameStateBuilder gameStateBuilder;
    private String currentHyp = "";

    public BlocksLearningController() {
        ClingoParser clingoParser = new ClingoParser();
        this.gameStateBuilder = new GameStateBuilder(clingoParser);
    }

    @RequestMapping("/greeting")
    public String index() {
        return "Greetings from Spring Boot!";
    }

    @RequestMapping("/cool") 
    public String cool() {
        return "You are really cool man!";
    }

    @RequestMapping(value = "/greeting2", method = RequestMethod.GET)
    public String square(@RequestParam(value="name", defaultValue="World") String name) {
        return "Hello " + name;
    }

    @RequestMapping(value = "/add-training-example", method=RequestMethod.POST)
    public boolean addTrainigExample(@RequestBody BlocksTrainingExample example) {
        learner.addExample(example);
        System.out.println(example.isPositive());
        System.out.println("Added " + example.generateContext());
        return true;
    }

    @RequestMapping(value = "/test-curr-hyp", method=RequestMethod.POST)
    public List<List<Integer>> testCurrentHypothesis(@RequestBody Scenario initialState) {
        initialState.getPredicates().forEach(p -> System.out.println(p));
        System.out.println(initialState.getAction());
        List<String> clingoOutput = this.wrapper.execute(initialState);
        System.out.println(clingoOutput.toString());
        List<List<Integer>> finalState = gameStateBuilder.build(clingoOutput,2);
        System.out.println(finalState);
        return finalState;
    }

    @RequestMapping(value = "/perform-learning", method = RequestMethod.GET)
    public String performLearning(@RequestParam(value="ruleName", defaultValue = "") String ruleName){
        // The rule name must not be empty, and this has to be enforced on the server side
        assert(!ruleName.equals(""));

        System.out.println(ruleName);
        // The rule has to be processed so it looks like this
        // #modeb(1, happensAt(remove_col(var(col)), var(time))).
        String bias = "#modeb(1, " + ruleName + ").";
        learner.addBias(bias);

        String hyp = learner.getHypothesis();
        this.currentHyp = hyp;

        if(hyp.equals("")) { hyp = "Couldn't figure the rule out...";}
        System.out.println(hyp);
        if(hyp == null) return "THERE WAS A PROBLEM ON THE SERVER SIDE, SORRY";
        else return hyp;
    }

}
