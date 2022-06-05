package com.salesianostriana.dam.fitapp.security.users.dto;

import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.model.dto.DietDtoConverter;
import com.salesianostriana.dam.fitapp.model.dto.ExerciseDtoConverter;
import com.salesianostriana.dam.fitapp.model.dto.GetExerciseDto;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.security.users.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class UserDtoConverter{

    private final UserEntityRepository userEntityRepository;
    private final ExerciseDtoConverter exerciseDtoConverter;
    private final DietDtoConverter dietDtoConverter;


    public GetUserDto convertUserEntityToGetUserDto(UserEntity user) {

        String uri = ServletUriComponentsBuilder
                .fromCurrentContextPath()
                .path("/download/")
                .path(user.getAvatar())
                .toUriString();

        return GetUserDto.builder()
                .id(user.getId())
                .nickname(user.getNickname())
                .fechaNacimiento(user.getFechaNacimiento())
                .email(user.getEmail())
                .role(user.getRole().name())
                .password(user.getPassword())
                .avatar(uri)
                .listFavExercises(userEntityRepository.findExercisesFav(user.getId()).stream().map(exerciseDtoConverter::convertListExerciseToListGetExerciseDto).collect(Collectors.toList()))
                .listFavDiets(userEntityRepository.findDietsFav(user.getId()).stream().map(dietDtoConverter::convertListDietToListGetDietDto).collect(Collectors.toList()))
                .build();


    }

}