package com.demo;

import static org.mockito.Mockito.*;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class Repository {
    String getData() {
        return "Real Data";
    }
}

class Service {
    Repository repository;
    Service(Repository repository) {
        this.repository = repository;
    }

    String processData() {
        return "Processed " + repository.getData();
    }
}

public class ServiceTest {
    @Test
    public void testServiceWithMockRepository() {
        Repository mockRepository = mock(Repository.class);
        when(mockRepository.getData()).thenReturn("Mock Data");

        Service service = new Service(mockRepository);
        String result = service.processData();

        assertEquals("Processed Mock Data", result);
    }
}
