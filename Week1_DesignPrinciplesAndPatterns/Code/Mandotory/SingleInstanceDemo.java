// SingleInstanceDemo.java
public class SingleInstanceDemo {
    // Holds the single instance of this class
    private static SingleInstanceDemo singleObject;

    // Private constructor to prevent outside object creation
    private SingleInstanceDemo() {
        System.out.println("A single instance is initialized.");
    }

    // Method to return the same instance every time
    public static SingleInstanceDemo getOnlyInstance() {
        if (singleObject == null) {
            singleObject = new SingleInstanceDemo();
        }
        return singleObject;
    }

    // A simple method to demonstrate the class functionality
    public void displayMessage() {
        System.out.println("Welcome to Singleton Pattern!");
    }

    public static void main(String[] args) {
        // Try to get the instance twice
        SingleInstanceDemo firstCall = SingleInstanceDemo.getOnlyInstance();
        SingleInstanceDemo secondCall = SingleInstanceDemo.getOnlyInstance();

        // Call method using the instance
        firstCall.displayMessage();

        // Check if both references point to the same object
        System.out.println("Are both instances the same? " + (firstCall == secondCall));
    }
}
