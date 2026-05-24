package com.campusProject.repo;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.campusProject.entity.Category;

public interface CategoryRepo extends JpaRepository<Category, Long> {

    Optional<Category> findByNameIgnoreCase(String name);
}