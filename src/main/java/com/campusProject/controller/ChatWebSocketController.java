package com.campusProject.controller;

import com.campusProject.entity.Message;
import com.campusProject.repo.ConversationRepo;
import com.campusProject.repo.MessageRepo;
import com.campusProject.repo.UserBlockRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.time.LocalDateTime;

@Controller
public class ChatWebSocketController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Autowired
    private MessageRepo messageRepo;

    @Autowired
    private UserBlockRepo userBlockRepo;

    @Autowired
    private ConversationRepo conversationRepo;

    @MessageMapping("/chat.sendMessage/{conversationId}")
    public void sendMessage(@DestinationVariable Long conversationId, @Payload Message chatMessage) {
        
        // Find conversation to identify the other user
        var conversationOpt = conversationRepo.findById(conversationId);
        if (conversationOpt.isEmpty()) return;

        var conversation = conversationOpt.get();
        Long senderId = chatMessage.getSenderId();
        Long otherUserId = senderId.equals(conversation.getBuyerId()) ? conversation.getSellerId() : conversation.getBuyerId();

        // Check if either user has blocked the other
        if (userBlockRepo.isBlocked(senderId, otherUserId)) {
            // Silently drop the message if blocked
            return;
        }

        // Ensure conversation ID is set from the path
        chatMessage.setConversationId(conversationId);
        
        // Save message to database
        chatMessage = messageRepo.save(chatMessage);
        
        // Broadcast to the conversation topic
        messagingTemplate.convertAndSend("/topic/messages/" + conversationId, chatMessage);
    }
}
