package com.msrtc.portal.message.web;

import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.message.domain.Message;
import com.msrtc.portal.message.dto.MessageSearchDTO;
import com.msrtc.portal.message.service.MessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = { "/messages"})
public class MessageController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private MessageService messageService;

	@RequestMapping(params = "operation=messageList")
	public String messageList(Model model, MessageSearchDTO messageSearchDTO, PageDetail pageDetail) {
		log.debug("Finding all message entries");
		Page<Message> page = messageService.searchMessages(messageSearchDTO, pageDetail.getPageable());

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("messageSearchDTO", messageSearchDTO);

		if(pageDetail.isNewPage()){
			return "messageListResult";
		} else {
			return "messageList";
		}
	}

	@RequestMapping(params = "operation=newMessage")
	public String newMessage() {
		log.debug("Showing form to create new message entry");
		return "messageForm";
	}

	@RequestMapping(params = "operation=editMessage")
	public String editMessage(Long id , Model model) {
		log.debug("Finding message entry with the message id: {}", id);
		model.addAttribute("message", messageService.findMessageById(id));
		return "messageForm";
	}

	@RequestMapping(params = "operation=saveMessage")
	public @ResponseBody Map<String, Object> saveMessage(Message message) {
		log.debug("Saving Message with the information: {}", message);

		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
        	messageService.saveMessage(message);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("message", message);
		result.put("success", success);
		return result;

	}

	@RequestMapping(params = "operation=deleteMessage")
	public @ResponseBody Map<String, Object> deleteMessage(@RequestParam("id") Long id) {
		log.debug("Deleting message entry with the message id: {}", id);
		Map<String, Object> result = new HashMap<>();
		boolean success = true;
		try {
			messageService.deleteMessage(id);
		} catch(Exception e){
			log.error(e.getMessage());
			success = false;
		}
		result.put("success", success);
		return result;
	}
}

