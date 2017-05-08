package asp;

/**
 * Created by ftm13 on 27/04/17.
 * For now it's just a wrapper for string
 */
public class LearningBias implements IBias {
    private final String bias;

    public LearningBias(String bias) {
        this.bias = bias;
    }

    @Override
    public String getBias() {
        return this.bias;
    }
}

