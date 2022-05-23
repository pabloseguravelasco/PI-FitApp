package com.salesianostriana.dam.fitapp.services;

import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.model.dto.CreateDietDto;
import com.salesianostriana.dam.fitapp.model.dto.CreateExerciseDto;
import com.salesianostriana.dam.fitapp.model.dto.GetDietDto;
import com.salesianostriana.dam.fitapp.model.dto.GetExerciseDto;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

public interface DietService {

    Diet save(CreateDietDto createDietDto, MultipartFile file, UserEntity user) throws IOException;

    List<Diet> findAll();

    Optional<Diet> findDietByID(Long id);

}