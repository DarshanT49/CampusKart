package com.campusProject.repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.campusProject.entity.College;

public interface CollegeRepo extends JpaRepository<College, Long> {

	Optional<College> findByNameIgnoreCaseAndAddressIgnoreCase(String name, String address);
	List<College> findByStatus(String status);
}
