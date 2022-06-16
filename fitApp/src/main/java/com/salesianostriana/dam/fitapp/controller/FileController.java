package com.salesianostriana.dam.fitapp.controller;

import com.salesianostriana.dam.fitapp.model.dto.FileResponse;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.services.StorageService;
import com.salesianostriana.dam.fitapp.utils.MediaTypeUrlResource;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequiredArgsConstructor
@Tag( name = "File", description = "Clase Controller de File")
public class FileController {

    private final StorageService storageService;


    @Operation(summary = "Actualiza una foto")
    @ApiResponses( value = {@ApiResponse(responseCode = "201",
            description = "Se ha actualizado la foto.",
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
    @PostMapping("/upload")
    public ResponseEntity<?> upload(@RequestPart("file") MultipartFile file) {

        String name = storageService.store(file);

        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(name)
                .toUriString();

        FileResponse response = FileResponse.builder()
                .name(name)
                .size(file.getSize())
                .type(file.getContentType())
                .uri(uri)
                .build();

        return ResponseEntity.created(URI.create(uri)).body(response);

    }

    @GetMapping("/download/{filename:.+}")
    public ResponseEntity<Resource> getFile(@PathVariable String filename) {
        MediaTypeUrlResource resource = (MediaTypeUrlResource) storageService.loadAsResource(filename);


        return ResponseEntity.status(HttpStatus.OK)
                .header("content-type", resource.getType())
                .body(resource);


    }

}

