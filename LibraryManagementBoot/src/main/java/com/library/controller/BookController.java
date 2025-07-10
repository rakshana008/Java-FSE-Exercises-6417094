package com.library.controller;

import com.library.model.Book;
import com.library.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookService bookService;

    // ✅ GET: basic
    @GetMapping("/title")
    public String getBookTitle() {
        return bookService.getBookTitle();
    }

    // ✅ POST: Add book
    @PostMapping("/add")
    public String addBook(@RequestBody Book book) {
        return "✅ Book received: " + book.getTitle() + " by " + book.getAuthor();
    }

    // ✅ PUT: Update book
    @PutMapping("/update")
    public String updateBook(@RequestBody Book book) {
        return "🔁 Book updated: " + book.getTitle() + " by " + book.getAuthor();
    }

    // ✅ DELETE: Delete book
    @DeleteMapping("/delete/{title}")
    public String deleteBook(@PathVariable String title) {
        return "🗑️ Book deleted: " + title;
    }
}
