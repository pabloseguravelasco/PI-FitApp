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
public class Exercise {

    @Id
    @GeneratedValue
    private Long id;

    private String title;
    private String text;
    private String imagen;
    private int duration;
    private String link;



    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;
}
