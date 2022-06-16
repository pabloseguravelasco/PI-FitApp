package com.salesianostriana.dam.fitapp.model;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;


import java.util.List;

public interface DietRepository extends JpaRepository<Diet, Long> {

    List<Diet> findByUserNickname(String nickname);

    Page<Diet> findAll(Pageable pageable);
}
