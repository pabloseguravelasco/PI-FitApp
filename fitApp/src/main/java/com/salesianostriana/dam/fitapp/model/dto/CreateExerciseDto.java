package com.salesianostriana.dam.fitapp.model.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateExerciseDto {

    private String title;
    private String text;
    private String imagen;
    private String duration;
    private String link;


}