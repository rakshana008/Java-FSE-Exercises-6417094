// RevenueProjection.java

public class RevenueProjection {

    public static void main(String[] args) {
        // Sample revenue growth over 5 months
        double[] revenueList = {1000.0, 1100.0, 1210.0, 1331.0, 1464.1};

        // Calculate total earnings
        double totalRevenue = 0;
        for (double monthly : revenueList) {
            totalRevenue += monthly;
        }

        // Calculate average monthly earnings
        double averageRevenue = totalRevenue / revenueList.length;

        // Output the results
        System.out.println("📊 Estimated total income: ₹" + totalRevenue);
        System.out.println("📈 Average monthly income: ₹" + averageRevenue);
    }
}
