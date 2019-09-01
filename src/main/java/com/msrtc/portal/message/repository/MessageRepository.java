package com.msrtc.portal.message.repository;

import com.msrtc.portal.core.common.repository.BaseRepository;
import com.msrtc.portal.message.domain.Message;

public interface MessageRepository extends BaseRepository<Message, Long>, MessageRepositoryCustom{

}

