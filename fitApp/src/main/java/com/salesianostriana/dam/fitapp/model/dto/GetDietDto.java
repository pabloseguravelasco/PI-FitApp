package com.salesianostriana.dam.fitapp.model.dto;


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
    private double calories;
    private String imagen;
}

