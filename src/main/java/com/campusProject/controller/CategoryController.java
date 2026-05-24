package com.campusProject.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.campusProject.entity.Category;
import com.campusProject.repo.CategoryRepo;

@Controller
public class CategoryController {

	@Autowired
    private CategoryRepo categoryRepo;

    // ================================
    // 1️⃣ ADD CATEGORY
    // ================================
    @RequestMapping("/addCategory")
    public String addCategory(Category category) {

        Optional<Category> existing =
                categoryRepo.findByNameIgnoreCase(category.getName());

        if (existing.isPresent()) {
            return "redirect:/categories?error=exists";
        }

        category.setStatus("ACTIVE");

        categoryRepo.save(category);

        return "redirect:/categories?success=added";
    }

    // ================================
    // 2️⃣ VIEW ALL CATEGORIES
    // ================================
    @RequestMapping("/categories")
    public ModelAndView manageCategories() {

        ModelAndView mv = new ModelAndView();

        List<Category> categories = categoryRepo.findAll();

        mv.addObject("categories", categories);
        mv.setViewName("admin/Categories.jsp");

        return mv;
    }

    // ================================
    // 3️⃣ TOGGLE STATUS (Delete Button)
    // ================================
    @RequestMapping("/toggleCategoryStatus")
    public String toggleCategoryStatus(@RequestParam Long id) {

        Category category = categoryRepo.findById(id).orElse(null);

        if (category != null) {

            if ("ACTIVE".equals(category.getStatus())) {
                category.setStatus("INACTIVE");
            } else {
                category.setStatus("ACTIVE");
            }

            categoryRepo.save(category);
        }

        return "redirect:/categories";
    }

    // ================================
    // 4️⃣ OPEN EDIT FORM
    // ================================
    @RequestMapping("/openEditCategory")
    public ModelAndView openEditCategory(@RequestParam Long categoryId) {

        ModelAndView mv = new ModelAndView();

        Category category = categoryRepo.findById(categoryId).orElse(null);

        List<Category> categories = categoryRepo.findAll();

        mv.addObject("editCategory", category);
        mv.addObject("categories", categories);

        mv.setViewName("admin/Categories.jsp");

        return mv;
    }

    // ================================
    // 5️⃣ UPDATE CATEGORY
    // ================================
    @RequestMapping("/updateCategory")
    public String updateCategory(@RequestParam Long id,
                                 @RequestParam String name) {

        Category category = categoryRepo.findById(id).orElse(null);

        if (category != null) {
            category.setName(name);
            categoryRepo.save(category);
        }

        return "redirect:/categories?success=updated";
    }
}


