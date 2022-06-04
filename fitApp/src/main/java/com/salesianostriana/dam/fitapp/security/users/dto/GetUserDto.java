package com.salesianostriana.dam.fitapp.security.users.dto;

import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.model.Exercise;
import lombok.*;


import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetUserDto {

    private UUID id;
    private String nickname;
    private LocalDate fechaNacimiento;
    private String email;
    private String role;
    private String password;
    private String avatar;

    private List<Diet> listFavDiets;
    private List<Exercise> listFavExercises;



}
