package com.salesianostriana.dam.fitapp.model.dto;

import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@Component
public class ExerciseDtoConverter {

    public GetExerciseDto convertExerciseToGetExerciseDto(Exercise exercise, UserEntity user) {

        String uri = ServletUriComponentsBuilder
                .fromCurrentContextPath()
                .path("/download/")
                .path(exercise.getImagen())
                .toUriString();

        return GetExerciseDto.builder()
                .id(exercise.getId())
                .title(exercise.getTitle())
                .text(exercise.getText())
                .duration(exercise.getDuration())
                .link(exercise.getLink())
                .imagen(uri)
                .build();


    }

    public GetExerciseDto convertListExerciseToListGetExerciseDto(Exercise exercise) {

        String uri = ServletUriComponentsBuilder
                .fromCurrentContextPath()
                .path("/download/")
                .path(exercise.getImagen())
                .toUriString();

        return GetExerciseDto.builder()
                .id(exercise.getId())
                .title(exercise.getTitle())
                .text(exercise.getText())
                .imagen(uri)
                .build();


    }

    



}
