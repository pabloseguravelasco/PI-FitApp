package com.salesianostriana.dam.fitapp.model.dto;


import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateDietDto {

    private String title;
    private String ingredient;
    private String calories;
    private String imagen;
}
