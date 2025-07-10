@Query("SELECT e FROM Employee e WHERE e.permanent = 1")
List<Employee> getAllPermanentEmployees();
@Query("SELECT e FROM Employee e LEFT JOIN FETCH e.department d LEFT JOIN FETCH e.skillList WHERE e.permanent = 1")
List<Employee> getAllPermanentEmployees();
@Query("SELECT AVG(e.salary) FROM Employee e WHERE e.department.id = :id")
double getAverageSalary(@Param("id") int id);
@Query(value = "SELECT * FROM employee", nativeQuery = true)
List<Employee> getAllEmployeesNative();
