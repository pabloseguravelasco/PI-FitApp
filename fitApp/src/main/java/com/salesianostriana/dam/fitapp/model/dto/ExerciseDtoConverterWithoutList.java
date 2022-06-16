package com.salesianostriana.dam.fitapp.model.dto;

import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.security.users.dto.UserDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
@RequiredArgsConstructor
public class ExerciseDtoConverterWithoutList {

    private final UserDtoConverter userDtoConverter;

    public GetExerciseDto convertExerciseToGetExerciseDtoWithoutList(Exercise exercise, UserEntity user) {



        return GetExerciseDto.builder()
                .id(exercise.getId())
                .title(exercise.getTitle())
                .text(exercise.getText())
                .duration(exercise.getDuration())
                .link(exercise.getLink())
                .zone(exercise.getZone())
                .imagen(exercise.getImagen())
                .user(userDtoConverter.convertUserEntityToGetUserDtoWithoutList(user))
                .build();


    }




}
