package com.cognizant.orm_learn.controller;

import com.cognizant.orm_learn.model.Country;
import com.cognizant.orm_learn.repository.CountryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class CountryController {

    @Autowired
    private CountryRepository countryRepository;

    // ✅ Get all countries
    @GetMapping("/countries")
    public List<Country> getAllCountries() {
        return countryRepository.findAll();
    }

    // ✅ Get a single country by code
    @GetMapping("/countries/{code}")
    public Country getCountryByCode(@PathVariable String code) {
        return countryRepository.findById(code)
                .orElseThrow(() -> new RuntimeException("Country not found with code: " + code));
    }

    // ✅ Add a new country
    @PostMapping("/countries")
    public Country addCountry(@RequestBody Country country) {
        return countryRepository.save(country);
    }

    // ✅ Update an existing country
    @PutMapping("/countries/{code}")
    public Country updateCountry(@PathVariable String code, @RequestBody Country updatedCountry) {
        Country existing = countryRepository.findById(code)
                .orElseThrow(() -> new RuntimeException("Country not found with code: " + code));
        existing.setName(updatedCountry.getName());
        return countryRepository.save(existing);
    }

    // ✅ Delete a country
    @DeleteMapping("/countries/{code}")
    public String deleteCountry(@PathVariable String code) {
        countryRepository.deleteById(code);
        return "Country with code " + code + " deleted.";
    }
}
