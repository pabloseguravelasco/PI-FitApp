package com.salesianostriana.dam.fitapp.model.dto;

import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.security.users.dto.UserDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class DietDtoConverterWithoutList {

    private final UserDtoConverter userDtoConverter;

    public GetDietDto convertDietToGetDietDtoWithoutList(Diet diet, UserEntity user) {


        return GetDietDto.builder()
                .id(diet.getId())
                .title(diet.getTitle())
                .ingredient(diet.getIngredient())
                .calories(diet.getCalories())
                .imagen(diet.getImagen())
                .user(userDtoConverter.convertUserEntityToGetUserDtoWithoutList(user))
                .build();


    }


}
