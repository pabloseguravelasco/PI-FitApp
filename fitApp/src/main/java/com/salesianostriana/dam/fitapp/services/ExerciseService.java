package com.salesianostriana.dam.fitapp.services;


import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.model.dto.CreateExerciseDto;
import com.salesianostriana.dam.fitapp.model.dto.GetExerciseDto;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;


public interface ExerciseService {

    Exercise save(CreateExerciseDto createExerciseDto, MultipartFile file, UserEntity user) throws IOException;

    List<Exercise> findAll();

    Optional<Exercise> findExerciseByID(Long id);

    List<Exercise> findByUserNickname(String nickname);

    List<GetExerciseDto> listExerciseDto(String nickname);

   /* Optional<GetExerciseDto> updatePost(Long id, MultipartFile file,
                                        CreateExerciseDto createExerciseDto, UserEntity user) throws Exception;*/
}