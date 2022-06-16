package com.salesianostriana.dam.fitapp.errors.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class DietNotFoundException extends RuntimeException {

    private static final long serialVersionUID = 43876691117560211L;


    public DietNotFoundException(Long id) {
        super("No se puede encontrar la dieta  con la ID: " + id);
    }
}