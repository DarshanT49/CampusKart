package com.campusProject.controller;

import java.util.List;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.campusProject.entity.College;
import com.campusProject.entity.Product;
import com.campusProject.entity.User;
import com.campusProject.repo.AuthRepo;
import com.campusProject.repo.CollegeRepo;
import com.campusProject.repo.ProductRepo;

@Controller
public class AdminProductController {

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private AuthRepo authRepo;

    @Autowired
    private CollegeRepo collegeRepo;

    // ================= VIEW PRODUCTS =================
    @GetMapping("/products")
    public ModelAndView manageProducts(
            @RequestParam(required = false) String status) {

        ModelAndView mv = new ModelAndView();

        List<Product> products;
        List<Product> removedProducts;

        if (status == null || status.equals("all")) {
            products = productRepo.findByStatusNot("REMOVED");
        } else {
            products = productRepo.findByStatus(status.toUpperCase());
        }

        // 🔥 Fetch removed products separately
        removedProducts = productRepo.findByStatus("REMOVED");

        Map<Long, String> sellerNameMap = new HashMap<>();
        Map<Long, String> collegeNameMap = new HashMap<>();

        // Merge both lists for mapping
        List<Product> allProducts = new ArrayList<>();
        allProducts.addAll(products);
        allProducts.addAll(removedProducts);

        for (Product product : allProducts) {

            Optional<User> userOpt = authRepo.findById(product.getId());

            if (userOpt.isPresent()) {
                User user = userOpt.get();
                sellerNameMap.put(product.getId(), user.getName());

                if (user.getCollegeId() != null) {
                    Optional<College> collegeOpt =
                            collegeRepo.findById(user.getCollegeId());

                    collegeOpt.ifPresent(college ->
                            collegeNameMap.put(product.getId(), college.getShortName())
                    );
                }
            }
        }

        mv.addObject("products", products);
        mv.addObject("removedProducts", removedProducts);
        mv.addObject("sellerNameMap", sellerNameMap);
        mv.addObject("collegeNameMap", collegeNameMap);
        mv.addObject("activeFilter", status == null ? "all" : status);

        mv.setViewName("admin/Products.jsp");
        return mv;
    }

    // ================= REMOVE PRODUCT (SOFT DELETE) =================
    @GetMapping("/removeProduct")
    public String removeProduct(@RequestParam Long id) {

        Product product = productRepo.findById(id).orElse(null);

        if (product != null) {
            product.setStatus("REMOVED");
            productRepo.save(product);
        }

        return "redirect:/products";
    }
    
    
    @GetMapping("/restoreProduct")
    public String restoreProduct(@RequestParam Long id) {

        Product product = productRepo.findById(id).orElse(null);

        if (product != null) {
            product.setStatus("AVAILABLE");
            productRepo.save(product);
        }

        return "redirect:/products";
    }
}