package com.salesianostriana.dam.fitapp.model;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExerciseRepository extends JpaRepository<Exercise, Long> {


    List<Exercise> findByUserNickname(String nickname);

}
