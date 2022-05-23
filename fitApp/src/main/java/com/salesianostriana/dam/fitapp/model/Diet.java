package com.salesianostriana.dam.fitapp.model;

import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import lombok.*;

import javax.persistence.*;

@Entity
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Diet {

    @Id
    @GeneratedValue
    private Long id;

    private String title;
    private String ingredient;
    private double calories;
    private String imagen;


}
