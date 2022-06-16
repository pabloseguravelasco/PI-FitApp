package com.salesianostriana.dam.fitapp.security;


import com.salesianostriana.dam.fitapp.security.dto.JwtUserResponse;
import com.salesianostriana.dam.fitapp.security.dto.LoginDto;
import com.salesianostriana.dam.fitapp.security.jwt.JwtProvider;
import com.salesianostriana.dam.fitapp.security.users.dto.UserDtoConverter;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import com.salesianostriana.dam.fitapp.security.users.model.UserRole;
import com.salesianostriana.dam.fitapp.security.users.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;
    private final UserDtoConverter userDtoConverter;


    @PostMapping("/auth/login")
    public ResponseEntity<?> login(@RequestBody LoginDto loginDto) {

        Authentication authentication =
                authenticationManager.authenticate(
                   new UsernamePasswordAuthenticationToken(
                           loginDto.getEmail(),
                           loginDto.getPassword()
                   )
                );

        SecurityContextHolder.getContext().setAuthentication(authentication);

        String jwt = jwtProvider.generateToken(authentication);


        UserEntity user = (UserEntity) authentication.getPrincipal();

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(convertUserToJwtUserResponse(user, jwt));

    }

    @GetMapping("/me")
    public ResponseEntity<?> quienSoyYo(@AuthenticationPrincipal UserEntity user){
        return ResponseEntity.ok(userDtoConverter.convertUserEntityToGetUserDto(user));
    }


    private JwtUserResponse convertUserToJwtUserResponse(UserEntity user, String jwt) {
        return JwtUserResponse.builder()
                .nickname(user.getNickname())
                .email(user.getEmail())
                .avatar(user.getAvatar())
                .role(user.getRole())
                .token(jwt)
                .build();
    }


}
