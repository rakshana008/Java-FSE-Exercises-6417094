package com.demo;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.time.Duration;

public class PerformanceTesterTest {

    @Test
    void testPerformance() {
        PerformanceTester pt = new PerformanceTester();
        assertTimeout(Duration.ofSeconds(1), pt::performTask);
    }
}
