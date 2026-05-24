package com.campusProject.controller;

import com.campusProject.entity.User;
import com.campusProject.entity.UserBlock;
import com.campusProject.entity.UserReport;
import com.campusProject.repo.UserBlockRepo;
import com.campusProject.repo.UserReportRepo;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/user")
public class UserActionController {

    @Autowired
    private UserBlockRepo userBlockRepo;

    @Autowired
    private UserReportRepo userReportRepo;

    @PostMapping("/block")
    public ResponseEntity<?> blockUser(@RequestBody Map<String, Long> payload, HttpSession session) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) return ResponseEntity.status(401).body("Unauthorized");

        Long blockedId = payload.get("blockedId");
        if (blockedId == null || blockedId.equals(loggedUser.getId())) {
            return ResponseEntity.badRequest().body("Invalid blocked user ID");
        }

        if (!userBlockRepo.existsByBlockerIdAndBlockedId(loggedUser.getId(), blockedId)) {
            UserBlock block = new UserBlock();
            block.setBlockerId(loggedUser.getId());
            block.setBlockedId(blockedId);
            userBlockRepo.save(block);
        }

        return ResponseEntity.ok(Map.of("message", "User blocked successfully"));
    }

    @PostMapping("/unblock")
    public ResponseEntity<?> unblockUser(@RequestBody Map<String, Long> payload, HttpSession session) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) return ResponseEntity.status(401).body("Unauthorized");

        Long blockedId = payload.get("blockedId");
        Optional<UserBlock> block = userBlockRepo.findByBlockerIdAndBlockedId(loggedUser.getId(), blockedId);
        
        if (block.isPresent()) {
            userBlockRepo.delete(block.get());
            return ResponseEntity.ok(Map.of("message", "User unblocked successfully"));
        }

        return ResponseEntity.badRequest().body("Block record not found");
    }

    @PostMapping("/report")
    public ResponseEntity<?> reportUser(@RequestBody UserReport report, HttpSession session) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) return ResponseEntity.status(401).body("Unauthorized");

        if (report.getReportedId() == null || report.getReportedId().equals(loggedUser.getId())) {
            return ResponseEntity.badRequest().body("Invalid reported user ID");
        }

        report.setReporterId(loggedUser.getId());
        report.setStatus("PENDING");
        userReportRepo.save(report);

        // Auto-suspension logic (optional)
        long reportCount = userReportRepo.countByReportedId(report.getReportedId());
        if (reportCount >= 5) {
            // Logic to notify admin or auto-suspend could go here
        }

        return ResponseEntity.ok(Map.of("message", "Report submitted successfully"));
    }
}
