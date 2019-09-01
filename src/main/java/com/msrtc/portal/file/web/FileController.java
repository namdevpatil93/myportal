package com.msrtc.portal.file.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.http.HttpHeaders;
import com.msrtc.portal.advertisement.domain.Advertisement;
import com.msrtc.portal.advertisement.service.AdvertisementService;
import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicantQuery.domain.ApplicantQuery;
import com.msrtc.portal.applicantQuery.domain.ApplicantQueryReply;
import com.msrtc.portal.applicantQuery.service.ApplicantQueryService;
import com.msrtc.portal.challan.domain.ChallanFile;
import com.msrtc.portal.challan.service.ChallanService;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.core.user.security.SecurityUtils;
import com.msrtc.portal.document.domain.Document;
import com.msrtc.portal.document.domain.DocumentEnum;
import com.msrtc.portal.document.service.DocumentService;

@Controller
@RequestMapping(value = { FileController.FILE_CONTROLLER_URL })
public class FileController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	static final String FILE_CONTROLLER_URL = "/file";

	@Autowired
	private ApplicationProperties applicationProperties;

	@Autowired
	private ChallanService challanService;
	
	@Autowired
	private DocumentService documentService;
	
	@Autowired
	private AdvertisementService advertisementService;
	
	@Autowired
	private ApplicantQueryService applicantQueryService;

	@GetMapping(params = "operation=viewPhoto", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public FileSystemResource viewPhoto(@RequestParam String applicationId,
										@RequestParam String photo) {
		String basePath = applicationProperties.getResources().getBasePath();
		String photoPath = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + File.separator + applicationId +  File.separator + Constants.APPLICANT_PHOTO_UPLOAD_BASE_DIR + File.separator + photo;
		return new FileSystemResource(photoPath);
	}

	@GetMapping(params = "operation=viewSignature", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public FileSystemResource viewSignature(@RequestParam String applicationId,
											@RequestParam String signature) {
		String basePath = applicationProperties.getResources().getBasePath();
		String signaturePath = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + File.separator + applicationId +  File.separator + Constants.APPLICANT_SIGNATURE_UPLOAD_BASE_DIR + File.separator + signature;
		return new FileSystemResource(signaturePath);
	}
	
	@GetMapping(params = "operation=viewExperienceLetter", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public FileSystemResource viewheavyDrivingLicense(@RequestParam Long postId,
											@RequestParam String experienceScanCopy) {
		Applicant applicant = SecurityUtils.getCurrentUser().getApplicant();
		String basePath = applicationProperties.getResources().getBasePath();
		String heavyDrivingLicenseUploadLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + applicant.getApplicationId() + File.separator + postId + File.separator + Constants.EXPERIENCE_LETTER_DIR + File.separator + experienceScanCopy;
		return new FileSystemResource(heavyDrivingLicenseUploadLocation);
	}

	@GetMapping(params = "operation=downloadChallanFile", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public FileSystemResource downloadChallanFile(@RequestParam Long challanFileId, HttpServletResponse response) {
		String basePath = applicationProperties.getResources().getBasePath();
		ChallanFile challanFile = challanService.findChallanFileByChallanFileId(challanFileId);

		String challanFileName = challanFile.getFileName();
		String challanFileLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.CHALLANS_UPLOAD_BASE_DIR;

		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "inline; filename=" + challanFile.getOriginalFileName());

		return new FileSystemResource(challanFileLocation + File.separator + challanFileName);
	}
	
	@GetMapping(value = "/viewPdf", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public FileSystemResource viewPdf(@RequestParam Long documentId, @RequestParam String locale) {
		String basePath = applicationProperties.getResources().getBasePath();
		Document document = documentService.findDocumentById(documentId);
		String fileName = "en".equals(locale) ? document.getDocumentName() : document.getDocumentNameMarathi();
		String documentUploadLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.ADMIN_DIR + File.separator + Constants.DOCUMENT_DIR + File.separator + DocumentEnum.getDocumentTypeById(document.getDocumentType()) + File.separator + document.getId() + File.separator + fileName;
		return new FileSystemResource(documentUploadLocation);
	}
	
	@GetMapping(value = "/viewAdvertisement", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public FileSystemResource viewAdvertisement(@RequestParam Long advertisementId, @RequestParam String locale) {
		String basePath = applicationProperties.getResources().getBasePath();
		Advertisement advertisement = advertisementService.findAdvertisementById(advertisementId);
		String fileName = "en".equals(locale) ? advertisement.getDocumentName() : advertisement.getDocumentNameMarathi();
		String advertisementUploadLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.ADMIN_DIR + File.separator + Constants.DOCUMENT_DIR + File.separator + DocumentEnum.getDocumentTypeById(DocumentEnum.ADVERTISEMENTS.getDocumentId()) + File.separator + advertisement.getId() + File.separator + fileName;
		return new FileSystemResource(advertisementUploadLocation);
	}
	
	@GetMapping(params = "operation=viewAddedAttachment", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public FileSystemResource viewAddedAttachment(@RequestParam Long applicantQueryId) {
		String basePath = applicationProperties.getResources().getBasePath();
		ApplicantQuery applicantQuery = applicantQueryService.findApplicantQueryByQId(applicantQueryId);
		String attachmentUploadLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.QUERY_DIR + File.separator + applicantQueryId+ File.separator + applicantQuery.getAddAttachment();
		return new FileSystemResource(attachmentUploadLocation);
	}
	
	@GetMapping(params = "operation=viewReplyAttachment", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public FileSystemResource viewReplyAttachment(@RequestParam Long applicantQueryReplyId) {
		String basePath = applicationProperties.getResources().getBasePath();
		ApplicantQueryReply applicantQueryReply = applicantQueryService.findApplicantQueryReply(applicantQueryReplyId);
		String attachmentUploadLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.QUERY_DIR + File.separator + applicantQueryReply.getQueryId()+ File.separator + applicantQueryReply.getAddAttachment();
		return new FileSystemResource(attachmentUploadLocation);
	}
	
	@GetMapping(params = "operation=downloadAddedAttachment", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public byte[] downloadAddedAttachment(@RequestParam Long applicantQueryId, HttpServletResponse response) throws IOException {
		String basePath = applicationProperties.getResources().getBasePath();
		ApplicantQuery applicantQuery = applicantQueryService.findApplicantQueryByQId(applicantQueryId);
		String attachmentUploadLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.QUERY_DIR + File.separator + applicantQueryId+ File.separator + applicantQuery.getAddAttachment();
		
		//response.setContentType("image/jpeg");
		response.setHeader("Content-Disposition", "inline; filename=" + applicantQuery.getAddAttachment());

		InputStream inputStream = new FileInputStream(attachmentUploadLocation);

	    try {
			return IOUtils.toByteArray(inputStream);
		} finally {
			IOUtils.closeQuietly(inputStream);
		}
	}
	
	@GetMapping(params = "operation=downloadReplyAttachment", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public byte[] downloadReplyAttachment(@RequestParam Long applicantQueryReplyId, HttpServletResponse response) throws IOException {
		String basePath = applicationProperties.getResources().getBasePath();
		ApplicantQueryReply applicantQueryReply = applicantQueryService.findApplicantQueryReply(applicantQueryReplyId);
		String attachmentUploadLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.QUERY_DIR + File.separator + applicantQueryReply.getQueryId()+ File.separator + applicantQueryReply.getAddAttachment();
		
		//response.setContentType("image/jpeg");
		response.setHeader("Content-Disposition", "inline; filename=" + applicantQueryReply.getAddAttachment());

		InputStream inputStream = new FileInputStream(attachmentUploadLocation);

	    try {
			return IOUtils.toByteArray(inputStream);
		} finally {
			IOUtils.closeQuietly(inputStream);
		}
	}

}
