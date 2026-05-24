package com.campusProject.repo;

import java.util.List;
import java.util.Optional;


import org.springframework.data.jpa.repository.JpaRepository;

import com.campusProject.entity.User;

public interface AuthRepo extends JpaRepository<User, Long> {

	Optional<User> findByEmail(String email);
	
	List<User> findByStatus(String status);
	
	long countByRole(String role);

}
