package com.msrtc.portal.core.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.web.config.EnableSpringDataWebSupport;

@Configuration
@EnableSpringDataWebSupport
@EnableJpaRepositories(basePackages = "com.msrtc.portal")
@EnableJpaAuditing(auditorAwareRef = "auditorAware")
public class DatabaseConfig {

}
