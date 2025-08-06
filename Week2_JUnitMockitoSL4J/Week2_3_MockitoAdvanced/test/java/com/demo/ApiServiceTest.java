package com.demo;

import static org.mockito.Mockito.*;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class RestClient {
    String getResponse() {
        return "Real Response";
    }
}

class ApiService {
    RestClient client;
    ApiService(RestClient client) {
        this.client = client;
    }

    String fetchData() {
        return "Fetched " + client.getResponse();
    }
}

public class ApiServiceTest {
    @Test
    public void testServiceWithMockRestClient() {
        RestClient mockRestClient = mock(RestClient.class);
        when(mockRestClient.getResponse()).thenReturn("Mock Response");

        ApiService apiService = new ApiService(mockRestClient);
        String result = apiService.fetchData();

        assertEquals("Fetched Mock Response", result);
    }
}
