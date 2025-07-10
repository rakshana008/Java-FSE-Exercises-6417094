interface CustomerRepository {
    String findCustomerById(int id);
}

class CustomerRepositoryImpl implements CustomerRepository {
    public String findCustomerById(int id) {
        return "Customer#" + id;
    }
}

class CustomerService {
    private CustomerRepository repo;

    CustomerService(CustomerRepository repo) {
        this.repo = repo;
    }

    void getCustomer(int id) {
        System.out.println("Found: " + repo.findCustomerById(id));
    }
}

public class DependencyInjectionExample {
    public static void main(String[] args) {
        CustomerRepository repo = new CustomerRepositoryImpl();
        CustomerService service = new CustomerService(repo);
        service.getCustomer(1);
    }
}
