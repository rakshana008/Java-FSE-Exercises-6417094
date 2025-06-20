// StrategyPatternDemo.java

interface PaymentStrategy {
    void pay(int amount);
}

class CreditCardPayment implements PaymentStrategy {
    public void pay(int amount) {
        System.out.println("Paid ₹" + amount + " using Credit Card.");
    }
}

class PayPalPayment implements PaymentStrategy {
    public void pay(int amount) {
        System.out.println("Paid ₹" + amount + " using PayPal.");
    }
}

class ShoppingCart {
    private PaymentStrategy paymentMethod;

    public ShoppingCart(PaymentStrategy paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public void checkout(int amount) {
        paymentMethod.pay(amount);
    }
}

public class StrategyPatternDemo {
    public static void main(String[] args) {
        ShoppingCart cart1 = new ShoppingCart(new CreditCardPayment());
        cart1.checkout(2500);

        ShoppingCart cart2 = new ShoppingCart(new PayPalPayment());
        cart2.checkout(1500);
    }
}
