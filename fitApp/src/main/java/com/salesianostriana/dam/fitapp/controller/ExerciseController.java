package com.salesianostriana.dam.fitapp.controller;


import com.salesianostriana.dam.fitapp.errors.exception.PostNotFoundException;
import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.model.ExerciseRepository;
import com.salesianostriana.dam.fitapp.model.dto.CreateExerciseDto;
import com.salesianostriana.dam.fitapp.model.dto.GetExerciseDto;
import com.salesianostriana.dam.fitapp.model.dto.ExerciseDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.services.ExerciseService;
import com.salesianostriana.dam.fitapp.services.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/post")
@RequiredArgsConstructor

public class ExerciseController {


    private final ExerciseService service;
    private final ExerciseDtoConverter exerciseDtoConverter;
    private final ExerciseRepository exerciseRepository;
    private final StorageService storageService;


    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestPart("post") CreateExerciseDto newPost,
                                    @AuthenticationPrincipal UserEntity user) throws IOException {

        Exercise exerciseCreated = service.save(newPost, file, user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(exerciseDtoConverter.convertExerciseToGetExerciseDto(exerciseCreated, user));

    }


    @GetMapping("/public")
    public ResponseEntity<?> findByIsPublic() {
        return ResponseEntity.ok(service.findByPublico(true));
    }

    @GetMapping("/{id}")
    public ResponseEntity<GetExerciseDto> findPostByID(@PathVariable Long id, @AuthenticationPrincipal UserEntity user){

        Optional<Exercise> postOptional = service.findPostByID(id);

        if(postOptional.isEmpty()){
            return ResponseEntity.notFound().build();
        }else
            return ResponseEntity.ok().body(exerciseDtoConverter.convertExerciseToGetExerciseDto(postOptional.get(),user));
    }

    @GetMapping("/")
    public ResponseEntity<List<GetExerciseDto>> findByUserNickname(@RequestParam(value = "nickname") String nickname){

        if (nickname.isBlank()){
            return ResponseEntity.notFound().build();
        } else
            return ResponseEntity.ok().body(service.listPostDto(nickname));
    }

    @GetMapping("/me")
    public ResponseEntity<List<GetExerciseDto>> findAllPostUserCurrent(@AuthenticationPrincipal UserEntity user){

        if (user.getId() == null){
            return ResponseEntity.notFound().build();
        } else
            return ResponseEntity.ok().body(service.listPostDto(user.getNickname()));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Optional<GetExerciseDto>>updatePost (@PathVariable Long id, @RequestPart("file") MultipartFile file,
                                                               @RequestPart("post") CreateExerciseDto createExerciseDto, @AuthenticationPrincipal  UserEntity user) throws Exception {

        Optional<Exercise> postOptional = service.findPostByID(id);

        if (postOptional.isEmpty()){
            return ResponseEntity.notFound().build();
        } else
            return ResponseEntity.ok().body(service.updatePost(postOptional.get().getId(),file, createExerciseDto,user));
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePost(@PathVariable Long id) {
        Exercise exercise = exerciseRepository.findById(id)
                .orElseThrow(() -> new PostNotFoundException(id));

        exerciseRepository.delete(exercise);
        storageService.delete(exercise.getImagen());

        return ResponseEntity.noContent().build();
    }

    }





