package com.campusProject.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.campusProject.entity.Product;
import com.campusProject.entity.User;

public interface ProductRepo extends JpaRepository<Product, Long> {
	
	List<Product> findBySeller(User seller);
	List<Product> findBySellerAndStatus(User seller, String status);
	
	List<Product> findTop4ByStatusOrderByCreatedAtDesc(String status);
	
	
	@Query("""
			SELECT p FROM Product p, User u, College c
			WHERE p.status = 'AVAILABLE'
			AND p.seller.id = u.id
			AND u.collegeId = c.id
			AND (:category IS NULL OR p.category.name = :category)
			AND (:collegeId IS NULL OR u.collegeId = :collegeId)
			AND (:minPrice IS NULL OR p.price >= :minPrice)
			AND (:maxPrice IS NULL OR p.price <= :maxPrice)
			AND (:myCampus IS NULL OR :myCampus = false OR u.collegeId = :userCollegeId)
			""")
			List<Product> filterProducts(
			        @Param("category") String category,
			        @Param("collegeId") Long collegeId,
			        @Param("minPrice") Double minPrice,
			        @Param("maxPrice") Double maxPrice,
			        @Param("myCampus") Boolean myCampus,
			        @Param("userCollegeId") Long userCollegeId
			);
	
	@Query("SELECT COUNT(p) FROM Product p WHERE p.seller.id = :userId")
	Long countProductsByUserId(@Param("userId") Long userId);
	
	
    List<Product> findByStatus(String status);

    List<Product> findByStatusNot(String status);
    
    long countByStatus(String status);
    
    List<Product> findTop5ByOrderByCreatedAtDesc();
}
