package com.campusProject.repo;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.campusProject.entity.Conversation;

public interface ConversationRepo extends JpaRepository<Conversation, Long> {

    Optional<Conversation> findByProductIdAndBuyerIdAndSellerId(
        Long productId, Long buyerId, Long sellerId);
    
    List<Conversation> findByBuyerIdOrSellerId(Long buyerId, Long sellerId);
    
    
    List<Conversation> findByBuyerId(Long buyerId);

    List<Conversation> findBySellerId(Long sellerId);

}