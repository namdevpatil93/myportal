package com.msrtc.portal.message.repository;

import com.msrtc.portal.message.domain.Message;
import com.msrtc.portal.message.dto.MessageSearchDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface MessageRepositoryCustom {

    Page<Message> searchMessages(MessageSearchDTO messageSearchDTO, Pageable pageable);
}

