package com.demo;

import static org.mockito.Mockito.*;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

interface NetworkClient {
    String connect();
}

class NetworkService {
    NetworkClient client;
    NetworkService(NetworkClient client) {
        this.client = client;
    }

    String connectToServer() {
        return "Connected to " + client.connect();
    }
}

public class NetworkServiceTest {
    @Test
    public void testServiceWithMockNetworkClient() {
        NetworkClient mockNetworkClient = mock(NetworkClient.class);
        when(mockNetworkClient.connect()).thenReturn("Mock Connection");

        NetworkService networkService = new NetworkService(mockNetworkClient);
        String result = networkService.connectToServer();

        assertEquals("Connected to Mock Connection", result);
    }
}
