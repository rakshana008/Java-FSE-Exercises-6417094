package com.cognizant.ormlearn;

import com.cognizant.ormlearn.handsOn1.Country;
import com.cognizant.ormlearn.handsOn1.CountryRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.List;

@SpringBootApplication
public class OrmLearnApplication implements CommandLineRunner {

    @Autowired
    private CountryRepository countryRepository;

    public static void main(String[] args) {
        SpringApplication.run(OrmLearnApplication.class, args);
    }

    @Override
    public void run(String... args) {
        testSearchByText();
        testSearchSorted();
        testSearchByLetter();
    }

    private void testSearchByText() {
        System.out.println("🔍 Search by containing 'ou'");
        List<Country> result = countryRepository.findByNameContaining("ou");
        result.forEach(System.out::println);
    }

    private void testSearchSorted() {
        System.out.println("🔠 Sorted search by 'ou'");
        List<Country> result = countryRepository.findByNameContainingOrderByNameAsc("ou");
        result.forEach(System.out::println);
    }

    private void testSearchByLetter() {
        System.out.println("🔤 Countries starting with 'Z'");
        List<Country> result = countryRepository.findByNameStartingWith("Z");
        result.forEach(System.out::println);
    }
}
