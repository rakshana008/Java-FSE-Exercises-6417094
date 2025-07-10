package com.cognizant.orm_learn.controller;

import com.cognizant.orm_learn.model.Country;
import com.cognizant.orm_learn.repository.CountryRepository;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.Optional;

import static org.hamcrest.Matchers.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(CountryController.class)
public class CountryControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private CountryRepository countryRepository;

    @Test
    public void testGetAllCountries() throws Exception {
        Country india = new Country("IN", "India");
        Country usa = new Country("US", "United States");

        Mockito.when(countryRepository.findAll()).thenReturn(Arrays.asList(india, usa));

        mockMvc.perform(get("/api/countries"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].code", is("IN")))
                .andExpect(jsonPath("$[0].name", is("India")))
                .andExpect(jsonPath("$[1].code", is("US")))
                .andExpect(jsonPath("$[1].name", is("United States")));
    }

    @Test
    public void testGetCountryByCode() throws Exception {
        Country india = new Country("IN", "India");

        Mockito.when(countryRepository.findById("IN")).thenReturn(Optional.of(india));

        mockMvc.perform(get("/api/countries/IN"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code", is("IN")))
                .andExpect(jsonPath("$.name", is("India")));
    }
}
