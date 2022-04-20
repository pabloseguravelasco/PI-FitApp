package com.salesianostriana.dam.fitapp;

import com.salesianostriana.dam.fitapp.config.StorageProperties;
import com.salesianostriana.dam.fitapp.services.StorageService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;


@EnableConfigurationProperties(StorageProperties.class)
@SpringBootApplication
public class FitAppApplication {

    public static void main(String[] args) {
        SpringApplication.run(FitAppApplication.class, args);


    }

    @Bean
    public CommandLineRunner init(StorageService storageService) {
        return args -> {
            storageService.deleteAll();
            storageService.init();

        };

    }
}
