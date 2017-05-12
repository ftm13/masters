package asp;

/**
 * Created by ftm13 on 09/04/17.
 */
public class Play {
    public static void main(String args[]) {

        String rule = "happensAt(remove_col(red), 1).";
        try {
            ClingoWrapper clingoWrapper = new ClingoWrapper("/home/ftm13/masters/Logic/remove_1.lp");
            clingoWrapper.execute(new WorldState(), rule);
        }
        catch(Exception e){
            e.printStackTrace();
        }

        System.out.println("finished.");
    }
}