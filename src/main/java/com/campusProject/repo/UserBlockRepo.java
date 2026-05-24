package com.campusProject.repo;

import com.campusProject.entity.UserBlock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserBlockRepo extends JpaRepository<UserBlock, Long> {
    boolean existsByBlockerIdAndBlockedId(Long blockerId, Long blockedId);
    Optional<UserBlock> findByBlockerIdAndBlockedId(Long blockerId, Long blockedId);
    
    // Check if either user has blocked the other
    default boolean isBlocked(Long user1, Long user2) {
        return existsByBlockerIdAndBlockedId(user1, user2) || existsByBlockerIdAndBlockedId(user2, user1);
    }
}
