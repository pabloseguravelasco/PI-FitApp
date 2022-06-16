package com.salesianostriana.dam.fitapp.controller;

import com.salesianostriana.dam.fitapp.security.users.dto.CreateUserDto;
import com.salesianostriana.dam.fitapp.security.users.dto.GetUserDto;
import com.salesianostriana.dam.fitapp.security.users.dto.UserDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.security.users.repository.UserEntityRepository;
import com.salesianostriana.dam.fitapp.security.users.services.UserEntityService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;
import java.util.UUID;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/profile")
@RequiredArgsConstructor
@Tag( name = "Perfil", description = "Clase Controller de Perfil de Usuario")
public class ProfileController {

    private final UserEntityRepository userEntityRepository;
    private final UserEntityService userEntityService;
    private final UserDtoConverter userDtoConverter;

    @Operation(summary = "Busca un perfil por su ID")
    @ApiResponses( value = {@ApiResponse(responseCode = "200",
            description = "Se ha encontrado el perfil.",
            content = {
                    @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))
            }),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado ninguna inmobiliaria",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = UserEntity.class
                                    ))
                    })})
    @GetMapping("/{id}")
    public ResponseEntity<GetUserDto> findProfileByID ( @PathVariable UUID id, @AuthenticationPrincipal UserEntity user) throws Exception {

        Optional<UserEntity> userEntity = userEntityRepository.findById(id);

            if (userEntity.get().getId() == null){
                return ResponseEntity.notFound().build();
            } else
                return ResponseEntity.ok().body(userDtoConverter.convertUserEntityToGetUserDto(userEntity.get()));
        }


    @Operation(summary = "Edita un perfil buscado por su ID")
    @ApiResponses( value = {@ApiResponse(responseCode = "201",
            description = "Se ha editado el perfil.",
            content = {
                    @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))
            }),
            @ApiResponse(responseCode = "404",
                    description = "No se ha encontrado el perfil",
                    content = {
                            @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = UserEntity.class
                                    ))
                    })})

   @PutMapping("/me")
    public ResponseEntity<GetUserDto> updateUser ( @RequestPart("file") MultipartFile file,
                                                            @RequestPart("user") CreateUserDto createuserDto, @AuthenticationPrincipal UserEntity user) throws Exception{

            return ResponseEntity.ok().body(userEntityService.updateUser( file, createuserDto, user));
    }


}




