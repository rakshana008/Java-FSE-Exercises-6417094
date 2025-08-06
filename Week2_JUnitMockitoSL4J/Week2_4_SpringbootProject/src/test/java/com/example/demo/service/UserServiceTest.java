package com.example.demo.service;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserService userService;

    public UserServiceTest() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testGetUserById() {
        // ✅ Provide all 3 parameters
        User mockUser = new User(1L, "John", "john@example.com");
        when(userRepository.findById(1L)).thenReturn(Optional.of(mockUser));

        //User user = userService.getUserById(1L);
        User user = userService.getUserById(1L).orElse(null);

        assertNotNull(user);
        assertEquals("John", user.getName());
        assertEquals("john@example.com", user.getEmail());
    }
}
