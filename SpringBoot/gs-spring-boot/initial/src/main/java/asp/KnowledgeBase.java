package asp;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by ftm13 on 27/04/17.
 */
public class KnowledgeBase {
    // The file name can be used directly for Clingo
    private final String fileName;

    // The list representation can be used for ILASP
    private List<String> asp = new LinkedList<>();

    public KnowledgeBase(String fileName) {
        this.fileName = fileName;
    }

    // Add new rule to the knowledge base
    public boolean addRule(String s) {
        FileWriter fw = null;
        BufferedWriter bw = null;
        boolean success = false;

        try {
            File file = new File(fileName);

            // if file doesnt exists, then create it
            if (!file.exists()) {
                file.createNewFile();
            }

            // true = append file
            fw = new FileWriter(file.getAbsoluteFile(), true);
            bw = new BufferedWriter(fw);

            bw.write(s);
            asp.add(s);

            success = true;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (bw != null)
                    bw.close();

                if (fw != null)
                    fw.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }

            return success;
        }
    }

    public String toAsp() {
        StringBuilder sb = new StringBuilder();
        asp.forEach(rule -> sb.append(rule).append(System.lineSeparator()));
        return sb.toString();
    }
}
