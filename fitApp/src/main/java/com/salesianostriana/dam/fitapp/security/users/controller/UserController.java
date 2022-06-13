package com.salesianostriana.dam.fitapp.security.users.controller;

import com.salesianostriana.dam.fitapp.model.dto.GetExerciseDto;
import com.salesianostriana.dam.fitapp.security.users.dto.CreateUserDto;
import com.salesianostriana.dam.fitapp.security.users.dto.GetUserDto;
import com.salesianostriana.dam.fitapp.security.users.dto.UserDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.security.users.repository.UserEntityRepository;
import com.salesianostriana.dam.fitapp.security.users.services.UserEntityService;

import com.salesianostriana.dam.fitapp.services.StorageService;
import com.salesianostriana.dam.fitapp.utils.PaginationLinksUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserEntityService userEntityService;
    private final UserDtoConverter userDtoConverter;
    private final StorageService storageService;
    private final UserEntityRepository userEntityRepository;
    private final PaginationLinksUtils paginationLinksUtils;

    @PostMapping("/auth/register")
    public ResponseEntity<GetUserDto> nuevoUsuario(@RequestPart("user") CreateUserDto newUser,
                                                   @RequestPart("file") MultipartFile file) throws IOException {

        UserEntity saved = userEntityService.save(newUser, file);
        String filename = storageService.store(file);

        String extension = StringUtils.getFilenameExtension(filename);
        BufferedImage originalImage = ImageIO.read(file.getInputStream());
        BufferedImage imageScaled = storageService.scaledImg(originalImage,128);
        OutputStream outputStream = Files.newOutputStream(storageService.load(filename));
        ImageIO.write(imageScaled,extension, outputStream);


        if (saved == null)
            return ResponseEntity.badRequest().build();
        else
            return ResponseEntity.ok(userDtoConverter.convertUserEntityToGetUserDto(saved));

    }

    @GetMapping("/list")
    public ResponseEntity<Page<GetUserDto>>findAll(@PageableDefault(size = 30) Pageable pageable, HttpServletRequest request) {

        Page<GetUserDto> userDtos = userEntityRepository.findAll(pageable)
                .map(userDtoConverter::convertListUserToListGetUserDto);

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("user",
                        paginationLinksUtils.createLinkHeader(userDtos, uriBuilder))
                .body(userDtos);
    }


}
