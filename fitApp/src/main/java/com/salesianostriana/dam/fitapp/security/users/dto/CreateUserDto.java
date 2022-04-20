package com.salesianostriana.dam.fitapp.security.users.dto;

import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateUserDto {

    @NotNull(message = "UserEntity.nickname.null")
    @NotBlank(message = "UserEntity.nickname.blank")

    private String nickname;

    private LocalDate fechaNacimiento;

    @NotNull(message = "UserEntity.email.null")
    @NotBlank(message = "UserEntity.email.blank")
    private String email;

    @NotNull(message = "UserEntity.password.null")
    @NotBlank(message = "UserEntity.password.blank")
    private String password;

    private String password2;
    private String avatar;
    private boolean publico;

}