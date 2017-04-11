import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import jdk.internal.cmm.SystemResourcePressureImpl;
import net.sf.tweety.lp.asp.solver.Clingo;
import net.sf.tweety.lp.asp.solver.DLV;
import net.sf.tweety.lp.asp.solver.SolverBase;
import net.sf.tweety.lp.asp.solver.SolverException;
import net.sf.tweety.lp.asp.syntax.Program;
import net.sf.tweety.lp.asp.util.AnswerSetList;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Created by ftm13 on 09/04/17.
 */
public class Play {
    public static void main(String args[]) {

        String rule = "happensAt(remove_col(red), 1).";
        try {
            ClingoWrapper clingoWrapper = new ClingoWrapper("/homes/ftm13/project/examples/remove_1.lp");
            clingoWrapper.execute(new WorldState(), rule);
        }
        catch(Exception e){}

//        DLV solver = new DLV("/homes/ftm13/bin/dlv");
//
//        String program = "motive(harry).";
//
//        try {
//            AnswerSetList answers = solver.computeModels(new ArrayList<String>(Arrays.asList("/homes/ftm13/project/examples/remove_ec_example.lp")),1);
//            System.out.println(answers);
//        }
//        catch (SolverException ex) {
//            System.out.println("Something went wrong");
//        }

        System.out.println("finished.");
    }
}