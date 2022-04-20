package com.salesianostriana.dam.fitapp.controller;

import com.salesianostriana.dam.fitapp.security.users.dto.CreateUserDto;
import com.salesianostriana.dam.fitapp.security.users.dto.GetUserDto;
import com.salesianostriana.dam.fitapp.security.users.dto.UserDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.security.users.repository.UserEntityRepository;
import com.salesianostriana.dam.fitapp.security.users.services.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfileController {

    private final UserEntityRepository userEntityRepository;
    private final UserEntityService userEntityService;
    private final UserDtoConverter userDtoConverter;

    @GetMapping("/{id}")
    public ResponseEntity<GetUserDto> findProfileByID ( @PathVariable UUID id, @AuthenticationPrincipal UserEntity user) throws Exception {

        Optional<UserEntity> userEntity = userEntityRepository.findById(id);

            if (userEntity.get().getId() == null){
                return ResponseEntity.notFound().build();
            } else
                return ResponseEntity.ok().body(userDtoConverter.convertUserEntityToGetUserDto(userEntity.get()));
        }




   @PutMapping("/me")
    public ResponseEntity<GetUserDto> updateUser ( @RequestPart("file") MultipartFile file,
                                                            @RequestPart("user") CreateUserDto createuserDto, @AuthenticationPrincipal UserEntity user) throws Exception{

            return ResponseEntity.ok().body(userEntityService.updateUser( file, createuserDto, user));
    }


}




