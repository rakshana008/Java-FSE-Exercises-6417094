package com.library.service;

import com.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookService {

    private BookRepository bookRepository;

    @Autowired
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void processBook() {
        System.out.println("📚 BookService: Processing book...");
        bookRepository.saveBook();
    }

    public String getBookTitle() {
        return "Spring in Action";
    }

    public void failMethod() {
        throw new RuntimeException("Something went wrong!");
    }
}
