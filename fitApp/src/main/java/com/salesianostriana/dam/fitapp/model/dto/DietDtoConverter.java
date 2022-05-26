package com.salesianostriana.dam.fitapp.model.dto;

import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@Component
public class DietDtoConverter {

    public GetDietDto convertDietToGetDietDto(Diet diet, UserEntity user) {

        String uri = ServletUriComponentsBuilder
                .fromCurrentContextPath()
                .path("/download/")
                .path(diet.getImagen())
                .toUriString();

        return GetDietDto.builder()
                .id(diet.getId())
                .title(diet.getTitle())
                .ingredient(diet.getIngredient())
                .calories(diet.getCalories())
                .imagen(uri)
                .build();


    }

    public GetDietDto convertListDietToListGetDietDto(Diet diet) {

        String uri = ServletUriComponentsBuilder
                .fromCurrentContextPath()
                .path("/download/")
                .path(diet.getImagen())
                .toUriString();

        return GetDietDto.builder()
                .id(diet.getId())
                .title(diet.getTitle())
                .ingredient(diet.getIngredient())
                .calories(diet.getCalories())
                .imagen(uri)
                .build();


    }
}
