package com.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AppenderExample {
    private static final Logger logger = LoggerFactory.getLogger(AppenderExample.class);

    public static void main(String[] args) {
        logger.debug("Debug log from AppenderExample");
        logger.info("Info log from AppenderExample");
        logger.error("Error log from AppenderExample");
    }
}
