package com.salesianostriana.dam.fitapp.model.dto;

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
    private int duration;
    private String link;

}
