package com.campusProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.campusProject.entity.Category;
import com.campusProject.entity.Product;
import com.campusProject.entity.User;
import com.campusProject.repo.CategoryRepo;
import com.campusProject.repo.ProductRepo;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

@Controller
public class AddProductController {

	@Autowired
	private CategoryRepo categoryRepo;
	
	@Autowired
	private ProductRepo productRepo;

	@RequestMapping("/sell")
	public ModelAndView Products() {
		ModelAndView mv = new ModelAndView();
		
		List<Category> categories = categoryRepo.findAll();
		mv.addObject("categories", categories);
		mv.setViewName("SellProduct.jsp");
		
		return mv;
	}
	

	
	@PostMapping("/addProduct")
	public String addProduct(Product product,
	                         @RequestParam("categoryId") Long categoryId,
	                         @RequestParam("imageFile1") MultipartFile file1,
	                         @RequestParam(value="imageFile2", required=false) MultipartFile file2,
	                         HttpSession session) {

	    User user = (User) session.getAttribute("loggedUser");

	    if (user == null) {
	        return "redirect:/login";
	    }

	    try {

	        // 📁 Upload folder path
	        String uploadDir = System.getProperty("user.dir") + "/uploads/";

	        File dir = new File(uploadDir);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }

	        // 🔥 Save Image 1
	     // Validate Image 1
	        if (!file1.isEmpty()) {

	            if (!isValidImage(file1)) {
	                return "redirect:/sell?error=invalidImage";
	            }

	            String fileName1 = UUID.randomUUID() + "_" + file1.getOriginalFilename();
	            Path path1 = Paths.get(uploadDir + fileName1);
	            Files.write(path1, file1.getBytes());

	            product.setImage1(fileName1);
	        }

	        // 🔥 Save Image 2 (Optional)
	        if (file2 != null && !file2.isEmpty()) {

	            if (!isValidImage(file2)) {
	                return "redirect:/sell?error=invalidImage";
	            }

	            String fileName2 = UUID.randomUUID() + "_" + file2.getOriginalFilename();
	            Path path2 = Paths.get(uploadDir + fileName2);
	            Files.write(path2, file2.getBytes());

	            product.setImage2(fileName2);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    Category category = categoryRepo.findById(categoryId).orElse(null);

	    product.setCategory(category);
	    product.setSeller(user);

	    productRepo.save(product);

	    return "redirect:/sell?success=true";
	}
	
	private boolean isValidImage(MultipartFile file) {

	    String contentType = file.getContentType();

	    return contentType != null &&
	           (contentType.equals("image/jpeg") ||
	            contentType.equals("image/png"));
	}
	
	
	
	
	
	@RequestMapping("/myProducts")
	public ModelAndView myListings(HttpSession session) {

	    ModelAndView mv = new ModelAndView();

	    User user = (User) session.getAttribute("loggedUser");

	    if (user == null) {
	        mv.setViewName("redirect:/login");
	        return mv;
	    }

	    List<Product> availableProducts =
	            productRepo.findBySellerAndStatus(user, "AVAILABLE");

	    List<Product> soldProducts =
	            productRepo.findBySellerAndStatus(user, "SOLD");

	    List<Product> removedProducts =
	            productRepo.findBySellerAndStatus(user, "REMOVED");

	    mv.addObject("availableProducts", availableProducts);
	    mv.addObject("soldProducts", soldProducts);
	    mv.addObject("removedProducts", removedProducts);

	    mv.setViewName("MyProducts.jsp");

	    return mv;
	}
	
	
	@RequestMapping("/markSold")
	public String markSold(@RequestParam Long id) {

	    Product product = productRepo.findById(id).orElse(null);

	    if (product != null) {
	        product.setStatus("SOLD");
	        productRepo.save(product);
	    }

	    return "redirect:/myProducts";
	}
	
	@RequestMapping("/removeProduct")
	public String removeProduct(@RequestParam Long id) {

	    Product product = productRepo.findById(id).orElse(null);

	    if (product != null) {
	        product.setStatus("REMOVED");
	        productRepo.save(product);
	    }

	    return "redirect:/myProducts";
	}
	
	@RequestMapping("/openEditProduct")
	public ModelAndView openEditProduct(@RequestParam Long id,
	                                    HttpSession session) {

	    ModelAndView mv = new ModelAndView();

	    User user = (User) session.getAttribute("loggedUser");

	    if (user == null) {
	        mv.setViewName("redirect:/login");
	        return mv;
	    }

	    List<Product> products = productRepo.findBySeller(user);
	    List<Category> categories = categoryRepo.findAll();

	    Product editProduct = productRepo.findById(id).orElse(null);

	    mv.addObject("products", products);
	    mv.addObject("editProduct", editProduct);
	    mv.addObject("categories", categories);

	    mv.setViewName("MyProducts.jsp");

	    return mv;
	}
	
	@PostMapping("/updateProduct")
	public String updateProduct(Product updatedProduct,
	                            @RequestParam("categoryId") Long categoryId,
	                            @RequestParam(value="imageFile1", required=false) MultipartFile file1,
	                            @RequestParam(value="imageFile2", required=false) MultipartFile file2) {

	    Product product = productRepo.findById(updatedProduct.getId()).orElse(null);

	    if (product != null) {

	        product.setTitle(updatedProduct.getTitle());
	        product.setShortDescription(updatedProduct.getShortDescription());
	        product.setDescription(updatedProduct.getDescription());
	        product.setPrice(updatedProduct.getPrice());
	        product.setBrand(updatedProduct.getBrand());
	        product.setProductCondition(updatedProduct.getProductCondition());

	        Category category = categoryRepo.findById(categoryId).orElse(null);
	        product.setCategory(category);

	        // 🔥 If new image uploaded → replace
	        // (Use same upload logic as addProduct)

	        productRepo.save(product);
	    }

	    return "redirect:/myProducts";
	}
	
	@RequestMapping("/undoToAvailable")
	public String undoToAvailable(@RequestParam Long id) {

	    Product product = productRepo.findById(id).orElse(null);

	    if (product != null) {
	        product.setStatus("AVAILABLE");
	        productRepo.save(product);
	    }

	    return "redirect:/myProducts";
	}
	
	
}
