package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class LibraryManagementApplication {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BookService service = context.getBean(BookService.class);

        service.processBook();

        // ✅ Trigger @AfterReturning
        String title = service.getBookTitle();

        // ✅ Trigger @AfterThrowing
        try {
            service.failMethod();
        } catch (Exception e) {
            System.out.println("⚠️ Exception handled in main: " + e.getMessage());
        }
    }
}
