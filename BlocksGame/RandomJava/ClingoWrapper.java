import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;
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

    public List<WorldState> execute(WorldState ws, String action) {
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

            System.out.println(values.toString());
        } catch(IOException e1) {
        } catch(InterruptedException e2) {}

        return null;
    }
}
