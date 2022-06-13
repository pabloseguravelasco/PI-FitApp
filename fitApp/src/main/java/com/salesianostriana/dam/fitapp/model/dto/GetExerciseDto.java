package com.salesianostriana.dam.fitapp.model.dto;

import com.salesianostriana.dam.fitapp.security.users.dto.GetUserDto;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetExerciseDto {

    private Long id;
    private String title;
    private String text;
    private String imagen;
    private String duration;
    private String link;
    private String zone;

    private GetUserDto user;
}
