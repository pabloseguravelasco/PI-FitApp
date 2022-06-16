package com.salesianostriana.dam.fitapp.model.dto;


import com.salesianostriana.dam.fitapp.security.users.dto.GetUserDto;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetDietDto {

    private Long id;
    private String title;
    private String ingredient;
    private String calories;
    private String imagen;

    private GetUserDto user;
}

