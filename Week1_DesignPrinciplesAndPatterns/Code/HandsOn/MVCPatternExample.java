class Student {
    private String name = "Rakshana";
    private int id = 101;
    private String grade = "A";

    public String getName() { return name; }
    public int getId() { return id; }
    public String getGrade() { return grade; }
}

class StudentView {
    void displayStudentDetails(Student s) {
        System.out.println("Student: " + s.getName() + ", ID: " + s.getId() + ", Grade: " + s.getGrade());
    }
}

class StudentController {
    private Student model;
    private StudentView view;

    StudentController(Student model, StudentView view) {
        this.model = model;
        this.view = view;
    }

    void updateView() {
        view.displayStudentDetails(model);
    }
}

public class MVCPatternExample {
    public static void main(String[] args) {
        Student student = new Student();
        StudentView view = new StudentView();
        StudentController controller = new StudentController(student, view);
        controller.updateView();
    }
}
