package com.salesianostriana.dam.fitapp.model.dto;


import com.salesianostriana.dam.fitapp.security.users.dto.GetUserDto;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserDtoConverter2 {

    public GetUserDto convertUserEntityToGetUserDtoWithoutList(UserEntity user) {



        return GetUserDto.builder()
                .id(user.getId())
                .nickname(user.getNickname())
                .email(user.getEmail())
                .role(user.getRole().name())
                .password(user.getPassword())
                .avatar(user.getAvatar())
                .build();




    }
}
