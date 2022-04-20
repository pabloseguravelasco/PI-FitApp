package com.salesianostriana.dam.fitapp.config.audit;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@Configuration
@EnableJpaAuditing(auditorAwareRef = "auditorProvider")
public class AuditConfig {

    @Bean
    public com.salesianostriana.dam.fitapp.config.audit.SpringSecurityAuditorAware auditorProvider() {
        return new com.salesianostriana.dam.fitapp.config.audit.SpringSecurityAuditorAware();
    }


}
