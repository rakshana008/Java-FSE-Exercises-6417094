import java.util.Arrays;

class Book {
    String bookId, title, author;

    Book(String id, String title, String author) {
        this.bookId = id;
        this.title = title;
        this.author = author;
    }
}

public class Exercise6 {
    public static boolean linearSearch(Book[] books, String title) {
        for (Book b : books)
            if (b.title.equalsIgnoreCase(title))
                return true;
        return false;
    }

    public static boolean binarySearch(Book[] books, String title) {
        int low = 0, high = books.length - 1;
        while (low <= high) {
            int mid = (low + high) / 2;
            int cmp = books[mid].title.compareToIgnoreCase(title);
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
        Book[] books = {
            new Book("B1", "Java", "James"),
            new Book("B2", "Python", "Guido"),
            new Book("B3", "C++", "Bjarne")
        };
        Arrays.sort(books, (a, b) -> a.title.compareToIgnoreCase(b.title));
        System.out.println("Linear: " + linearSearch(books, "Java"));
        System.out.println("Binary: " + binarySearch(books, "Python"));
    }
}
