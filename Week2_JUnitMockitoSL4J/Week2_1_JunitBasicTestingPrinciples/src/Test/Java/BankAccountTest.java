package com.demo;

import org.junit.Before;
import org.junit.After;
import org.junit.Test;
import static org.junit.Assert.*;

public class BankAccountTest {

    private BankAccount account;

    @Before
    public void setUp() {
        account = new BankAccount(1000); // Arrange
    }

    @After
    public void tearDown() {
        account = null;
    }

    @Test
    public void testDeposit() {
        account.deposit(500); // Act
        assertEquals(1500, account.getBalance()); // Assert
    }

    @Test
    public void testWithdraw() {
        account.withdraw(300); // Act
        assertEquals(700, account.getBalance()); // Assert
    }
}
