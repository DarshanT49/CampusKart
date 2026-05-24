package com.campusProject.controller;

import java.util.*;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.campusProject.entity.College;
import com.campusProject.entity.User;
import com.campusProject.repo.AuthRepo;
import com.campusProject.repo.CollegeRepo;
import com.campusProject.repo.ProductRepo;

@Controller
public class AdminUserController {
	
	@Autowired
	private AuthRepo authRepo;
	
	@Autowired
	private CollegeRepo collegeRepo;
	
	@Autowired
	private ProductRepo productRepo;
	
	
	@GetMapping("/users")
	public ModelAndView manageUsers() {

	    ModelAndView mv = new ModelAndView();
	    List<User> users = authRepo.findAll();

	    List<User> activeUsers = authRepo.findByStatus("ACTIVE");
	    List<User> pendingUsers = authRepo.findByStatus("PENDING");
	    List<User> blockedUsers = authRepo.findByStatus("BLOCKED");

	    mv.addObject("activeUsers", activeUsers);
	    mv.addObject("pendingUsers", pendingUsers);
	    mv.addObject("blockedUsers", blockedUsers);
	    
	    Map<Long, String> collegeMap = new HashMap<>();
	    Map<Long, Long> productCountMap = new HashMap<>();

	    for (User user : users) {

	        // Fetch college name
	        if (user.getCollegeId() != null) {
	            College college = collegeRepo
	                    .findById(user.getCollegeId())
	                    .orElse(null);

	            if (college != null) {
	                collegeMap.put(user.getId(), college.getShortName());
	            }
	        }

	        // Fetch product count
	        Long count = productRepo.countProductsByUserId(user.getId());
	        productCountMap.put(user.getId(), count);
	    }
	    mv.addObject("users", users);
	    mv.addObject("collegeMap", collegeMap);
	    mv.addObject("productCountMap", productCountMap);

	    mv.setViewName("admin/Users.jsp");

	    return mv;
	}
	
	@GetMapping("/updateUserStatus")
	public String updateUserStatus(@RequestParam Long id,
	                               @RequestParam String status) {

	    User user = authRepo.findById(id).orElse(null);

	    if (user != null) {
	        user.setStatus(status);
	        authRepo.save(user);
	    }

	    return "redirect:/users";
	}
	


}
