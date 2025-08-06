import java.util.Arrays;

class Product {
    String productId, productName, category;

    Product(String id, String name, String cat) {
        this.productId = id;
        this.productName = name;
        this.category = cat;
    }
}

public class Exercise2 {
    public static boolean linearSearch(Product[] products, String name) {
        for (Product p : products) {
            if (p.productName.equalsIgnoreCase(name))
                return true;
        }
        return false;
    }

    public static boolean binarySearch(Product[] products, String name) {
        int low = 0, high = products.length - 1;
        while (low <= high) {
            int mid = (low + high) / 2;
            int cmp = products[mid].productName.compareToIgnoreCase(name);
            if (cmp == 0)
                return true;
            else if (cmp < 0)
                low = mid + 1;
            else
                high = mid - 1;
        }
        return false;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product("P1", "Apple", "Fruits"),
            new Product("P2", "Banana", "Fruits"),
            new Product("P3", "Carrot", "Vegetables")
        };
        Arrays.sort(products, (a, b) -> a.productName.compareToIgnoreCase(b.productName));

        System.out.println("Linear: " + linearSearch(products, "Carrot"));  // O(n)
        System.out.println("Binary: " + binarySearch(products, "Banana"));  // O(log n)
    }
}
