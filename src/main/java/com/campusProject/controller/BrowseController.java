package com.campusProject.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.campusProject.entity.Product;
import com.campusProject.entity.User;
import com.campusProject.repo.ProductRepo;
import com.campusProject.repo.CategoryRepo;
import com.campusProject.repo.CollegeRepo;

import jakarta.servlet.http.HttpSession;

@Controller
public class BrowseController {

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private CategoryRepo categoryRepo;

    @Autowired
    private CollegeRepo collegeRepo;

	private Boolean finalMyCampus;

    @RequestMapping("/browse")
    public ModelAndView browseProducts(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) Long collegeId,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(required = false) Boolean myCampus,
            HttpSession session) {

    	
        ModelAndView mv = new ModelAndView();

        User loggedUser = (User) session.getAttribute("loggedUser");
        
        finalMyCampus = false;

        if (loggedUser != null 
            && "ACTIVE".equals(loggedUser.getStatus())
            && Boolean.TRUE.equals(myCampus)) {

            finalMyCampus = true;
        }

        List<Product> products = productRepo.filterProducts(
                category,
                collegeId,
                minPrice,
                maxPrice,
                myCampus,
                loggedUser != null ? loggedUser.getCollegeId() : null
        );

        mv.addObject("products", products);
        mv.addObject("categories", categoryRepo.findAll());
        mv.addObject("colleges", collegeRepo.findAll());

        mv.setViewName("Browse.jsp");

        return mv;
    }
    
    
    @RequestMapping("/viewProduct")
    public ModelAndView viewProduct(@RequestParam("id") Long id) {

        ModelAndView mv = new ModelAndView();

        Product product = productRepo.findById(id).orElse(null);

        if (product == null) {
            mv.setViewName("redirect:/browse");
            return mv;
        }

        // Similar products (same category, exclude current)
        List<Product> similarProducts =
                productRepo.findAll()
                        .stream()
                        .filter(p -> p.getCategory().getId()
                                .equals(product.getCategory().getId()))
                        .filter(p -> !p.getId().equals(product.getId()))
                        .filter(p -> "AVAILABLE".equals(p.getStatus()))
                        .limit(4)
                        .collect(Collectors.toList());

        String collegeName = collegeRepo.findById(
                product.getSeller().getCollegeId())
                .map(c -> c.getShortName() != null
                        ? c.getShortName()
                        : c.getName())
                .orElse("Unknown");
        
        String collegeAddress = collegeRepo.findById(
                product.getSeller().getCollegeId())
                .map(c -> c.getAddress())
                .orElse("Unknown");

        mv.addObject("collegeAddress", collegeAddress);

        mv.addObject("product", product);
        mv.addObject("similarProducts", similarProducts);
        mv.addObject("collegeName", collegeName);

        mv.setViewName("ProductDetail.jsp");

        return mv;
    }
}