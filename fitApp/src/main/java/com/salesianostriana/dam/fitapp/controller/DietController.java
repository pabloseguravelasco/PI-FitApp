package com.salesianostriana.dam.fitapp.controller;

import com.salesianostriana.dam.fitapp.errors.exception.DietNotFoundException;
import com.salesianostriana.dam.fitapp.errors.exception.ExerciseNotFoundException;
import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.model.DietRepository;
import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.model.dto.*;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.security.users.model.UserRole;
import com.salesianostriana.dam.fitapp.security.users.repository.UserEntityRepository;
import com.salesianostriana.dam.fitapp.security.users.services.UserEntityService;
import com.salesianostriana.dam.fitapp.services.DietService;
import com.salesianostriana.dam.fitapp.services.StorageService;
import com.salesianostriana.dam.fitapp.utils.PaginationLinksUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
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
@RequestMapping("/diet")
@RequiredArgsConstructor
public class DietController {

    private final DietService service;
    private final DietDtoConverter dietDtoConverter;
    private final DietRepository dietRepository;
    private final StorageService storageService;
    private final PaginationLinksUtils paginationLinksUtils;
    private final UserEntityService userEntityService;
    private final UserEntityRepository userEntityRepository;


    @Operation(summary = "Crea una dieta.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha creado una dieta.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Diet.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se ha creado la dieta.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Diet.class
                            ))
                    })})

    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestPart("diet") CreateDietDto newDiet,
                                    @AuthenticationPrincipal UserEntity user) throws IOException {

        Diet dietCreated = service.save(newDiet, file, user);
        if (user.getRole().equals(UserRole.ADMIN)||(user.getRole().equals(UserRole.USER))) {

            return ResponseEntity.status(HttpStatus.CREATED).
            body(dietDtoConverter.convertDietToGetDietDto(dietCreated, user));
        } else {
            return new ResponseEntity(HttpStatus.UNAUTHORIZED);
        }


    }

    @Operation(summary = "Muestra listado de todas las dietas")
    @ApiResponses( value = {@ApiResponse(responseCode = "200",
            description = "Se han encontrado todas los dietas.",
            content = {
                    @Content(mediaType = "application/json",
                            schema = @Schema(implementation = Diet.class))
            }),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado ninguna dieta",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = Diet.class
                                    ))
                    })})

    @GetMapping("/list")
    public ResponseEntity<Page<GetDietDto>>findAll(@PageableDefault(size = 30) Pageable pageable, HttpServletRequest request){
        Page<GetDietDto> dietDtos = dietRepository.findAll(pageable)
                .map(dietDtoConverter::convertListDietToListGetDietDto);

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("link",
                        paginationLinksUtils.createLinkHeader(dietDtos, uriBuilder))
                .body(dietDtos);
    }

    @Operation(summary = "Obtiene una dieta.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado una dieta.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Diet.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado ninguna dieta.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Diet.class
                            ))
                    })})

    @GetMapping("/{id}")
    public ResponseEntity<GetDietDto> findDietByID(@PathVariable Long id, @AuthenticationPrincipal UserEntity user){

        Optional<Diet> dietOptional = service.findDietByID(id);

        if(dietOptional.isEmpty()){
            return ResponseEntity.notFound().build();
        }else
            return ResponseEntity.ok().body(dietDtoConverter.convertDietToGetDietDto(dietOptional.get(),user));
    }


   /* @Operation(summary = "Obtiene un listado de las dietas por nombre de usuario.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado una dieta.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Diet.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado ninguna dieta.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Diet.class
                            ))
                    })})
    @GetMapping("/")
    public ResponseEntity<List<GetDietDto>> findByUserNickname(@RequestParam(value = "nickname") String nickname) {

        if (nickname.isBlank()) {
            return ResponseEntity.notFound().build();
        } else
            return ResponseEntity.ok().body(service.listDietDto(nickname));
    }*/

    @Operation(summary = "Muestra todos las dietas del usuario.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado una dieta.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Diet.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado ninguna dieta.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Diet.class
                            ))
                    })})
    @GetMapping("/me")
    public ResponseEntity<List<GetDietDto>> findAllDietUserCurrent(@AuthenticationPrincipal UserEntity user) {

        if (user.getId() == null) {
            return ResponseEntity.notFound().build();
        } else
            return ResponseEntity.ok().body(service.listDietDto(user.getNickname()));
    }


    @Operation(summary = "Añade una dieta a un listado")
    @ApiResponses( value = {@ApiResponse(responseCode = "201",
            description = "Se ha añadido el ejercicio al listado.",
            content = {
                    @Content(mediaType = "application/json",
                            schema = @Schema(implementation = Diet.class))
            }),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado la dieta",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = Diet.class
                                    ))
                    })})

    @PostMapping("/favorite/{id}")
    public ResponseEntity<List<GetDietDto>> addFavorite(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) {


        userEntityRepository.findDietsFav(user.getId()).add(dietRepository.findById(id).get());
        userEntityService.save(user);
        return ResponseEntity.ok().build();
        /*Optional<Diet> dietOptional = service.findDietByID(id);

        if (!diet.isEmpty()) {

            userEntityService.saveFavoriteDiet(user, id);
            return ResponseEntity.ok().build();

        } else {
            return new ResponseEntity(HttpStatus.NOT_FOUND);

        }*/

    }

    @Operation(summary = "Borra una dieta.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se ha borrado la dieta.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado la dieta.",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Exercise.class
                            ))
                    })})

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteDiet(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) {
        Diet diet = dietRepository.findById(id)
                .orElseThrow(() -> new DietNotFoundException(id));

        if(user.getRole().equals(UserRole.ADMIN))  {
            dietRepository.delete(diet);
            storageService.delete(diet.getImagen());

            return ResponseEntity.noContent().build();
        }else{
            return new ResponseEntity(HttpStatus.UNAUTHORIZED);
        }
    }

}

