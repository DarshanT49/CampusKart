package com.campusProject.controller;

import java.util.*;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.campusProject.entity.Category;
import com.campusProject.entity.Product;
import com.campusProject.repo.CategoryRepo;
import com.campusProject.repo.ProductRepo;
import com.campusProject.repo.CollegeRepo;

@Controller
public class HomeController {

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private CategoryRepo categoryRepo;

    @Autowired
    private CollegeRepo collegeRepo;

    @RequestMapping("/","/home")
        public ModelAndView homePage() {

        ModelAndView mv = new ModelAndView();

        // 🔥 Latest 4 products
        List<Product> featuredProducts =
                productRepo.findTop4ByStatusOrderByCreatedAtDesc("AVAILABLE");

        // 🔥 All ACTIVE categories
        List<Category> categories =
                categoryRepo.findAll()
                        .stream()
                        .filter(c -> "ACTIVE".equals(c.getStatus()))
                        .collect(Collectors.toList());

        // 🔥 Map Category → Icon (since DB doesn't store icons)
        Map<String, String> categoryIcons = new HashMap<>();

        categoryIcons.put("Books", "bi-book");
        categoryIcons.put("Electronics", "bi-laptop");
        categoryIcons.put("Lab Equipment", "bi-cpu");
        categoryIcons.put("Hostel Items", "bi-lamp");
        categoryIcons.put("Sports Items", "bi-trophy");
        categoryIcons.put("Project Kits", "bi-tools");
        categoryIcons.put("Notes & Study Material", "bi-journal-text");
        categoryIcons.put("Others", "bi-grid-3x3-gap");

        // 🔥 College Map (to show college name on product)
        Map<Long, String> collegeMap =
                collegeRepo.findAll()
                        .stream()
                        .collect(Collectors.toMap(
                                c -> c.getId(),
                                c -> c.getShortName() != null
                                        ? c.getShortName()
                                        : c.getName()
                        ));

        mv.addObject("featuredProducts", featuredProducts);
        mv.addObject("categories", categories);
        mv.addObject("categoryIcons", categoryIcons);
        mv.addObject("collegeMap", collegeMap);

        mv.setViewName("Home.jsp");

        return mv;
    }
}