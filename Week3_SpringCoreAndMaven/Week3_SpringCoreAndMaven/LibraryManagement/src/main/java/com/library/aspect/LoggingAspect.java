package com.library.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect {

    @Before("execution(* com.library.service.*.*(..))")
    public void beforeAdvice() {
        System.out.println("🕵️ LoggingAspect: Before method execution");
    }

    @After("execution(* com.library.service.*.*(..))")
    public void afterAdvice() {
        System.out.println("✅ LoggingAspect: After method execution");
    }

    @Around("execution(* com.library.service.*.*(..))")
    public Object aroundAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
        long start = System.currentTimeMillis();
        Object result = joinPoint.proceed();
        long end = System.currentTimeMillis();
        System.out.println("⏱ " + joinPoint.getSignature() + " executed in " + (end - start) + "ms");
        return result;
    }

    @AfterReturning(
        pointcut = "execution(* com.library.service.BookService.getBookTitle(..))",
        returning = "result"
    )
    public void afterReturningAdvice(String result) {
        System.out.println("📘 AfterReturning: Book title returned = " + result);
    }

    @AfterThrowing(
        pointcut = "execution(* com.library.service.BookService.failMethod(..))",
        throwing = "ex"
    )
    public void afterThrowingAdvice(Throwable ex) {
        System.out.println("❌ AfterThrowing: Exception caught = " + ex.getMessage());
    }
}
