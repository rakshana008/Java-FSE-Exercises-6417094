class Task {
    String taskId, taskName, status;
    Task next;

    Task(String id, String name, String status) {
        this.taskId = id;
        this.taskName = name;
        this.status = status;
    }
}

public class Exercise5 {
    static Task head = null;

    public static void add(String id, String name, String status) {
        Task newTask = new Task(id, name, status);
        newTask.next = head;
        head = newTask;
    }

    public static void delete(String id) {
        Task temp = head, prev = null;
        while (temp != null && !temp.taskId.equals(id)) {
            prev = temp;
            temp = temp.next;
        }
        if (temp != null) {
            if (prev == null)
                head = temp.next;
            else
                prev.next = temp.next;
        }
    }

    public static void traverse() {
        Task temp = head;
        while (temp != null) {
            System.out.println(temp.taskId + " - " + temp.taskName + " - " + temp.status);
            temp = temp.next;
        }
    }

    public static void main(String[] args) {
        add("T1", "Design", "Pending");
        add("T2", "Code", "Done");
        traverse();
        delete("T1");
        traverse();
    }
}
