import java.util.*;

interface Observer {
    void update(float price);
}

class MobileApp implements Observer {
    public void update(float price) {
        System.out.println("Mobile App: New price is ₹" + price);
    }
}

class StockMarket {
    private List<Observer> observers = new ArrayList<>();
    private float stockPrice;

    void register(Observer o) { observers.add(o); }

    void setPrice(float price) {
        this.stockPrice = price;
        notifyAllObservers();
    }

    void notifyAllObservers() {
        for (Observer o : observers) {
            o.update(stockPrice);
        }
    }
}

public class ObserverPatternExample {
    public static void main(String[] args) {
        StockMarket market = new StockMarket();
        market.register(new MobileApp());
        market.setPrice(120.5f);
    }
}
