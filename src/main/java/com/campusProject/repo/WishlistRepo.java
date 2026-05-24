package com.campusProject.repo;

import com.campusProject.entity.Wishlist;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface WishlistRepo extends JpaRepository<Wishlist, Long> {

    List<Wishlist> findByUserIdAndStatus(Long userId, String status);

    Optional<Wishlist> findByUserIdAndProductId(Long userId, Long productId);
}