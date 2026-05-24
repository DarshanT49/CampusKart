package com.campusProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.campusProject.entity.*;
import com.campusProject.repo.*;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {

    @Autowired private ConversationRepo conversationRepo;
    @Autowired private MessageRepo messageRepo;
    @Autowired private ProductRepo productRepo;
    @Autowired private AuthRepo authRepo;
    @Autowired private UserBlockRepo userBlockRepo;

    // ==============================
    // OPEN CHAT PAGE
    // ==============================
    @RequestMapping("/chat")
    public ModelAndView openChat(
            @RequestParam(required = false) Long productId,
            @RequestParam(required = false) Long conversationId,
            @RequestParam(required = false, defaultValue = "all") String filter,
            HttpSession session) {

        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null)
            return new ModelAndView("redirect:/login");

        ModelAndView mv = new ModelAndView("Chat.jsp");
        Long userId = loggedUser.getId();

        // ========================
        // Load conversations list
        // ========================
        List<Conversation> conversations;
        
        String cleanFilter = (filter != null) ? filter.trim().toLowerCase() : "all";

        if ("buying".equals(cleanFilter)) {

            conversations = conversationRepo.findByBuyerId(userId);

        } else if ("selling".equals(cleanFilter)) {

            conversations = conversationRepo.findBySellerId(userId);

        } else {

            conversations = conversationRepo
                    .findByBuyerIdOrSellerId(userId, userId);
        }
        Map<Long, Product> productMap = new HashMap<>();
        Map<Long, User> otherUserMap = new HashMap<>();

        for (Conversation c : conversations) {

            Product product = productRepo.findById(c.getProductId()).orElse(null);

            if (product != null) {
                productMap.put(c.getId(), product);
                
                // Find the "other" user (if I'm buyer, other is seller. If I'm seller, other is buyer)
                Long otherId = c.getBuyerId().equals(userId) ? c.getSellerId() : c.getBuyerId();
                User other = authRepo.findById(otherId).orElse(null);
                if (other != null) {
                    otherUserMap.put(c.getId(), other);
                }
            }
        }

        mv.addObject("productMap", productMap);
        mv.addObject("otherUserMap", otherUserMap);

        mv.addObject("conversations", conversations);
        mv.addObject("activeFilter", cleanFilter);

        // ========================
        // Case 1: Clicked from product
        // ========================
        if (productId != null) {

            Product product =
                    productRepo.findById(productId).orElse(null);

            if (product != null) {

                Long sellerId = product.getSeller().getId();

                // Check if blocked before starting conversation
                if (userBlockRepo.isBlocked(userId, sellerId)) {
                    return new ModelAndView("redirect:/home?error=blocked");
                }

                Conversation conversation =
                        conversationRepo
                        .findByProductIdAndBuyerIdAndSellerId(
                                productId, userId, sellerId)
                        .orElse(null);

                if (conversation != null) {
                    conversationId = conversation.getId();
                } else {
                    // Create conversation immediately
                    conversation = new Conversation();
                    conversation.setProductId(productId);
                    conversation.setBuyerId(userId);
                    conversation.setSellerId(sellerId);
                    conversation = conversationRepo.save(conversation);
                    conversationId = conversation.getId();
                    
                    // After creating, redirect to the same page with conversationId to keep it clean
                    return new ModelAndView("redirect:/chat?conversationId=" + conversationId + "&filter=" + cleanFilter);
                }
            }
        }

        // ========================
        // Case 2: Load existing conversation
        // ========================
        if (conversationId != null) {

            Conversation selected =
                    conversationRepo.findById(conversationId).orElse(null);

            if (selected != null) {

                List<Message> messages =
                        messageRepo
                        .findByConversationIdOrderByCreatedAtAsc(conversationId);

                mv.addObject("messages", messages);
                mv.addObject("selectedConversation", selected);

                Product product =
                        productRepo.findById(selected.getProductId()).orElse(null);

                mv.addObject("product", product);

                Long otherUserId = selected.getBuyerId().equals(userId) ? selected.getSellerId() : selected.getBuyerId();
                User otherUser = authRepo.findById(otherUserId).orElse(null);

                mv.addObject("otherUser", otherUser);
                
                // Block status check
                boolean isBlockedByMe = userBlockRepo.existsByBlockerIdAndBlockedId(userId, otherUserId);
                boolean hasBlockedMe = userBlockRepo.existsByBlockerIdAndBlockedId(otherUserId, userId);
                
                mv.addObject("isBlockedByMe", isBlockedByMe);
                mv.addObject("hasBlockedMe", hasBlockedMe);
                mv.addObject("isBlocked", isBlockedByMe || hasBlockedMe);
            }
        }

        return mv;
    }
    // ==============================
    // SEND MESSAGE
    // ==============================
    @PostMapping("/sendMessage")
    public String sendMessage(@RequestParam Long productId,
                              @RequestParam String message,
                              HttpSession session) {

        User loggedUser =
                (User) session.getAttribute("loggedUser");

        Product product =
                productRepo.findById(productId).orElse(null);

        Long buyerId = loggedUser.getId();
        Long sellerId = product.getSeller().getId();

        // Block check
        if (userBlockRepo.isBlocked(buyerId, sellerId)) {
            return "redirect:/chat?error=blocked";
        }

        Conversation conversation =
                conversationRepo
                .findByProductIdAndBuyerIdAndSellerId(
                        productId, buyerId, sellerId)
                .orElse(null);

        if (conversation == null) {
            conversation = new Conversation();
            conversation.setProductId(productId);
            conversation.setBuyerId(buyerId);
            conversation.setSellerId(sellerId);
            conversation = conversationRepo.save(conversation);
        }

        Message msg = new Message();
        msg.setConversationId(conversation.getId());
        msg.setSenderId(buyerId);
        msg.setMessage(message);

        messageRepo.save(msg);

        return "redirect:/chat?conversationId=" + conversation.getId();
    }
}