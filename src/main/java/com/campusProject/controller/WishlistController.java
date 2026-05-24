package com.campusProject.controller;

import com.campusProject.entity.*;
import com.campusProject.repo.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
public class WishlistController {

    @Autowired
    private WishlistRepo wishlistRepo;

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private AuthRepo authRepo;

    @Autowired
    private CollegeRepo collegeRepo;

    // ================= VIEW WISHLIST =================

    @RequestMapping("/wishlist")
    public ModelAndView viewWishlist(HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null)
            return new ModelAndView("redirect:/login");

        List<Wishlist> wishlist =
                wishlistRepo.findByUserIdAndStatus(user.getId(), "ACTIVE");

        Map<Long, Product> productMap = new HashMap<>();
        Map<Long, College> collegeMap = new HashMap<>();

        for (Wishlist w : wishlist) {
            Product p = productRepo.findById(w.getProductId()).orElse(null);
            if (p != null) {
                productMap.put(w.getId(), p);

                College c = collegeRepo.findById(p.getSeller().getCollegeId()).orElse(null);
                if (c != null) {
                    collegeMap.put(w.getId(), c);
                }
            }
        }

        ModelAndView mv = new ModelAndView("Wishlist.jsp");
        mv.addObject("wishlist", wishlist);
        mv.addObject("productMap", productMap);
        mv.addObject("collegeMap", collegeMap);

        return mv;
    }

    // ================= ADD TO WISHLIST =================

    @PostMapping("/addToWishlist")
    public String addToWishlist(@RequestParam Long productId,
                                HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null)
            return "redirect:/login";

        Optional<Wishlist> existing =
                wishlistRepo.findByUserIdAndProductId(user.getId(), productId);

        if (existing.isPresent()) {
            Wishlist w = existing.get();
            w.setStatus("ACTIVE");
            wishlistRepo.save(w);
        } else {
            Wishlist w = new Wishlist();
            w.setUserId(user.getId());
            w.setProductId(productId);
            w.setStatus("ACTIVE");
            wishlistRepo.save(w);
        }

        return "redirect:/wishlist";
    }

    // ================= REMOVE (SOFT DELETE) =================

    @PostMapping("/removeFromWishlist")
    public String remove(@RequestParam Long id) {

        Wishlist w = wishlistRepo.findById(id).orElse(null);
        if (w != null) {
            w.setStatus("REMOVED");
            wishlistRepo.save(w);
        }

        return "redirect:/wishlist";
    }
    
    @RequestMapping("/addToWishlist")
    public String addToWishlist1(@RequestParam Long productId,
                                HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");

        if (user == null)
            return "redirect:/login";

        Optional<Wishlist> existing =
                wishlistRepo.findByUserIdAndProductId(user.getId(), productId);

        if (existing.isPresent()) {

            Wishlist w = existing.get();
            w.setStatus("ACTIVE");
            wishlistRepo.save(w);

        } else {

            Wishlist w = new Wishlist();
            w.setUserId(user.getId());
            w.setProductId(productId);
            w.setStatus("ACTIVE");
            wishlistRepo.save(w);
        }

        return "redirect:/wishlist";
    }
}