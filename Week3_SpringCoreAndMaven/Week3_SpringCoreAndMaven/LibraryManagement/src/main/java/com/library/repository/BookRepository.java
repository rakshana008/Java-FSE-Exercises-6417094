package com.library.repository;

import org.springframework.stereotype.Repository;  // ✅ REQUIRED import

@Repository
public class BookRepository {
    public void saveBook() {
        System.out.println("📘 BookRepository: Book saved to database.");
    }
}
