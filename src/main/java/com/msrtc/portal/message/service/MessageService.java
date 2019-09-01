package com.msrtc.portal.message.service;

import com.msrtc.portal.message.domain.Message;
import com.msrtc.portal.message.dto.MessageSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface MessageService {
    List<Message> findAllActiveMessages();

    List<Message> findAllMessages();

    Page<Message> searchMessages(MessageSearchDTO messageSearchDTO, Pageable pageable);

    Message findMessageById(Long id);

    void saveMessage(Message message);

    void deleteMessage(Long id);

}
