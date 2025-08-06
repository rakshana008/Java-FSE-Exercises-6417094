package com.demo;

import org.junit.jupiter.api.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class OrderedTests {

    @Test
    @Order(2)
    void testSecond() {
        System.out.println("Second test");
    }

    @Test
    @Order(1)
    void testFirst() {
        System.out.println("First test");
    }

    @Test
    @Order(3)
    void testThird() {
        System.out.println("Third test");
    }
}



