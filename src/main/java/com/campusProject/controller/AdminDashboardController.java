package com.campusProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.campusProject.entity.CollegeRequest;
import com.campusProject.entity.Product;
import com.campusProject.repo.AuthRepo;
import com.campusProject.repo.CollegeRequestRepo;
import com.campusProject.repo.ProductRepo;

@Controller
public class AdminDashboardController {

    @Autowired
    private AuthRepo authRepo;

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private CollegeRequestRepo collegeRequestRepo;

    @RequestMapping("/dashboard")
    public String adminDashboard(Model model) {
        // Stats
        long totalUsers = authRepo.countByRole("USER");
        long activeProducts = productRepo.countByStatus("AVAILABLE");
        long pendingColleges = collegeRequestRepo.countByStatus("PENDING");
        
        // Calculate "Monthly Sales" - for now just sum all SOLD products price as a placeholder for "Total Sales"
        // In a real app, you'd filter by current month
        List<Product> soldProducts = productRepo.findByStatus("SOLD");
        double totalSales = soldProducts.stream().mapToDouble(Product::getPrice).sum();

        // Recent Data
        List<Product> recentProducts = productRepo.findTop5ByOrderByCreatedAtDesc();
        List<CollegeRequest> pendingRequests = collegeRequestRepo.findTop5ByStatusOrderByCreatedAtDesc("PENDING");

        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("activeProducts", activeProducts);
        model.addAttribute("pendingColleges", pendingColleges);
        model.addAttribute("totalSales", totalSales);
        model.addAttribute("recentProducts", recentProducts);
        model.addAttribute("pendingRequests", pendingRequests);

        return "admin/AdminDashboard.jsp";
    }
}
