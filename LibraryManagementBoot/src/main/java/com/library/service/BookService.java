package com.library.service;

import org.springframework.stereotype.Service;

@Service
public class BookService {
    public String getBookTitle() {
        return "Spring Boot in Action";
    }
}
