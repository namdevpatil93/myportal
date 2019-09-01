package com.msrtc.portal.applicantQuery.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.msrtc.portal.core.user.domain.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.QueryTypeEnum;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.applicantQuery.domain.ApplicantQuery;
import com.msrtc.portal.applicantQuery.domain.ApplicantQueryReply;
import com.msrtc.portal.applicantQuery.dto.ApplicantQuerySearchDTO;
import com.msrtc.portal.applicantQuery.service.ApplicantQueryService;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.core.user.security.SecurityUtils;


@Controller
@RequestMapping(value = { "/applicantQuery"})
public class ApplicantQueryController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private ApplicantQueryService applicantQueryService;
	
	@Autowired
	private ApplicantService applicantService;
	
    @Autowired
    private MessageSource messageSource;

	@RequestMapping(params = "operation=applicantQueryList")
	public String applicantQueryList(Model model, ApplicantQuerySearchDTO applicantQuerySearchDTO, PageDetail pageDetail, Long id) {
		log.debug("Finding all applicantQuery entries");
		Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
		Page<ApplicantQuery> page = applicantQueryService.searchApplicantQueries(applicantQuerySearchDTO, pageDetail.getPageable(), applicant.getId());

		model.addAttribute("page", page);
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("applicantQuerySearchDTO", applicantQuerySearchDTO);

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));
		List<QueryTypeEnum> queryTypes = new ArrayList<QueryTypeEnum>( Arrays.asList(QueryTypeEnum.values()));
		model.addAttribute("queryTypes", queryTypes);
		Long currentUserParentRoleId = SecurityUtils.getCurrentUserParentRoleId();
		model.addAttribute("userRole", currentUserParentRoleId);
		
		int count = applicantQueryService.getCountofUnreadQueryReplies(id);
		model.addAttribute("unreadCount", count);
		if(pageDetail.isNewPage()){
			return "applicantQueryListResult";
		} else {
			return "applicantQueryList";
		}
	}

	@RequestMapping(params = "operation=applicantQueryListAdmin")
	public String applicantQueryListAdmin(Model model, ApplicantQuerySearchDTO applicantQuerySearchDTO, PageDetail pageDetail) {
		log.debug("Finding all applicantQuery entries");
		Page<ApplicantQuery> page = applicantQueryService.searchApplicantQueries(applicantQuerySearchDTO, pageDetail.getPageable(), -1L);

		
		model.addAttribute("pageDetail", pageDetail);
		model.addAttribute("applicantQuerySearchDTO", applicantQuerySearchDTO);

		int beginIndex = pageDetail.getBeginIndex(page.getNumber());
		model.addAttribute("beginIndex", beginIndex);
		model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));
		
		List<QueryTypeEnum> queryTypes = new ArrayList<QueryTypeEnum>( Arrays.asList(QueryTypeEnum.values()));
		model.addAttribute("queryTypes", queryTypes);

		for(ApplicantQuery applicantQuery : page.getContent()){
			applicantQuery.setApplicant(applicantService.findApplicantById(applicantQuery.getApplicantId()));
		}

		Long currentUserParentRoleId = SecurityUtils.getCurrentUserParentRoleId();
		model.addAttribute("userRole", currentUserParentRoleId);
		model.addAttribute("page", page);
//		model.addAttribute("applicant", applicant);
		if(pageDetail.isNewPage()){
			return "applicantQueryListResult";
		} else {
			return "applicantQueryList-admin";
		}
	}
	
	@RequestMapping(params = "operation=newApplicantQuery")
	public String newApplicantQuery(Model model) {
		log.debug("Showing form to create new applicantQuery entry");
		List<QueryTypeEnum> queryTypes = new ArrayList<QueryTypeEnum>( Arrays.asList(QueryTypeEnum.values()));
		model.addAttribute("queryTypes", queryTypes);
		return "applicantQueryForm";
	}

	@RequestMapping(params = "operation=editApplicantQuery")
	public String editApplicantQuery(Long id , Model model) {
		log.debug("Finding applicantQuery entry with the applicantQuery id: {}", id);
		model.addAttribute("applicantQuery", applicantQueryService.findApplicantQueryByQId(id));
		List<QueryTypeEnum> queryTypes = new ArrayList<QueryTypeEnum>( Arrays.asList(QueryTypeEnum.values()));
		model.addAttribute("queryTypes", queryTypes);
		return "applicantQueryForm";
	}
	
	@RequestMapping(params = "operation=adminReplyApplicantQuery")
	public String adminReplyApplicantQuery(Long id , Model model) {
		log.debug("Reply to applicantQuery entry with the applicantQuery id: {}", id);
		model.addAttribute("applicantQuery", applicantQueryService.findApplicantQueryByQId(id));
		List<QueryTypeEnum> queryTypes = new ArrayList<QueryTypeEnum>( Arrays.asList(QueryTypeEnum.values()));
		model.addAttribute("queryTypes", queryTypes);
		
		List<ApplicantQueryReply> applicantQueryReply = applicantQueryService.findApplicantQueryReplyById(id);
		model.addAttribute("applicantQueryReply", applicantQueryReply);
		Long currentUserParentRoleId = SecurityUtils.getCurrentUserParentRoleId();
		model.addAttribute("userRole", currentUserParentRoleId);
//		applicantQueryService.updateQueryReplyStatusToRead(id);
		return "applicantQueryReplyFormAdmin";
	}

	@RequestMapping(params = "operation=replyApplicantQuery")
	public String replyApplicantQuery(Long id , Model model, HttpServletRequest request) {
		log.debug("Reply to applicantQuery entry with the applicantQuery id: {}", id);
		model.addAttribute("applicantQuery", applicantQueryService.findApplicantQueryByQId(id));
		List<QueryTypeEnum> queryTypes = new ArrayList<QueryTypeEnum>( Arrays.asList(QueryTypeEnum.values()));
		model.addAttribute("queryTypes", queryTypes);
		
		List<ApplicantQueryReply> applicantQueryReply = applicantQueryService.findApplicantQueryReplyById(id);
		model.addAttribute("applicantQueryReply", applicantQueryReply);
		Long currentUserParentRoleId = SecurityUtils.getCurrentUserParentRoleId();
		model.addAttribute("userRole", currentUserParentRoleId);
		
		applicantQueryService.updateQueryReplyStatusToRead(id);
		int count;
		if(applicantQueryReply!=null && applicantQueryReply.size()>0 ){
		count = applicantService.getCountofUnreadQueryReplies(applicantQueryReply.get(0).getUserId());
		}
		else{
	    count=0;
		}
		//model.addAttribute("unreadCount", count);

		HttpSession session = request.getSession();
		session.setAttribute("userQueryCount",count);
		
		return "applicantQueryReplyForm";
	}
	
	@RequestMapping(params = "operation=saveApplicantQuery")
	public String saveApplicantQuery(ApplicantQuery applicantQuery, final RedirectAttributes redirectAttributes, @RequestParam(required=false) MultipartFile attachment) {
		log.debug("Saving ApplicantQuery with the information: {}", applicantQuery);
		Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
		
		try {
        	applicantQueryService.saveApplicantQuery(applicantQuery, applicant, attachment);
        	boolean isNew = applicantQuery.getId() == null ||  applicantQuery.getId() == 0;
			if(isNew) {
				redirectAttributes.addFlashAttribute("message", messageSource.getMessage("applicantQuery.created", null, LocaleContextHolder.getLocale()));
			} else {
				redirectAttributes.addFlashAttribute("message", messageSource.getMessage("applicantQuery.updated", null, LocaleContextHolder.getLocale()));
			}
		} 
		catch(Exception e){
			log.error(e.getMessage());
			redirectAttributes.addFlashAttribute("error", messageSource.getMessage("applicantQuery.save.failed", null, LocaleContextHolder.getLocale()));
		}

		return "redirect:/applicantQuery?operation=applicantQueryList&id="+applicantQuery.getApplicantId();
	}

	@RequestMapping(params = "operation=deleteApplicantQuery")
	public String deleteApplicantQuery(Long id, final RedirectAttributes redirectAttributes) {
		log.debug("Deleting applicantQuery entry with the applicantQuery id: {}", id);
        try {
            applicantQueryService.deleteApplicantQuery(id);
            redirectAttributes.addFlashAttribute("message", messageSource.getMessage("applicantQuery.deleted", null, LocaleContextHolder.getLocale()));
        } catch(Exception e){
            log.error(e.getMessage());
            redirectAttributes.addFlashAttribute("error", messageSource.getMessage("applicantQuery.delete.failed", null, LocaleContextHolder.getLocale()));
        }
        Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
        return "redirect:/applicantQuery?operation=applicantQueryList&id="+applicant.getId();
	}
	
	@RequestMapping(params="operation=saveApplicantQueryReply")
	public String saveApplicantQueryReply(ApplicantQueryReply applicantQueryReply,Long queryId, final RedirectAttributes redirectAttributes, @RequestParam(required=false) MultipartFile attachment)
	{
		log.debug("Saving applicantQueryreply entry with the information: {}",applicantQueryReply);
		try 
		{
			List<Long> replies = applicantQueryService.findApplicantQueryOrderByQId(queryId);
			if(replies.size() > 0)
			{
				applicantQueryReply.setParentReplyId(replies.get(0));
			}
			else
			{
				applicantQueryReply.setParentReplyId(0L);
			}
			
			applicantQueryReply.setStatus(false);
			applicantQueryReply.setUserType(SecurityUtils.getCurrentUserParentRoleId().intValue());
			applicantQueryService.saveApplicantQueryReply(applicantQueryReply, attachment);
			
			redirectAttributes.addFlashAttribute("message", messageSource.getMessage("applicantQueryReply.message.send", null, LocaleContextHolder.getLocale()));
		}
		catch(Exception e)
		{
			log.error(e.getMessage());
			redirectAttributes.addFlashAttribute("error", messageSource.getMessage("applicantQueryReply.message.send.failed", null, LocaleContextHolder.getLocale()));
		}
		if(SecurityUtils.getCurrentUserParentRoleId() == 1)
		{
			return "redirect:/notification?operation=viewQueriesAndNotifications&menu=viewQueriesAndNotifications";
		}
		else
		{	
			return "redirect:/applicantQuery?operation=applicantQueryList&id="+applicantQueryReply.getUserId();
		}
	}

}

