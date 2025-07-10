package com.cognizant.orm_learn;

import com.cognizant.orm_learn.model.Country;
import com.cognizant.orm_learn.repository.CountryRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

import java.util.List;
import java.util.Optional;


@SpringBootApplication
public class OrmLearnApplication {

    public static void main(String[] args) {
        ApplicationContext context = SpringApplication.run(OrmLearnApplication.class, args);

        CountryRepository countryRepository = context.getBean(CountryRepository.class);

        // ✅ Insert countries for testing
        countryRepository.save(new Country("IN", "India"));
        countryRepository.save(new Country("US", "United States"));

        // ✅ Exercise 3: Display all countries
        System.out.println("✅ All Countries:");
        List<Country> countryList = countryRepository.findAll();
        countryList.forEach(System.out::println);

        // ✅ Exercise 4: Get Country by Code
        System.out.println("\n✅ Country with code 'IN':");
        Optional<Country> countryOptional = countryRepository.findById("IN");
        if (countryOptional.isPresent()) {
            System.out.println(countryOptional.get());
        } else {
            System.out.println("❌ Country with code IN not found.");
        }
		// ✅ Exercise 5: Find countries by substring
System.out.println("\n✅ Countries containing 'ou':");
List<Country> searchResults = countryRepository.findByNameContainingIgnoreCase("ou");
searchResults.forEach(System.out::println);
// ✅ Exercise 6: Add a new country
Country newCountry = new Country("ZZ", "Zoomland");
countryRepository.save(newCountry);
System.out.println("\n✅ New Country Added: " + newCountry);
System.out.println("\n✅ All Countries After Insert:");
countryRepository.findAll().forEach(System.out::println);
// ✅ Exercise 7: Update country
System.out.println("\n✅ Updating Country with code 'ZZ':");
Optional<Country> countryToUpdate = countryRepository.findById("ZZ");

if (countryToUpdate.isPresent()) {
    Country country = countryToUpdate.get();
    country.setName("Zion"); // update name
    countryRepository.save(country); // save the updated country
    System.out.println("✅ Updated Country: " + country);
} else {
    System.out.println("❌ Country with code 'ZZ' not found for update.");
}

// ✅ All Countries After Update
System.out.println("\n✅ All Countries After Update:");
countryRepository.findAll().forEach(System.out::println);


	}
}


    

