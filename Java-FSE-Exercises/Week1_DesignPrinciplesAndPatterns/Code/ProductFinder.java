// ProductFinder.java

public class ProductFinder {

    // This method searches for a product ID in a sorted list using binary search
    public static int searchProduct(int[] productList, int targetId) {
        int start = 0;
        int end = productList.length - 1;

        while (start <= end) {
            int middle = start + (end - start) / 2;

            if (productList[middle] == targetId) {
                return middle; // Found the product
            } else if (productList[middle] < targetId) {
                start = middle + 1;
            } else {
                end = middle - 1;
            }
        }
        return -1; // Product not found
    }

    public static void main(String[] args) {
        // Sample product IDs (already sorted)
        int[] products = {1001, 1005, 1010, 1020, 1050};

        // Product to search for
        int searchFor = 1010;

        // Call the search method
        int indexFound = searchProduct(products, searchFor);

        // Display result
        if (indexFound != -1) {
            System.out.println("✅ Product found at position: " + indexFound);
        } else {
            System.out.println("❌ Product not available in the catalog.");
        }
    }
}
