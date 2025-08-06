package com.example.testmodel.service;

import com.example.testmodel.model.User;
import com.example.testmodel.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import static org.junit.jupiter.api.Assertions.*;
import java.util.Optional;

public class UserServiceTest {

    @Test
    void testGetUserById() {
        UserRepository userRepository = Mockito.mock(UserRepository.class);
        UserService userService = new UserService(userRepository);

        User user = new User(1L, "Bob");
        Mockito.when(userRepository.findById(1L)).thenReturn(Optional.of(user));

        Optional<User> result = userService.getUserById(1L);
        assertTrue(result.isPresent());
        assertEquals("Bob", result.get().getName());
    }
}
