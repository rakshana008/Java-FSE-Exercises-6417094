public class Exercise7 {
    public static double futureValue(double currentValue, double growthRate, int years) {
        if (years == 0) return currentValue;
        return futureValue(currentValue * (1 + growthRate), growthRate, years - 1);
    }

    public static void main(String[] args) {
        double current = 10000;
        double rate = 0.05; // 5%
        int years = 3;
        System.out.println("Future Value: ₹" + futureValue(current, rate, years));
    }
}
