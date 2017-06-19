//package nlp;
//
//import org.junit.Test;
//
//import java.util.LinkedList;
//import java.util.List;
//
//import static org.junit.Assert.*;
//
///**
// * Created by ftm13 on 05/06/17.
// */
//public class SimpleCommandTypeInferrerTest {
//    private SimpleCommandTypeInferrer cmdInferrer = new SimpleCommandTypeInferrer();
//
//    @Test
//    public void testPredNameSimpleDirectObject() throws Exception {
//        List<String> cmds = new LinkedList<>();
//        String cmd = "";
//        String expectedPred = "";
//
//        cmd = "remove the red blocks";
//        expectedPred = "remove_blocks";
//        cmds.add(cmd);
//        String predName = cmdInferrer.findPredicateName(cmds);
//        assert(expectedPred.equals(predName));
//        cmds.clear();
//
//        cmd = "swap the colour of the red and blue blocks";
//        expectedPred = "swap_colour";
//        cmds.add(cmd);
//        predName = cmdInferrer.findPredicateName(cmds);
//        assert(expectedPred.equals(predName));
//        cmds.clear();
//    }
//
//    @Test
//    public void testPredNamesWithDirObjAndAdjectives() throws Exception {
//        List<String> cmds = new LinkedList<>();
//        String cmd = "";
//        String expectedPred = "";
//        String predName;
//
//        cmd = "remove the tallest tower";
//        expectedPred = "remove_tower_tallest";
//        cmds.add(cmd);
//        predName = cmdInferrer.findPredicateName(cmds);
//        assert(expectedPred.equals(predName));
//        cmds.clear();
//
//        cmd = "remove all red blocks";
//        expectedPred = "remove_blocks_";
//        cmds.add(cmd);
//        predName = cmdInferrer.findPredicateName(cmds);
//        assert(expectedPred.equals(predName));
//        cmds.clear();
////
////        cmd = "shift the tallest stack to the left";
////        expectedPred = "shift_tallest_stack";
////        cmds.add(cmd);
////        predName = cmdInferrer.findPredicateName(cmds);
////        assert(expectedPred.equals(predName));
////        cmds.clear();
//    }
//
//}