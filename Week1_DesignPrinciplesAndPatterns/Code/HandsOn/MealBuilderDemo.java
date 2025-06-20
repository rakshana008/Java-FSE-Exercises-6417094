// MealBuilderDemo.java

// Represents a simple meal with a main dish and a drink
class Meal {
    private String mainDish;
    private String beverage;

    public void setMainDish(String dish) {
        this.mainDish = dish;
    }

    public void setBeverage(String drink) {
        this.beverage = drink;
    }

    public void displayMeal() {
        System.out.println("Main Dish: " + mainDish);
        System.out.println("Beverage: " + beverage);
    }
}

// Responsible for building and returning a ready-made meal
class MealCreator {
    public Meal prepareVegetarianMeal() {
        Meal vegMeal = new Meal();
        vegMeal.setMainDish("Grilled Veggie Sandwich");
        vegMeal.setBeverage("Fresh Lemon Juice");
        return vegMeal;
    }
}

// Main class to test the builder logic
public class MealBuilderDemo {
    public static void main(String[] args) {
        MealCreator creator = new MealCreator();
        Meal myMeal = creator.prepareVegetarianMeal();
        myMeal.displayMeal();
    }
}
