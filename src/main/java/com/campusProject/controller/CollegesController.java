package com.campusProject.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.campusProject.entity.College;
import com.campusProject.entity.CollegeRequest;
import com.campusProject.entity.User;
import com.campusProject.repo.AuthRepo;
import com.campusProject.repo.CollegeRepo;
import com.campusProject.repo.CollegeRequestRepo;

@Controller
public class CollegesController {

	@Autowired
    private final AuthRepo authRepo;
	
	@Autowired
	private CollegeRepo collegeRepo;
	
	@Autowired
	private CollegeRequestRepo collegeRequestRepo;


    CollegesController(AuthRepo authRepo) {
        this.authRepo = authRepo;
    }

	


	@RequestMapping("/addCollege")
	public String addCollege(College college) {

	    Optional<College> existingCollege =
	            collegeRepo.findByNameIgnoreCaseAndAddressIgnoreCase(
	                    college.getName(),
	                    college.getAddress()
	            );
	    
	    college.setStatus("ACTIVE");

	    // If college already exists
	    if (existingCollege.isPresent()) {
	        return "redirect:/colleges?error=exists";
	    }

	    collegeRepo.save(college);

	    return "redirect:/colleges?success=added";
	}
	



	@RequestMapping("/colleges")
	public ModelAndView manageColleges() {

	    ModelAndView mv = new ModelAndView();

	    // 1️⃣ Get all registered colleges
	    List<College> colleges = collegeRepo.findAll();

	    // 2️⃣ Get pending college requests
	    List<CollegeRequest> pendingRequests =
	            collegeRequestRepo.findByStatus("PENDING");

	    // 3️⃣ Add data to model
	    mv.addObject("colleges", colleges);
	    mv.addObject("pendingRequests", pendingRequests);

	    // 4️⃣ Set view name
	    mv.setViewName("admin/ManageCollege.jsp");

	    return mv;
	}

	@RequestMapping("/openApproveForm")
	public ModelAndView openApproveForm(@RequestParam("requestId") Long requestId) {

	    ModelAndView mv = new ModelAndView();

	    CollegeRequest request = collegeRequestRepo.findById(requestId).orElse(null);

	    List<College> colleges = collegeRepo.findAll();
	    List<CollegeRequest> pendingRequests =
	            collegeRequestRepo.findByStatus("PENDING");

	    mv.addObject("approveRequest", request); // 🔥 Important
	    mv.addObject("colleges", colleges);
	    mv.addObject("pendingRequests", pendingRequests);

	    mv.setViewName("admin/ManageCollege.jsp");

	    return mv;
	}
	
	@RequestMapping("/approveCollege")
	public ModelAndView approveCollege(
	        @RequestParam Long requestId,
	        @RequestParam String name,
	        @RequestParam String address,
	        @RequestParam String shortName,
	        @RequestParam String pincode) {

	    ModelAndView mv = new ModelAndView();

	    // 1️⃣ Check if college already exists
	    Optional<College> existingCollege =
	            collegeRepo.findByNameIgnoreCaseAndAddressIgnoreCase(name, address);

	    College college;

	    if (existingCollege.isPresent()) {

	        college = existingCollege.get();

	    } else {

	        college = new College();
	        college.setName(name);
	        college.setAddress(address);
	        college.setShortName(shortName);
	        college.setPincode(pincode);

	        college = collegeRepo.save(college);  // 🔥 Saved properly
	    }

	    // 2️⃣ Get request
	    CollegeRequest request =
	            collegeRequestRepo.findById(requestId).orElse(null);

	    if (request != null) {

	        // 🔥 FIX HERE
	        User user = authRepo.findById(request.getUserId()).orElse(null);

	        if (user != null) {
	            user.setCollegeId(college.getId());
	            user.setStatus("ACTIVE");
	            authRepo.save(user);
	        }

	        request.setStatus("APPROVED");
	        collegeRequestRepo.save(request);
	    }

	    mv.setViewName("redirect:/colleges?success=approved");

	    return mv;
	}

	@RequestMapping("/toggleCollegeStatus")
	public ModelAndView toggleCollegeStatus(@RequestParam Long id) {

	    ModelAndView mv = new ModelAndView();

	    College college = collegeRepo.findById(id).orElse(null);

	    if (college != null) {

	        if ("ACTIVE".equals(college.getStatus())) {
	            college.setStatus("INACTIVE");
	        } else {
	            college.setStatus("ACTIVE");
	        }

	        collegeRepo.save(college);
	    }

	    mv.setViewName("redirect:/colleges");

	    return mv;
	}
	
	
	@RequestMapping("/openEditCollege")
	public ModelAndView openEditCollege(@RequestParam Long collegeId) {

	    ModelAndView mv = new ModelAndView();

	    College college = collegeRepo.findById(collegeId).orElse(null);

	    List<College> colleges = collegeRepo.findAll();
	    List<CollegeRequest> pendingRequests =
	            collegeRequestRepo.findByStatus("PENDING");

	    mv.addObject("editCollege", college);  // 🔥 Important
	    mv.addObject("colleges", colleges);
	    mv.addObject("pendingRequests", pendingRequests);

	    mv.setViewName("admin/ManageCollege.jsp");

	    return mv;
	}
	
	@PostMapping("/updateCollege")
	public ModelAndView updateCollege(
	        @RequestParam Long collegeId,
	        @RequestParam String name,
	        @RequestParam String address,
	        @RequestParam String shortName,
	        @RequestParam String pincode) {

	    ModelAndView mv = new ModelAndView();

	    College college = collegeRepo.findById(collegeId).orElse(null);

	    if (college != null) {

	        // 🔥 Check duplicate except current one
	        Optional<College> existing =
	                collegeRepo.findByNameIgnoreCaseAndAddressIgnoreCase(name, address);

	        if (existing.isPresent() && 
	            !existing.get().getId().equals(collegeId)) {

	            mv.setViewName("redirect:/colleges?error=duplicate");
	            return mv;
	        }

	        // ✅ Update fields
	        college.setName(name);
	        college.setAddress(address);
	        college.setShortName(shortName);
	        college.setPincode(pincode);

	        collegeRepo.save(college);
	    }

	    mv.setViewName("redirect:/colleges?success=updated");
	    return mv;
	}

}
