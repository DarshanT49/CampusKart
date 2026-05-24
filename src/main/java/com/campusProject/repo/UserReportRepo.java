package com.campusProject.repo;

import com.campusProject.entity.UserReport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserReportRepo extends JpaRepository<UserReport, Long> {
    List<UserReport> findByStatus(String status);
    long countByReportedId(Long reportedId);
}
