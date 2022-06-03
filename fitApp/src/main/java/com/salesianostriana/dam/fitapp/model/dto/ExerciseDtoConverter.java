package com.salesianostriana.dam.fitapp.model.dto;

import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.services.ExerciseService;
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
                .zone(exercise.getZone())
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
                .link(exercise.getLink())
                .duration(exercise.getDuration())
                .zone(exercise.getZone())
                .imagen(uri)
                .build();


    }





}
