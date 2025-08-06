interface PaymentProcessor {
    void processPayment(String amount);
}

class PayPal {
    void makePayment(String amount) {
        System.out.println("Paid using PayPal: " + amount);
    }
}

class PayPalAdapter implements PaymentProcessor {
    private PayPal paypal = new PayPal();
    public void processPayment(String amount) {
        paypal.makePayment(amount);
    }
}

public class AdapterPatternExample {
    public static void main(String[] args) {
        PaymentProcessor processor = new PayPalAdapter();
        processor.processPayment("₹500");
    }
}
