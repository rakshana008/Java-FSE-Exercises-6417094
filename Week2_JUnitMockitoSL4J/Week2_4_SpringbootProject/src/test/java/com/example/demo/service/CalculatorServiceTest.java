 
package com.example.demo.service;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculatorServiceTest {

    @Test
    public void testAdd() {
        CalculatorService calculatorService = new CalculatorService();
        int result = calculatorService.add(10, 20);
        assertEquals(30, result, "10 + 20 should equal 30");
    }
}
//mvn -Dtest=UserServiceTest test
 
