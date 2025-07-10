package com.demo;

public class PerformanceTester {
    public void performTask() {
        try {
            Thread.sleep(500); // Simulates a task
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}
