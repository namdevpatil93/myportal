package com.msrtc.portal.message.service.impl;

import com.msrtc.portal.message.domain.Message;
import com.msrtc.portal.message.repository.MessageRepository;
import com.msrtc.portal.message.service.MessageService;
import com.msrtc.portal.message.dto.MessageSearchDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service(value = "messageService")
@Transactional(readOnly = true)
public class MessageServiceImpl implements MessageService {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private MessageRepository messageRepository;

	@Override
	public List<Message> findAllActiveMessages() {
		log.debug("Finding all active messages.");
		List<Message> messageList = (List<Message>) messageRepository.findAll();
		messageList = messageList.stream().filter(Message::isActive).collect(Collectors.toList());
		return messageList;
	}

	@Override
	public List<Message> findAllMessages() {
		log.debug("Finding all message entries");
		return (List<Message>) messageRepository.findAll();
	}

	@Override
	public Page<Message> searchMessages(MessageSearchDTO messageSearchDTO, Pageable pageable){
		return messageRepository.searchMessages(messageSearchDTO, pageable);
	}

	@Override
	public Message findMessageById(Long id) {
		log.debug("Finding message entry with the message id: {}", id);
		return messageRepository.findOne(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void saveMessage(Message message) {
		log.debug("Saving Message with the information: {}", message);

		boolean isNew = message.getId() == null ||  message.getId() == 0;

		if(isNew){
			messageRepository.save(message);
		} else {
			Message dbMessage = messageRepository.findOne(message.getId());

			dbMessage.setMessageText(message.getMessageText());
			dbMessage.setMessageInMarathi(message.getMessageInMarathi());
			dbMessage.setActive(message.isActive());

			messageRepository.save(dbMessage);
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void deleteMessage(Long id) {
		log.debug("Deleting message entry with the message id: {}", id);
		messageRepository.delete(id);
	}

}

