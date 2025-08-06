interface Notifier {
    void send(String message);
}

class EmailNotifier implements Notifier {
    public void send(String message) {
        System.out.println("Email: " + message);
    }
}

abstract class NotifierDecorator implements Notifier {
    protected Notifier notifier;

    NotifierDecorator(Notifier notifier) {
        this.notifier = notifier;
    }
}

class SMSNotifier extends NotifierDecorator {
    SMSNotifier(Notifier notifier) { super(notifier); }

    public void send(String message) {
        notifier.send(message);
        System.out.println("SMS: " + message);
    }
}

public class DecoratorPatternExample {
    public static void main(String[] args) {
        Notifier notifier = new SMSNotifier(new EmailNotifier());
        notifier.send("Hello User");
    }
}

