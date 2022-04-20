package com.salesianostriana.dam.fitapp.model;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExerciseRepository extends JpaRepository<Exercise, Long> {

    List<Exercise> findByPublico(Boolean publico);

    List<Exercise> findByUserNickname(String nickname);

}
