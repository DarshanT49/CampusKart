package com.campusProject.controller;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.campusProject.entity.College;
import com.campusProject.entity.CollegeRequest;
import com.campusProject.entity.User;
import com.campusProject.repo.AuthRepo;
import com.campusProject.repo.CollegeRepo;
import com.campusProject.repo.CollegeRequestRepo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

    private final CollegeRepo collegeRepo;

	@Autowired
	private AuthRepo authRepo;

	@Autowired
	private CollegeRequestRepo collegeRequestRepo;

    AuthController(CollegeRepo collegeRepo) {
        this.collegeRepo = collegeRepo;
    }

	@RequestMapping("/login")
	public ModelAndView openAuthPage() {

	    ModelAndView mv = new ModelAndView();

	    // 🔥 Get only ACTIVE colleges
	    List<College> colleges = collegeRepo.findByStatus("ACTIVE");

	    mv.addObject("colleges", colleges);
	    mv.setViewName("Auth.jsp");

	    return mv;
	}

	@RequestMapping("/loginUser")
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String pass,
			HttpSession session) {

		Optional<User> opt = authRepo.findByEmail(email);

		if (opt.isPresent()) {
			User user = opt.get();

			if (pass.equals(user.getPassword())) {

				if ("ACTIVE".equals(user.getStatus())) {

					session.setAttribute("loggedUser", user); // 🔥 Store user

					return "ADMIN".equals(user.getRole()) ? "/dashboard" : "redirect:/home";
				}

				if ("PENDING_COLLEGE".equals(user.getStatus())) {
					session.setAttribute("loggedUser", user);
					return "redirect:/home";
				}
			}
		}

		return "redirect:/login?error=invalid";
	}

	@RequestMapping("/registerUser")
	public String registerUser(User user, @RequestParam(required = false) String collegeName,
			@RequestParam(required = false) String address, @RequestParam(required = false) String pincode) {

		Optional<User> existingUser = authRepo.findByEmail(user.getEmail());

		if (existingUser.isPresent()) {
			return "redirect:/login?error=exists";
		}

		user.setRole("USER");

		// 🔥 If college not selected (id = 0)
		if (user.getCollegeId() != null && user.getCollegeId() == 0) {

			user.setStatus("PENDING_COLLEGE");

			// Save user first to get ID
			User savedUser = authRepo.save(user);

			// Create college request
			CollegeRequest request = new CollegeRequest();
			request.setCollegeName(collegeName);
			request.setAddress(address);
			request.setPincode(pincode);
			request.setUserId(savedUser.getId());
			request.setStatus("PENDING");

			collegeRequestRepo.save(request);

		} else {

			// College exists
			user.setStatus("ACTIVE");
			authRepo.save(user);
		}

		return "redirect:/login?success=registered";
	}

	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession(false);

		if (session != null) {
			session.invalidate();
		}

		return "redirect:/home";
	}
}
