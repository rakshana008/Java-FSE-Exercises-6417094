class Employee {
    String employeeId, name, position;
    double salary;

    Employee(String id, String name, String pos, double sal) {
        this.employeeId = id;
        this.name = name;
        this.position = pos;
        this.salary = sal;
    }

    public String toString() {
        return employeeId + " - " + name + " - " + position + " - ₹" + salary;
    }
}

public class Exercise4 {
    static Employee[] employees = new Employee[100];
    static int count = 0;

    public static void add(Employee e) {
        employees[count++] = e;
    }

    public static void search(String id) {
        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId.equals(id)) {
                System.out.println(employees[i]);
                return;
            }
        }
        System.out.println("Not found");
    }

    public static void delete(String id) {
        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId.equals(id)) {
                for (int j = i; j < count - 1; j++) {
                    employees[j] = employees[j + 1];
                }
                employees[--count] = null;
                break;
            }
        }
    }

    public static void traverse() {
        for (int i = 0; i < count; i++) {
            System.out.println(employees[i]);
        }
    }

    public static void main(String[] args) {
        add(new Employee("E101", "John", "Manager", 70000));
        add(new Employee("E102", "Jane", "HR", 50000));
        traverse();
        search("E101");
        delete("E102");
        traverse();
    }
}
