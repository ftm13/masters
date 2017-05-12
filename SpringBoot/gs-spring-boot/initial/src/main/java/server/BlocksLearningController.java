package server;

import asp.BlocksTrainingExample;
import asp.ILASPLearner;
import org.springframework.web.bind.annotation.*;

@RestController
public class BlocksLearningController {

    ILASPLearner learner = new ILASPLearner();

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

        if(hyp.equals("")) { hyp = "Couldn't figure the rule out...";}
        System.out.println(hyp);
        if(hyp == null) return "THERE WAS A PROBLEM ON THE SERVER SIDE, SORRY";
        else return hyp;
    }

}
