package com.salesianostriana.dam.fitapp.services.impl;


import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.model.ExerciseRepository;
import com.salesianostriana.dam.fitapp.model.dto.CreateExerciseDto;
import com.salesianostriana.dam.fitapp.model.dto.GetExerciseDto;
import com.salesianostriana.dam.fitapp.model.dto.ExerciseDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.services.ExerciseService;
import com.salesianostriana.dam.fitapp.services.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestPart;
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
public class ExerciseServiceImpl implements ExerciseService {

    private final ExerciseRepository repository;
    private final StorageService storageService;
    private final ExerciseDtoConverter exerciseDtoConverter;


    @Override
    public Exercise save(CreateExerciseDto createExerciseDto, MultipartFile file, UserEntity user) throws IOException {

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


        return repository.save(Exercise.builder()
                .title(createExerciseDto.getTitle())
                .text(createExerciseDto.getText())
                .user(user)
                .imagen(uri)
                .build());


    }

    @Override
    public List<Exercise> findAll() {
        return repository.findAll();
    }


    @Override
    public Optional<Exercise> findExerciseByID(Long id) {

        return repository.findById(id);
    }

    @Override
    public List<Exercise> findByUserNickname(String nickname) {

        return repository.findByUserNickname(nickname);
    }

    @Override
    public List<GetExerciseDto> listExerciseDto(String nickname) {

        List<Exercise> listaExercise = repository.findByUserNickname(nickname);

        return listaExercise.stream().map(exerciseDtoConverter::convertListExerciseToListGetExerciseDto).collect(Collectors.toList());
    }
}

    /*@Override
    public Optional<GetExerciseDto> updatePost (@PathVariable Long id, @RequestPart("file") MultipartFile file,
                                                @RequestPart("exercise") CreateExerciseDto createExerciseDto, @AuthenticationPrincipal  UserEntity user) throws Exception{

        if (file.isEmpty()){

        Optional<Exercise> post = exerciseRepository.findById(id);

        return post.map(m -> {
            m.setTitle(createExerciseDto.getTitle());
            m.setText(createExerciseDto.getText());
            m.setImagen(m.getImagen());
            exerciseRepository.save(m);
            return exerciseDtoConverter.convertExerciseToGetExerciseDto(m, user);
        });

    }else{

        Optional<Exercise> post = exerciseRepository.findById(id);

        String name = StringUtils.cleanPath(String.valueOf(post.get().getImagen())).replace("http://localhost:8080/download/", "");

        Path pa = storageService.load(name);

        String filename = StringUtils.cleanPath(String.valueOf(pa)).replace("http://localhost:8080/download/", "");

        Path path = Paths.get(filename);

        storageService.delete(post.get().getImagen());


        String newFilename = storageService.store(file);

        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(newFilename)
                .toUriString();

        return post.map(m -> {
            m.setTitle(createExerciseDto.getTitle());
            m.setText(createExerciseDto.getText());
            m.setImagen(uri);
            exerciseRepository.save(m);
            return exerciseDtoConverter.convertExerciseToGetExerciseDto(m, user);

        });*/












