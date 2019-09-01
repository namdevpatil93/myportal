package com.msrtc.portal.core.user.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;
import java.util.zip.DeflaterOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.msrtc.portal.applicant.domain.ApplicantForm;
import com.msrtc.portal.applicant.domain.Post;
import com.msrtc.portal.core.common.util.CommonUtils;
import com.msrtc.portal.core.user.security.SecurityUtils;
import com.msrtc.portal.qualification.domain.Qualification;

import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.io.FileSystemResource;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.ApplicantPostAssoc;
import com.msrtc.portal.applicant.dto.AdmitCardDownload;
import com.msrtc.portal.applicant.dto.ApplicantPostAssocSearchDTO;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.core.common.util.PageDetail;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.core.role.domain.Role;
import com.msrtc.portal.core.role.service.RoleService;
import com.msrtc.portal.core.user.domain.User;
import com.msrtc.portal.core.user.dto.UserSearchDTO;
import com.msrtc.portal.core.user.service.UserService;
import org.zeroturnaround.zip.ZipUtil;

@Controller
@RequestMapping(value = { "/admin"})
public class UserController {

	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private ApplicantService applicantService;

    @Autowired
	private ApplicationProperties applicationProperties;

    @RequestMapping(params = "operation=adminDashboard")
    public String adminDashboard(Model model){
    	Long totalApplicant = applicantService.totalApplicants();

    	model.addAttribute("totalApplicant", totalApplicant);
        return "adminDashboard";
    }

    //Change and use this if need to show applican list
   /* @RequestMapping(params = "operation=applicantsList")
    public String applicantsList(Model model, ApplicantSearchDTO applicantSearchDTO, PageDetail pageDetail) {
    	Page<Applicant> page = applicantService.searchApplicants(applicantSearchDTO, pageDetail.getPageable());
    	Long totalApplicant = applicantService.totalApplicants();
    	
        model.addAttribute("page", page);
        model.addAttribute("pageDetail", pageDetail);
        model.addAttribute("applicantSearchDTO", applicantSearchDTO);

        int beginIndex = pageDetail.getBeginIndex(page.getNumber());
        model.addAttribute("beginIndex", beginIndex);
        model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));
        
    	model.addAttribute("totalApplicant", totalApplicant);

        if(pageDetail.isNewPage()){
            return "applicantListResult";
        } else {
            return "applicantList";
        }
    }*/

    @RequestMapping(params = "operation=showApplicantsPostAssocList")
    public String showApplicantsPostAssocList(Model model, ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) {
    	model.addAttribute("applicantSearchDTO", applicantPostAssocSearchDTO);
    	model.addAttribute("hideApplicantsList", true);
    	model.addAttribute("castes", applicantService.findAllCastes());
    	model.addAttribute("posts", applicantService.findAllActivePost());
    	model.addAttribute("districts", applicantService.findAllDistricts());
    	model.addAttribute("searchType", applicantPostAssocSearchDTO.getSearchType());
    	model.addAttribute("menu", "applicantsList");
    	return "applicantList";
    }

    @RequestMapping(params = "operation=applicantsPostAssocList")
    public String applicantsPostAssocList(Model model, ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO, PageDetail pageDetail) {
    	//--- Set page size for Pagination --
    	pageDetail.setSize(50);
    	Long totalApplicant = applicantService.totalApplicantPostAssocs();
    	Integer pageHasRecords = applicantService.filterApplicantPostAssocsListSize(applicantPostAssocSearchDTO);
    	Page<ApplicantPostAssoc> pageData = applicantService.filterApplicantPostAssocsList(applicantPostAssocSearchDTO, pageDetail);

        model.addAttribute("pageHasRecords", pageHasRecords);
        model.addAttribute("pageData", pageData);
        model.addAttribute("pageDetail", pageDetail);
        model.addAttribute("applicantSearchDTO", applicantPostAssocSearchDTO);

        int correntPageNo = pageDetail.getPageNumber();

        int totalPages = 0;
        int pageSize = pageDetail.getSize();
        int startIndex = 1;
        int endIndex = pageSize;


        if (pageHasRecords % pageSize == 0) {
        	totalPages = (int) (pageHasRecords / pageSize);
        } else {
        	totalPages = (int) (pageHasRecords / pageSize);
        	totalPages++;
        }

        //--- Pagination Logic Starts ---
        if ( totalPages >= pageSize ) {
        	for (int i = 0; i <= (int) Math.ceil(pageSize / 2); i++) {
				int tempPage = (correntPageNo + i);
				if ( tempPage >= totalPages ) {
					endIndex = tempPage;
					startIndex = endIndex - pageSize;

					break;
				}
			}
		}

        if ( correntPageNo > endIndex ) {
        	endIndex = correntPageNo;
		}

        if ( endIndex > totalPages ) {
			endIndex = totalPages;
		}
        //--- Pagination Logic Ends ---

        model.addAttribute("totalPages", totalPages);

        model.addAttribute("beginPage", correntPageNo);
        model.addAttribute("beginIndex", startIndex);
        model.addAttribute("endIndex", endIndex);
        model.addAttribute("pageSize", pageSize);

    	model.addAttribute("totalApplicant", totalApplicant);

    	model.addAttribute("castes", applicantService.findAllCastes());
    	model.addAttribute("posts", applicantService.findAllActivePost());
    	model.addAttribute("districts", applicantService.findAllDistricts());
    	model.addAttribute("searchType", applicantPostAssocSearchDTO.getSearchType());

        if(pageDetail.isNewPage()){
            return "applicantListResult";
        } else {
            return "applicantList";
        }
    }

    @RequestMapping(params = "operation=userList")
	public String userList(Model model, UserSearchDTO userSearchDTO, PageDetail pageDetail) {
        Page<User> page = userService.searchUsers(userSearchDTO, pageDetail.getPageable());

        model.addAttribute("page", page);
        model.addAttribute("pageDetail", pageDetail);
        model.addAttribute("userSearchDTO", userSearchDTO);

        int beginIndex = pageDetail.getBeginIndex(page.getNumber());
        model.addAttribute("beginIndex", beginIndex);
        model.addAttribute("endIndex", pageDetail.getEndIndex(page.getTotalPages(), beginIndex));

        if(pageDetail.isNewPage()){
            return "userListResult";
        } else {
            return "userList";
        }
	}

    @RequestMapping(params = "operation=newUser")
	public String newUser(Model model) {
		List<Role> roles = roleService.findAllRoles();
		model.addAttribute("roleList", roles);
		return "userForm";
	}

	@RequestMapping(params = "operation=editUser")
	public String editUser(Long userId, Model model) {
		List<Role> roles = roleService.findAllRoles();
		model.addAttribute("roleList", roles);
		model.addAttribute("user", userService.findUserById(userId));
		return "userForm";
	}

	@RequestMapping(params = "operation=saveUser")
	public String saveUser(User user, final RedirectAttributes redirectAttributes) {
		boolean isNew = user.getId() == null || user.getId() == 0;
        try {
            userService.saveUser(user);
            if(isNew) {
                redirectAttributes.addFlashAttribute("message", messageSource.getMessage("user.created", null, LocaleContextHolder.getLocale()));
            } else {
                redirectAttributes.addFlashAttribute("message", messageSource.getMessage("user.updated", null, LocaleContextHolder.getLocale()));
            }
        } catch(Exception e){
            log.error( "Exception while saving user. " + e, e );
            redirectAttributes.addFlashAttribute("error", messageSource.getMessage("user.save.failed", null, LocaleContextHolder.getLocale()));
        }
		return "redirect:/user?operation=userList";
	}

	@RequestMapping(params = "operation=deleteUser")
	public String deleteUser(Long userId, final RedirectAttributes redirectAttributes) {
		try {
			userService.deleteUser(userId);
            redirectAttributes.addFlashAttribute("message", messageSource.getMessage("user.deleted", null, LocaleContextHolder.getLocale()));
		} catch(Exception e){
			log.error( "Exception while deleting user with id " + userId + ". " + e, e );
            redirectAttributes.addFlashAttribute("error", messageSource.getMessage("user.delete.failed", null, LocaleContextHolder.getLocale()));
		}

		return "redirect:/user?operation=userList";
	}

    @RequestMapping(params = "operation=saveUserProfile")
    public String saveUserProfile(User user, Model model) {
        userService.saveUser(user);
        model.addAttribute("isUserProfile", true);
        model.addAttribute("message", messageSource.getMessage("user.profile.updated", null, LocaleContextHolder.getLocale()));
        return "userForm";
    }

    @RequestMapping(params = "operation=downloadCSV")
	public void downloadCSV(HttpServletResponse response) throws IOException {
    	List<Applicant> applicants = applicantService.findAllApplicants();
    	userService.downloadCSV(response, applicants);
	}

    @RequestMapping(params = "operation=downloadApplicantPostAssocCSV")
	public void downloadApplicantPostAssocCSV(HttpServletResponse response, ApplicantPostAssocSearchDTO applicantPostAssocSearchDTO) throws IOException {
    	List<Object[]> applicantAppAssocs = applicantService.findAllApplicantPostAssoc(applicantPostAssocSearchDTO);
    	userService.downloadApplicantPostAssocCSV(response, applicantAppAssocs);
	}

    @RequestMapping(params = "operation=applicantAttachmentDownloadForm")
    public String applicantForm(Model model) {
    	model.addAttribute("posts", userService.findAllPost());
        model.addAttribute("allApplicantFormList", applicantService.findAllApplicantFormList());
        return "applicantAttachmentDownloadForm";
    }

    @GetMapping(params = "operation=downloadApplicantFormsZip", produces = "application/zip")
    @ResponseBody
    public FileSystemResource downloadApplicantFormsZip(Long applicantFormId, HttpServletResponse response){
        ApplicantForm applicantForm = applicantService.findApplicantFormByApplicantFormId(applicantFormId);
        String basePath = applicationProperties.getResources().getBasePath();
        String commonPath = basePath + File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.UNDERTAKING_BASE_DIR + File.separator
                + applicantForm.getPostId();
        String sourceFolder = commonPath + File.separator + applicantForm.getLocation();
        String outputZipFile = commonPath + File.separator + applicantForm.getName() + ".zip";
        ZipUtil.pack(new File(sourceFolder), new File(outputZipFile));

        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment; filename="+ applicantForm.getName() +".zip");

        return new FileSystemResource(outputZipFile);
    }

   @RequestMapping(params = "operation=downloadAdmitCard", produces ="application/pdf")
    @ResponseBody
    public FileSystemResource downloadAdmitCard(@RequestParam("applicantId") Long applicantId, @RequestParam Long postId,@RequestParam("applicationId") String applicationId,HttpServletResponse response)  {
         String basePath = applicationProperties.getResources().getEpassBasePath();
         String file="";
         try {
        	Object[]  applicantAssoc=applicantService.getAdmitCardUrl(applicantId,postId);
        	 String attachmentUploadLocation = basePath + File.separator + com.msrtc.portal.core.common.util.Constants.ADMITCARD_PATH+ File.separator +applicantAssoc[0]  + File.separator +applicationId+ File.separator +applicantAssoc[1];
        	if(applicantAssoc.length!=0 && applicantAssoc[0]!=null & applicantAssoc[1]!=null ){
        		 file=attachmentUploadLocation;
        		 response.setContentType("application/pdf");
                 response.setHeader("Content-Disposition", "attachment; filename="+ applicantAssoc[1]);
              	}
             } catch(Exception e){
			log.error( "Exception while downloading admit card at opertaion=downloadAdmitCard " );
           }
       //String attachmentUploadLocation = basePath + File.separator + com.sts.epass.core.common.util.Constants.ADMITCARD_PATH+ File.separator + examApplicantAssoc.getExam().getDrive().getId() + File.separator + applicantId+ File.separator + examApplicantAssoc.getAdmitCardUrl();
         return new FileSystemResource(file);
    }
     
    @RequestMapping(params = "operation=downloadApplicantAttachment")
    public String downloadApplicantAttachment(Model model, @RequestParam MultipartFile file,
                                            @RequestParam  String name, @RequestParam Long postId, HttpServletResponse response, HttpServletRequest request, PageDetail pageDetail) {
    	String basePath = applicationProperties.getResources().getBasePath();

        String fileExtension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        String fileLocation = basePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + Constants.DOWNLOAD_APPLICANT_ATTACHMENT;

        FileUtils.saveFile(file, fileName, fileLocation);
        
        List<String> applicationIds = readFile(fileName, fileLocation + File.separator + fileName, fileExtension);

        String logoPath = request.getServletContext().getRealPath(Constants.MSRTC_LOGO_PATH);
        String fontFilePath = request.getServletContext().getRealPath(Constants.FONT_FILE_PATH);
        String itextLicenseFilePath = request.getServletContext().getRealPath(Constants.ITEXT_LICENSE_FILE_PATH);

        User user = SecurityUtils.getCurrentUser().getUser();

        applicantService.generateApplicationFormsPDF(name, applicationIds, postId, logoPath, fontFilePath, itextLicenseFilePath, pageDetail, user.getId());

        return "redirect:admin?operation=applicantAttachmentDownloadForm";
    }

	private List<String> readFile(String fileName, String fileLocation, String fileExtension) {
		List<String> applicantionIds = new ArrayList<>();

        Sheet sheet = null;
        Workbook workbook = null;

        try {
            InputStream input = new FileInputStream(fileLocation);

            if (fileExtension.equals(".xls")) {
                workbook = new HSSFWorkbook(input);
            }else if (fileExtension.equals(".xlsx")) {
                workbook = new XSSFWorkbook(input);
            }
            sheet = workbook.getSheetAt(0);

            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {

                Row row = sheet.getRow(i);
//                int noOfCols = row.getLastCellNum();

                /*for (int colNo = 0; colNo < noOfCols; colNo++) {
                    Cell cell = row.getCell(colNo);

                    cell.getStringCellValue();
                    }
                }*/
            	
            	Cell cell = row.getCell(0);

            	try {

                    String applicantionId = cell.getStringCellValue();
                    applicantionIds.add(applicantionId);
                } catch(Exception e){
            	    e.printStackTrace();
                    String applicantionId = String.valueOf(cell.getNumericCellValue());
                    System.out.println(applicantionId + " applicantionId ");
                    applicantionIds.add(applicantionId);
                }
            }

        } catch(Exception e){
            e.printStackTrace();
        }


        return applicantionIds;
	}

    @RequestMapping(params = "operation=administration")
    public String showAdministrationPage(Model model) {
        return "administration";
    }

    @RequestMapping(params = "operation=showResetApplicantPassword")
    public String showResetApplicantPassword(Model model) {
        return "resetApplicantPassword";
    }

    @RequestMapping(params = "operation=resetApplicantPassword")
    public @ResponseBody
    Map<String, Object> resetApplicantPassword(String applicationId) {
        log.debug("Resetting password for the application id: {}", applicationId);

        Map<String, Object> result = new HashMap<>();
        int status = -1;

        try {
            Applicant applicant = applicantService.findApplicantByApplicationId(applicationId);
            if(applicant != null){
                String newPassword = CommonUtils.generateRandomPassword();
                applicant.setNewPassword(newPassword);
                applicantService.updatePassword(applicant);
                status = 1;
                result.put("newPassword", newPassword);
            } else {
                status = 2;
            }
        } catch(Exception e){
            log.error(e.getMessage());
        }

        result.put("status", status);
        return result;

    }

    @RequestMapping(params = "operation=showPostSettings")
    public String showPostSettings(Model model) {
        model.addAttribute("postList", applicantService.findAllPost());
        return "postSettings";
    }

    @RequestMapping(params = "operation=savePostSettings")
    public @ResponseBody Map<String, Object> savePostSettings(Long postId,
                                                              boolean active,
                                                              boolean showAdmitCard,
                                                              boolean showUserResponse) {
        log.debug("Updating post settings for the post id: {}", postId);

        Map<String, Object> result = new HashMap<>();
        int status = -1;

        try {
            Post post = new Post();

            post.setPostId(postId);
            post.setActive(active);
            post.setShowAdmitCard(showAdmitCard);
            post.setShowUserResponse(showUserResponse);

            applicantService.savePost(post);

            status = 1;
        } catch(Exception e){
            log.error(e.getMessage());
        }

        result.put("status", status);
        return result;
    }
}
