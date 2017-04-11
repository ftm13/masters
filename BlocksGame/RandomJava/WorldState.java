/**
 * Created by ftm13 on 10/04/17.
 */
public class WorldState {

    public String toASP() {
        return  "holdsAt(on(b1, s1), 1)." +
                "holdsAt(on(b2, s2), 1)." +
                "holdsAt(on(b3, s3), 1)." +
                "holdsAt(on(b4, s4), 1)." +
                "holdsAt(block_col(b1, red), 1)." +
                "holdsAt(block_col(b2, red), 1)." +
                "holdsAt(block_col(b3, red), 1)." +
                "holdsAt(block_col(b4, black), 1).";
    }
}
