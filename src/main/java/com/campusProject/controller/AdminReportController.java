package com.campusProject.controller;

import com.campusProject.entity.User;
import com.campusProject.entity.UserReport;
import com.campusProject.repo.AuthRepo;
import com.campusProject.repo.UserReportRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class AdminReportController {

    @Autowired
    private UserReportRepo userReportRepo;

    @Autowired
    private AuthRepo authRepo;

    @GetMapping("/reports")
    public ModelAndView listReports(@RequestParam(required = false) String status) {
        ModelAndView mv = new ModelAndView("admin/Reports.jsp");
        	
        List<UserReport> reports;
        if (status != null && !status.isEmpty() && !status.equals("ALL")) {
            reports = userReportRepo.findByStatus(status);
        } else {
            reports = userReportRepo.findAll();
        }

        Map<Long, User> userMap = new HashMap<>();
        for (UserReport r : reports) {
            userMap.putIfAbsent(r.getReporterId(), authRepo.findById(r.getReporterId()).orElse(null));
            userMap.putIfAbsent(r.getReportedId(), authRepo.findById(r.getReportedId()).orElse(null));
        }

        mv.addObject("reports", reports);
        mv.addObject("userMap", userMap);
        mv.addObject("activeStatus", status != null ? status : "ALL");
        return mv;
    }

    @PostMapping("/reports/updateStatus")
    public String updateStatus(@RequestParam Long reportId, @RequestParam String status) {
        Optional<UserReport> opt = userReportRepo.findById(reportId);
        if (opt.isPresent()) {
            UserReport report = opt.get();
            report.setStatus(status);
            userReportRepo.save(report);
        }
        return "redirect:/reports";
    }

    @PostMapping("/reports/suspendUser")
    public String suspendUser(@RequestParam Long userId, @RequestParam Long reportId) {
        Optional<User> opt = authRepo.findById(userId);
        if (opt.isPresent()) {
            User user = opt.get();
            user.setStatus("SUSPENDED");
            authRepo.save(user);
            
            // Mark the report as RESOLVED
            updateStatus(reportId, "RESOLVED");
        }
        return "redirect:/reports";
    }
}
