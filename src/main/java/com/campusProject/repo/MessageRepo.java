package com.campusProject.repo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.campusProject.entity.Message;

public interface MessageRepo extends JpaRepository<Message, Long> {

    List<Message> findByConversationIdOrderByCreatedAtAsc(Long conversationId);
}