package com.msrtc.portal;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.email.service.SendEmailService;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableConfigurationProperties({ ApplicationProperties.class })
@ComponentScan
public class Application {
	
	

    /**
     * Main method, used to run the applicant.
     */
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
        
        
    }

    
}
