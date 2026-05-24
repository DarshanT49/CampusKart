package com.campusProject.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.campusProject.entity.CollegeRequest;

public interface CollegeRequestRepo extends JpaRepository<CollegeRequest, Long> {

	 List<CollegeRequest> findByStatus(String status);
	 
	 long countByStatus(String status);
	 
	 List<CollegeRequest> findTop5ByStatusOrderByCreatedAtDesc(String status);
}
