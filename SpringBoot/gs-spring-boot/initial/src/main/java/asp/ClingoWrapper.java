package asp;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by ftm13 on 10/04/17.
 */
public class ClingoWrapper {

    // Path to file storing the background knowledge
    private String backgroundKnowledge;

    public ClingoWrapper(String file) {
        this.backgroundKnowledge = file;
    }

    public List<String> execute(WorldState ws, String action) {
        String aspWS = ws.toASP();

        try {
            // Write the new scenario to a random file
            PrintWriter writer = new PrintWriter("/homes/ftm13/project/examples/scenario.lp", "UTF-8");
            writer.println(aspWS);
            writer.println(action);
            writer.close();

            // Run clingo
            Process p = Runtime.getRuntime().
                    exec("clingo --outf=2 " + backgroundKnowledge + " /homes/ftm13/project/examples/scenario.lp");
            p.waitFor();

            // Read the clingo output
            BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line = reader.readLine();
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append(line);

            while (line != null) {
                System.out.println(line);
                line = reader.readLine();
                jsonBuilder.append(line);
            }

            String jsonData = jsonBuilder.toString();

            // Build the json file
            final JSONObject obj = new JSONObject(jsonData);
            final JSONObject callData = (JSONObject) obj.getJSONArray("Call").get(0);
            final JSONObject witnesses = (JSONObject) callData.getJSONArray("Witnesses").get(0);
            final JSONArray values = witnesses.getJSONArray("Value");

            List<String> predicates = new LinkedList<String>();
            for (int i = 0; i < values.length(); i++) {
                predicates.add(values.getString(i));
            }

            System.out.println("All is good and happy!");
            System.out.println(values.toString());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return null;
    }
}
