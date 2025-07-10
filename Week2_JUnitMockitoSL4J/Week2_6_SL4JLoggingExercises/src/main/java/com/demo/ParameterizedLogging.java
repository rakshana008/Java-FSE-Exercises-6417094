package com.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ParameterizedLogging {
    private static final Logger logger = LoggerFactory.getLogger(ParameterizedLogging.class);

    public static void main(String[] args) {
        String username = "harini";
        int loginCount = 5;

        logger.info("User {} has logged in {} times today", username, loginCount);
    }
}
