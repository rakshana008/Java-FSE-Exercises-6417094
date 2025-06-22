import java.util.HashMap;
import java.util.Scanner;

class Product {
    String productId, productName;
    int quantity;
    double price;

    Product(String id, String name, int qty, double price) {
        this.productId = id;
        this.productName = name;
        this.quantity = qty;
        this.price = price;
    }

    public String toString() {
        return productId + " - " + productName + " - Qty: " + quantity + " - ₹" + price;
    }
}

public class Exercise1 {
    static HashMap<String, Product> inventory = new HashMap<>();

    public static void addProduct(Product p) {
        inventory.put(p.productId, p);
    }

    public static void updateProduct(String id, int qty, double price) {
        if (inventory.containsKey(id)) {
            Product p = inventory.get(id);
            p.quantity = qty;
            p.price = price;
        }
    }

    public static void deleteProduct(String id) {
        inventory.remove(id);
    }

    public static void main(String[] args) {
        addProduct(new Product("P101", "Mouse", 50, 299.99));
        addProduct(new Product("P102", "Keyboard", 20, 499.50));

        updateProduct("P101", 70, 280.00);
        deleteProduct("P102");

        for (Product p : inventory.values()) {
            System.out.println(p);
        }
    }
}
