package com.salesianostriana.dam.fitapp.controller;

import com.salesianostriana.dam.fitapp.errors.exception.DietNotFoundException;
import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.model.DietRepository;
import com.salesianostriana.dam.fitapp.model.dto.*;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.services.DietService;
import com.salesianostriana.dam.fitapp.services.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Optional;

@RestController
@RequestMapping("/diet")
@RequiredArgsConstructor
public class DietController {

    private final DietService service;
    private final DietDtoConverter dietDtoConverter;
    private final DietRepository dietRepository;
    private final StorageService storageService;

    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestPart("diet") CreateDietDto newDiet,
                                    @AuthenticationPrincipal UserEntity user) throws IOException {

        Diet dietCreated = service.save(newDiet, file, user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(dietDtoConverter.convertDietToGetDietDto(dietCreated, user));

    }

    @GetMapping("/{id}")
    public ResponseEntity<GetDietDto> findDietByID(@PathVariable Long id, @AuthenticationPrincipal UserEntity user){

        Optional<Diet> dietOptional = service.findDietByID(id);

        if(dietOptional.isEmpty()){
            return ResponseEntity.notFound().build();
        }else
            return ResponseEntity.ok().body(dietDtoConverter.convertDietToGetDietDto(dietOptional.get(),user));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteDiet(@PathVariable Long id) {
        Diet diet = dietRepository.findById(id)
                .orElseThrow(() -> new DietNotFoundException(id));

        dietRepository.delete(diet);
        storageService.delete(diet.getImagen());

        return ResponseEntity.noContent().build();
    }

}

