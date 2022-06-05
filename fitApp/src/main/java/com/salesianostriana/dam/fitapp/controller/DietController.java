package com.salesianostriana.dam.fitapp.controller;

import com.salesianostriana.dam.fitapp.errors.exception.DietNotFoundException;
import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.model.DietRepository;
import com.salesianostriana.dam.fitapp.model.dto.*;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.services.DietService;
import com.salesianostriana.dam.fitapp.services.StorageService;
import com.salesianostriana.dam.fitapp.utils.PaginationLinksUtils;
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

@RestController
@RequestMapping("/diet")
@RequiredArgsConstructor
public class DietController {

    private final DietService service;
    private final DietDtoConverter dietDtoConverter;
    private final DietRepository dietRepository;
    private final StorageService storageService;
    private final PaginationLinksUtils paginationLinksUtils;

    @PostMapping("/")
    public ResponseEntity<?> create(@RequestPart("file") MultipartFile file,
                                    @RequestPart("diet") CreateDietDto newDiet,
                                    @AuthenticationPrincipal UserEntity user) throws IOException {

        Diet dietCreated = service.save(newDiet, file, user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(dietDtoConverter.convertDietToGetDietDto(dietCreated, user));

    }

    @GetMapping("/list")
    public ResponseEntity<Page<GetDietDto>>findAll(@PageableDefault(size = 30) Pageable pageable, HttpServletRequest request){
        Page<GetDietDto> dietDtos = dietRepository.findAll(pageable)
                .map(dietDtoConverter::convertListDietToListGetDietDto);

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("link",
                        paginationLinksUtils.createLinkHeader(dietDtos, uriBuilder))
                .body(dietDtos);
    }


    @GetMapping("/{id}")
    public ResponseEntity<GetDietDto> findDietByID(@PathVariable Long id, @AuthenticationPrincipal UserEntity user){

        Optional<Diet> dietOptional = service.findDietByID(id);

        if(dietOptional.isEmpty()){
            return ResponseEntity.notFound().build();
        }else
            return ResponseEntity.ok().body(dietDtoConverter.convertDietToGetDietDto(dietOptional.get(),user));
    }

    /*@GetMapping("/favorite/")
    public ResponseEntity<List<GetExerciseDto>> listFavorites(@PathVariable Long id, @AuthenticationPrincipal UserEntity user){

        return
    }


    @PostMapping("/favorite/{id}")
    public ResponseEntity<List<GetDietDto>> addFavorite(@PathVariable Long id, @AuthenticationPrincipal UserEntity user){

        Optional<Diet> dietOptional = service.findDietByID(id);

        if(dietOptional.isEmpty()){
            return ResponseEntity.notFound().build();
        }else{

            return
        }
    }*/



    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteDiet(@PathVariable Long id) {
        Diet diet = dietRepository.findById(id)
                .orElseThrow(() -> new DietNotFoundException(id));

        dietRepository.delete(diet);
        storageService.delete(diet.getImagen());

        return ResponseEntity.noContent().build();
    }

}

