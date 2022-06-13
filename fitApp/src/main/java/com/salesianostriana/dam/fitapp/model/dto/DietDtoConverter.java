package com.salesianostriana.dam.fitapp.model.dto;

import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.security.users.dto.GetUserDto;
import com.salesianostriana.dam.fitapp.security.users.dto.UserDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@Component
@RequiredArgsConstructor
public class DietDtoConverter {

    private final UserDtoConverter2 userDtoConverter2;

    public GetDietDto convertDietToGetDietDto(Diet diet, UserEntity user) {


        return GetDietDto.builder()
                .id(diet.getId())
                .title(diet.getTitle())
                .ingredient(diet.getIngredient())
                .calories(diet.getCalories())
                .imagen(diet.getImagen())
                .user(userDtoConverter2.convertUserEntityToGetUserDtoWithoutList(user))
                .build();


    }

    public GetDietDto convertListDietToListGetDietDto(Diet diet) {



        return GetDietDto.builder()
                .id(diet.getId())
                .title(diet.getTitle())
                .ingredient(diet.getIngredient())
                .calories(diet.getCalories())
                .imagen(diet.getImagen())
                .user(userDtoConverter2.convertUserEntityToGetUserDtoWithoutList(diet.getUser()))
                .build();


    }

    public Diet createGetDietDtoToDiet(CreateDietDto createDietDto, MultipartFile file) {

        return Diet.builder()
                .title(createDietDto.getTitle())
                .ingredient(createDietDto.getIngredient())
                .calories(createDietDto.getCalories())
                .imagen(createDietDto.getImagen())

                .build();
    }

}
