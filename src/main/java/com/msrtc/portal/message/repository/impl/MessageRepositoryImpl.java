package com.msrtc.portal.message.repository.impl;

import com.msrtc.portal.message.domain.Message;
import com.msrtc.portal.message.dto.MessageSearchDTO;
import com.msrtc.portal.message.repository.MessageRepository;
import com.msrtc.portal.message.repository.MessageRepositoryCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public class MessageRepositoryImpl implements MessageRepositoryCustom {

    @Autowired
    private MessageRepository messageRepository;

    @Override
    public Page<Message> searchMessages(MessageSearchDTO messageSearchDTO, Pageable pageable) {
        return messageRepository.findAll(pageable);
    }
}
