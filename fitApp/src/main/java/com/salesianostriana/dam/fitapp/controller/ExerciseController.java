package com.salesianostriana.dam.fitapp.controller;


import com.salesianostriana.dam.fitapp.errors.exception.ExerciseNotFoundException;
import com.salesianostriana.dam.fitapp.errors.exception.ListEntityNotFoundException;
import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.model.ExerciseRepository;
import com.salesianostriana.dam.fitapp.model.dto.CreateExerciseDto;
import com.salesianostriana.dam.fitapp.model.dto.GetExerciseDto;
import com.salesianostriana.dam.fitapp.model.dto.ExerciseDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.security.users.model.UserRole;
import com.salesianostriana.dam.fitapp.security.users.repository.UserEntityRepository;
import com.salesianostriana.dam.fitapp.security.users.services.UserEntityService;
import com.salesianostriana.dam.fitapp.services.ExerciseService;
import com.salesianostriana.dam.fitapp.services.StorageService;
import com.salesianostriana.dam.fitapp.utils.PaginationLinksUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
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

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/exercise")
@RequiredArgsConstructor
@Tag( name = "Exercise", description = "Clase Controller de Exercise")

public class ExerciseController {


    private final ExerciseService service;
    private final ExerciseDtoConverter exerciseDtoConverter;
    private final ExerciseRepository exerciseRepository;
    private final StorageService storageService;
    private final UserEntityRepository userEntityRepository;
    private final PaginationLinksUtils paginationLinksUtils;
    private final UserEntityService userEntityService;


    @Operation(summary = "Crea un ejercicio.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha creado un ejercicio.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se ha creado el ejercicio.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class
                            ))
                    })})

    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestPart("exercise") CreateExerciseDto newExercise,
                                    @AuthenticationPrincipal UserEntity user) throws IOException {

        Exercise exerciseCreated = service.save(newExercise, file, user);

        if (user.getRole().equals(UserRole.ADMIN)||(user.getRole().equals(UserRole.USER))) {

            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(exerciseDtoConverter.convertExerciseToGetExerciseDto(exerciseCreated, user));
        } else {
            return new ResponseEntity(HttpStatus.UNAUTHORIZED);
        }

    }

    @Operation(summary = "Muestra listado de todas los ejercicios")
    @ApiResponses( value = {@ApiResponse(responseCode = "200",
            description = "Se han encontrado todos los ejercicios.",
            content = {
                    @Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class))
            }),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado ningun ejercicios",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = Exercise.class
                                    ))
                    })})

    @GetMapping("/list")
    public ResponseEntity<Page<GetExerciseDto>>findAll(@PageableDefault(size = 30) Pageable pageable, HttpServletRequest request) {

        Page<GetExerciseDto> exerciseDtos = exerciseRepository.findAll(pageable)
                .map(exerciseDtoConverter::convertListExerciseToListGetExerciseDto);

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("link",
                        paginationLinksUtils.createLinkHeader(exerciseDtos, uriBuilder))
                .body(exerciseDtos);
    }

    @Operation(summary = "Obtiene un ejercicio.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado un ejercicio.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado ningun ejercicio.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class
                            ))
                    })})
    @GetMapping("/{id}")
    public ResponseEntity<GetExerciseDto> findExerciseByID(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) {

        Optional<Exercise> exerciseOptional = service.findExerciseByID(id);

        if (exerciseOptional.isEmpty()) {
            return ResponseEntity.notFound()
                    .build();
        } else
            return ResponseEntity.ok().body(exerciseDtoConverter.convertExerciseToGetExerciseDto(exerciseOptional.get(), user));
    }


    /*@Operation(summary = "Obtiene un listado de  ejercicios por nombre de usuario.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado un ejercicio.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado ningun ejercicio.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class
                            ))
                    })})
    @GetMapping("/")
    public ResponseEntity<List<GetExerciseDto>> findByUserNickname(@RequestParam(value = "nickname") String nickname,  @AuthenticationPrincipal UserEntity user) {

        Optional<UserEntity> user = userEntityRepository.findBy(nickname);
        if (nickname.isBlank()) {
            return ResponseEntity.notFound().build();
        } else
            return ResponseEntity.ok().body(service.listExerciseDto(nickname));
    }*/

    @Operation(summary = "Muestra todos los ejercicios del usuario.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado un ejercicio.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado ningun ejercicio.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class
                            ))
                    })})

    @GetMapping("/me")
    public ResponseEntity<List<GetExerciseDto>> findAllExerciseUserCurrent(@AuthenticationPrincipal UserEntity user) {

        if (user.getId() == null) {
            return ResponseEntity.notFound().build();
        } else
            return ResponseEntity.ok().body(service.listExerciseDto(user.getNickname()));
    }

    @Operation(summary = "Añade un ejercicio a un listado")
    @ApiResponses( value = {@ApiResponse(responseCode = "201",
            description = "Se ha añadido el ejercicio al listado.",
            content = {
                    @Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class))
            }),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado el ejercicio",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = Exercise.class
                                    ))
                    })})

    @PostMapping("/favorite/{id}")
    public ResponseEntity<List<GetExerciseDto>> addFavorite(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) {

        Optional<Exercise> exercise = exerciseRepository.findById(id);

        if (!exercise.isEmpty()) {

            userEntityService.saveFavoriteExercise(user, id);
            return ResponseEntity.ok().build();

        } else {
            return new ResponseEntity(HttpStatus.NOT_FOUND);

        }

    }


    @Operation(summary = "Edita un ejercicio buscado por su id")
    @ApiResponses( value = {@ApiResponse(responseCode = "201",
            description = "Se ha editado el ejercicio.",
            content = {
                    @Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class))
            }),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado el ejercicio",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = Exercise.class
                                    ))
                    })})

   @PutMapping("/{id}")
    public ResponseEntity<GetExerciseDto> editExercise(@PathVariable Long id, @RequestPart("file") MultipartFile file,@RequestPart("exercise")CreateExerciseDto exerciseDto,@AuthenticationPrincipal UserEntity user) throws Exception {

       if (user.getRole().equals(UserRole.ADMIN)) {

           Exercise exercisePre = exerciseDtoConverter.createGetExerciseDtoToExercise(exerciseDto, file);
           Exercise exerciseAct = service.updateExercise(id, file, exerciseDto, user);
           GetExerciseDto exerciseDto1 = exerciseDtoConverter.convertExerciseToGetExerciseDto(exerciseAct, user);
           return ResponseEntity.ok().body(exerciseDto1);
       } else {
           return new ResponseEntity(HttpStatus.UNAUTHORIZED);
       }
   }

    @Operation(summary = "Borra un ejercicio.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se ha borrado el ejercicio.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado el ejercicio.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class
                            ))
                    })})

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





