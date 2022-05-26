package com.salesianostriana.dam.fitapp.services.impl;


import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.model.DietRepository;
import com.salesianostriana.dam.fitapp.model.dto.*;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.services.DietService;
import com.salesianostriana.dam.fitapp.services.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DietServiceImpl implements DietService {

    private final DietRepository repository;
    private final StorageService storageService;
    private final DietDtoConverter dietDtoConverter;


    @Override
    public Diet save(CreateDietDto createDietDto, MultipartFile file, UserEntity user) throws IOException {

        String filename = storageService.store(file);
        String filenameScaled = storageService.store(file);

        String extension = StringUtils.getFilenameExtension(filename);
        BufferedImage originalImage = ImageIO.read(file.getInputStream());
        BufferedImage imageScaled = storageService.scaledImg(originalImage, 1024);
        OutputStream outputStream = Files.newOutputStream(storageService.load(filename));
        ImageIO.write(imageScaled, extension, outputStream);


        String uri = ServletUriComponentsBuilder
                .fromCurrentContextPath()
                .path("/download/")
                .path(filename)
                .toUriString();


        return repository.save(Diet.builder()
                .title(createDietDto.getTitle())
                .ingredient(createDietDto.getIngredient())
                .calories(createDietDto.getCalories())
                .imagen(uri)
                .build());


    }

    @Override
    public List<Diet> findAll() {
        return repository.findAll();
    }


    @Override
    public Optional<Diet> findDietByID(Long id) {

        return repository.findById(id);
    }

    @Override
    public List<Diet> findByUserNickname(String nickname) {

        return repository.findByUserNickname(nickname);
    }

    @Override
    public List<GetDietDto> listDietDto(String nickname) {

        List<Diet> listaDiet = repository.findByUserNickname(nickname);

        return listaDiet.stream().map(dietDtoConverter::convertListDietToListGetDietDto).collect(Collectors.toList());
    }
}

