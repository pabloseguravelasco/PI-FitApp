package com.salesianostriana.dam.fitapp.security.dto;

import com.salesianostriana.dam.fitapp.security.users.model.UserRole;
import lombok.*;

import java.time.LocalDate;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class JwtUserResponse {

    private String nickname;
    private String email;
    private String avatar;
    private String token;
    private UserRole role;

}
