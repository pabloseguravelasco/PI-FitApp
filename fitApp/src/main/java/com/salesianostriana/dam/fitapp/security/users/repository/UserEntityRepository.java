package com.salesianostriana.dam.fitapp.security.users.repository;

import com.salesianostriana.dam.fitapp.model.Diet;
import com.salesianostriana.dam.fitapp.model.Exercise;
import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserEntityRepository extends JpaRepository<UserEntity, UUID> {

    Optional<UserEntity> findFirstByEmail(String email);

    @Query(
            """
            select u.listFavExercises
            from UserEntity u
            where u.id = :id
            """
    )
    List<Exercise> findExercisesFav(@Param("id") UUID id);

    @Query(
            """
            select u.listFavDiets
            from UserEntity u
            where u.id = :id
            """
    )
    List<Diet> findDietsFav(@Param("id") UUID id);

}
