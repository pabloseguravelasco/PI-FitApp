package com.salesianostriana.dam.fitapp.security.users.dto;

import lombok.*;


import java.time.LocalDate;
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
    private String password2;
    private String avatar;
    private boolean publico;
    /*private List<UserEntity> seguidores;
    private List<UserEntity> seguidos;*/


}
