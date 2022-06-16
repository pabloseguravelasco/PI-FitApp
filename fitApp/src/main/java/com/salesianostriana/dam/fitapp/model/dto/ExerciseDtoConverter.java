package com.salesianostriana.dam.fitapp.model.dto;

import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.security.users.dto.UserDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.services.ExerciseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class ExerciseDtoConverter {

    private final UserDtoConverter2 userDtoConverter2;

    public GetExerciseDto convertExerciseToGetExerciseDto(Exercise exercise, UserEntity user) {



        return GetExerciseDto.builder()
                .id(exercise.getId())
                .title(exercise.getTitle())
                .text(exercise.getText())
                .duration(exercise.getDuration())
                .link(exercise.getLink())
                .zone(exercise.getZone())
                .imagen(exercise.getImagen())
                .user(userDtoConverter2.convertUserEntityToGetUserDtoWithoutList(user))
                .build();


    }

    public GetExerciseDto convertListExerciseToListGetExerciseDto(Exercise exercise) {



        return GetExerciseDto.builder()
                .id(exercise.getId())
                .title(exercise.getTitle())
                .text(exercise.getText())
                .link(exercise.getLink())
                .duration(exercise.getDuration())
                .zone(exercise.getZone())
                .imagen(exercise.getImagen())
                .user(userDtoConverter2.convertUserEntityToGetUserDtoWithoutList(exercise.getUser()))
                .build();


    }

    public Exercise createGetExerciseDtoToExercise(CreateExerciseDto createExerciseDto, MultipartFile file) {

        return Exercise.builder()
                .title(createExerciseDto.getTitle())
                .text(createExerciseDto.getText())
                .link(createExerciseDto.getLink())
                .duration(createExerciseDto.getDuration())
                .zone(createExerciseDto.getZone())
                .imagen(createExerciseDto.getImagen())

                .build();
    }





}
