public interface CountryRepository extends JpaRepository<Country, String> {
    List<Country> findByNameContaining(String keyword);
    List<Country> findByNameContainingOrderByNameAsc(String keyword);
    List<Country> findByNameStartingWith(String letter);
}
