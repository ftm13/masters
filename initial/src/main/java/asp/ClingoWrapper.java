package asp;

import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;
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
    private final String FILE_FOR_EXECUTION = "/home/ftm13/masters/initial/src/main/resources/scenario.lp";

    // Path to file storing the background knowledge
    private String backgroundKnowledge;

    public ClingoWrapper(String file) {
        this.backgroundKnowledge = file;
    }

    public List<String> execute(WorldState ws, String action) {
        String aspWS = ws.toASP();

        try {
            // Write the new scenario to a random file
            PrintWriter writer = new PrintWriter(FILE_FOR_EXECUTION, "UTF-8");
            writer.println(aspWS);
            writer.println(action);
            writer.close();

            // Run clingo
            Process p = Runtime.getRuntime().
                    exec("clingo --outf=2 " + backgroundKnowledge + " " + FILE_FOR_EXECUTION);
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

    public List<String> execute(Scenario scenario) {
        List<String> result = null;
        StringBuilder stringBuilder = new StringBuilder();
        scenario.getPredicates().forEach(p -> stringBuilder.append(p).append(System.lineSeparator()));
        stringBuilder.append(scenario.getAction()).append(System.lineSeparator());
        try {
            // Write the new scenario to a random file
            PrintWriter writer = new PrintWriter(FILE_FOR_EXECUTION, "UTF-8");
            writer.println(stringBuilder.toString());
            writer.close();

            // Run clingo
            Process p = Runtime.getRuntime().
                    exec("clingo --outf=2 " + backgroundKnowledge + " " + FILE_FOR_EXECUTION);
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

            result = predicates;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
