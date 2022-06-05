package com.salesianostriana.dam.fitapp.controller;


import com.salesianostriana.dam.fitapp.errors.exception.ExerciseNotFoundException;
import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.model.ExerciseRepository;
import com.salesianostriana.dam.fitapp.model.dto.CreateExerciseDto;
import com.salesianostriana.dam.fitapp.model.dto.GetExerciseDto;
import com.salesianostriana.dam.fitapp.model.dto.ExerciseDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.security.users.model.UserRole;
import com.salesianostriana.dam.fitapp.security.users.repository.UserEntityRepository;
import com.salesianostriana.dam.fitapp.services.ExerciseService;
import com.salesianostriana.dam.fitapp.services.StorageService;
import com.salesianostriana.dam.fitapp.utils.PaginationLinksUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/exercise")
@RequiredArgsConstructor

public class ExerciseController {


    private final ExerciseService service;
    private final ExerciseDtoConverter exerciseDtoConverter;
    private final ExerciseRepository exerciseRepository;
    private final StorageService storageService;
    private final UserEntityRepository userEntityRepository;
    private final PaginationLinksUtils paginationLinksUtils;


    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestPart("exercise") CreateExerciseDto newExercise,
                                    @AuthenticationPrincipal UserEntity user) throws IOException {

        Exercise exerciseCreated = service.save(newExercise, file, user);

        if (user.getRole().equals(UserRole.ADMIN)) {

            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(exerciseDtoConverter.convertExerciseToGetExerciseDto(exerciseCreated, user));
        } else {
            return new ResponseEntity(HttpStatus.UNAUTHORIZED);
        }

    }

    @GetMapping("/list")
    public ResponseEntity<Page<GetExerciseDto>>findAll(@PageableDefault(size = 30) Pageable pageable, HttpServletRequest request) {

        Page<GetExerciseDto> exerciseDtos = exerciseRepository.findAll(pageable)
                .map(exerciseDtoConverter::convertListExerciseToListGetExerciseDto);

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("link",
                        paginationLinksUtils.createLinkHeader(exerciseDtos, uriBuilder))
                .body(exerciseDtos);
    }


    @GetMapping("/{id}")
    public ResponseEntity<GetExerciseDto> findExerciseByID(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) {

        Optional<Exercise> exerciseOptional = service.findExerciseByID(id);

        if (exerciseOptional.isEmpty()) {
            return ResponseEntity.notFound()
                    .build();
        } else
            return ResponseEntity.ok().body(exerciseDtoConverter.convertExerciseToGetExerciseDto(exerciseOptional.get(), user));
    }


    @GetMapping("/")
    public ResponseEntity<List<GetExerciseDto>> findByUserNickname(@RequestParam(value = "nickname") String nickname) {

        if (nickname.isBlank()) {
            return ResponseEntity.notFound().build();
        } else
            return ResponseEntity.ok().body(service.listExerciseDto(nickname));
    }

    @GetMapping("/me")
    public ResponseEntity<List<GetExerciseDto>> findAllExerciseUserCurrent(@AuthenticationPrincipal UserEntity user) {

        if (user.getId() == null) {
            return ResponseEntity.notFound().build();
        } else
            return ResponseEntity.ok().body(service.listExerciseDto(user.getNickname()));
    }

    @GetMapping("/favorite/")
    public ResponseEntity<List<GetExerciseDto>> listFavorites(@AuthenticationPrincipal UserEntity user) {

        return ResponseEntity.ok().body(userEntityRepository.findExercisesFav(user.getId())
                .stream().map(exerciseDtoConverter::convertListExerciseToListGetExerciseDto).collect(Collectors.toList()));
    }


    @PostMapping("/favorite/{id}")
    public ResponseEntity<List<GetExerciseDto>> addFavorite(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) {


        Optional<Exercise> exercise = exerciseRepository.findById(id);

        if (!exercise.isEmpty()) {
            List<Exercise> exerciseFavList = userEntityRepository.findExercisesFav(user.getId());
            exerciseFavList.add(exercise.get());
            return ResponseEntity.ok().build();

        } else {
            return new ResponseEntity(HttpStatus.NOT_FOUND);

        }

    }



    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteExercise(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) {
        Exercise exercise = exerciseRepository.findById(id)
                .orElseThrow(() -> new ExerciseNotFoundException(id));

        if(user.getRole().equals(UserRole.ADMIN))  {
            exerciseRepository.delete(exercise);
            storageService.delete(exercise.getImagen());

            return ResponseEntity.noContent().build();
        }else{
            return new ResponseEntity(HttpStatus.UNAUTHORIZED);
        }
    }

    }





