package com.salesianostriana.dam.fitapp.security.users.services;


import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.model.DietRepository;
import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.model.ExerciseRepository;
import com.salesianostriana.dam.fitapp.security.users.dto.GetUserDto;
import com.salesianostriana.dam.fitapp.security.users.dto.UserDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserRole;
import com.salesianostriana.dam.fitapp.services.StorageService;
import com.salesianostriana.dam.fitapp.services.base.BaseService;
import com.salesianostriana.dam.fitapp.security.users.dto.CreateUserDto;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.security.users.repository.UserEntityRepository;
import com.salesianostriana.dam.fitapp.services.impl.ExerciseServiceImpl;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;
import java.util.UUID;

@Service("userDetailsService")
@RequiredArgsConstructor
public class UserEntityService extends BaseService<UserEntity, UUID, UserEntityRepository> implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;
    private final StorageService storageService;
    private final UserEntityRepository userEntityRepository;
    private final UserDtoConverter userDtoConverter;
    private final ExerciseRepository exerciseRepository;
    private final DietRepository dietRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return this.repositorio.findFirstByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException(email + " no encontrado"));
    }


    public UserEntity save(CreateUserDto newUser, MultipartFile file) {


        if (newUser.getPassword().contentEquals(newUser.getPassword2())) {

            String filename = storageService.store(file);

            String uri = ServletUriComponentsBuilder
                    .fromCurrentContextPath()
                    .path("/download/")
                    .path(filename)
                    .toUriString();

            UserEntity userEntity = UserEntity.builder()
                    .password(passwordEncoder.encode(newUser.getPassword()))
                    .avatar(uri)
                    .nickname(newUser.getNickname())
                    .email(newUser.getEmail())
                    .role(UserRole.ADMIN)
                    .build();
            return save(userEntity);
        } else {
            return null;
        }
    }

    @Override
    public GetUserDto updateUser( MultipartFile file,
                                           CreateUserDto createuserDto,  UserEntity user) throws Exception {

        if (file.isEmpty()) {

            user.setNickname(createuserDto.getNickname());
            user.setEmail(createuserDto.getEmail());
            user.setPassword(createuserDto.getPassword());
            user.setNickname(createuserDto.getNickname());
            user.setAvatar(createuserDto.getAvatar());

            userEntityRepository.save(user);
            return userDtoConverter.convertUserEntityToGetUserDto(user);


        } else {


            String name = StringUtils.cleanPath(String.valueOf(user.getAvatar())).replace("http://localhost:8080/download/", "");

            Path pa = storageService.load(name);

            String filename = StringUtils.cleanPath(String.valueOf(pa)).replace("http://localhost:8080/download/", "");

            Path path = Paths.get(filename);

            storageService.delete(user.getAvatar());


            String newFilename = storageService.store(file);

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(newFilename)
                    .toUriString();

            user.setNickname(createuserDto.getNickname());
            user.setEmail(createuserDto.getEmail());
            user.setPassword(createuserDto.getPassword());
            user.setNickname(createuserDto.getNickname());
            user.setAvatar(uri);

            userEntityRepository.save(user);
            return userDtoConverter.convertUserEntityToGetUserDto(user);


        }
    }

    public void saveFavoriteExercise (UserEntity user, Long id){

        Optional<UserEntity> userEntity = findById(user.getId());
        Optional<Exercise> exercise = exerciseRepository.findById(id);

        if(!exercise.isEmpty() && !userEntity.isPresent()){
            user.getListFavExercises().add(exercise.get());
            save(user);
        }

    }

    public void saveFavoriteDiet (UserEntity user, Long id){

        Optional<UserEntity> userEntity = findById(user.getId());
        Optional<Diet> diet = dietRepository.findById(id);

        if(!diet.isEmpty() && !userEntity.isPresent()){
            userEntity.get().getListFavDiets().add(diet.get());
            save(user);
        }

    }


}
