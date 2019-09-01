package com.msrtc.portal.core.user.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.Post;
import com.msrtc.portal.applicant.service.ApplicantService;
import com.msrtc.portal.core.config.ApplicationProperties;
import com.msrtc.portal.core.user.domain.User;
import com.msrtc.portal.core.user.dto.UserSearchDTO;
import com.msrtc.portal.core.user.repository.UserRepository;
import com.msrtc.portal.core.user.security.PasswordUtils;
import com.msrtc.portal.core.user.service.UserService;

@Service("userService")
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private PasswordUtils passwordUtils;
	
	@Autowired
	private ApplicationProperties applicationProperties; 
	
	@Autowired
	private ApplicantService applicantService;

	@Override
	public List<User> findAllUsers() {
		return (List<User>) userRepository.findAll();
	}

    @Override
    public Page<User> searchUsers(UserSearchDTO userSearchDTO, Pageable pageable){
        Page<User> userPage = userRepository.searchUsers(userSearchDTO, pageable);
        return userPage;
    }

    @Override
    public User findUserById(Long userId) {
        return userRepository.findOne(userId);
    }

    @Override
	public User findUserByEmail(String email) {
		return userRepository.findByEmail(email);
	}

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void saveUser(User user) {
        boolean isNew = user.getId() == null || user.getId() == 0;

        if(isNew){
            user.setPassword(passwordUtils.encryptUserPassword(user.getPassword()));
            userRepository.save(user);
        } else {
            User dbUser = userRepository.findOne(user.getId());

            dbUser.setFirstname(user.getFirstname());
            dbUser.setLastname(user.getLastname());
            dbUser.setEmail(user.getEmail());
            dbUser.setRole(user.getRole());
            if(!StringUtils.isEmpty(user.getPassword())){
                dbUser.setPassword(passwordUtils.encryptUserPassword(user.getPassword()));
            }
            userRepository.save(dbUser);
        }
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    public void deleteUser(Long userId) {
        userRepository.delete(userId);
    }
    
    @Override
    public void downloadCSV(HttpServletResponse response, List<Applicant> applicants) throws IOException {
    	response.setContentType("text/csv");
		String reportName = "Applicants_List.csv";
		response.setHeader("Content-disposition", "attachment;filename="+reportName);
 
		List<String> rows = new ArrayList<String>();
		rows.add("S. No,Applicant ID,Name,Mobile Number,Email Id,Caste");
		rows.add("\n");
 
		StringBuilder srtBldr = null;
		int serialNo = 1;
		for (Applicant applicant : applicants) {
			srtBldr = new StringBuilder();
			
			srtBldr.append(serialNo).append(",");
			srtBldr.append(applicant.getApplicationId()).append(",");
			srtBldr.append(applicant.getFirstName()).append(" ")
				.append(applicant.getMiddleName()).append(" ")
				.append(applicant.getLastName()).append(",");
			srtBldr.append(applicant.getMobileNumber()).append(",");
			srtBldr.append(applicant.getEmailAddress()).append(",");
			srtBldr.append(applicant.getCaste().getCasteTitle()).append(",");
			
			//srtBldr.append(applicant.get)
			
			rows.add(srtBldr.toString());
			rows.add("\n");
			
			serialNo ++;
		}
 
		Iterator<String> iter = rows.iterator();
		while (iter.hasNext()) {
			String outputString = (String) iter.next();
			response.getOutputStream().print(outputString);
		}
 
		response.getOutputStream().flush();
    }
    
    @Override
    public void downloadApplicantPostAssocCSV(HttpServletResponse response, List<Object[]> applicantAppAssocs) throws IOException {
    	response.setContentType("text/csv");
		String reportName = "ApplicantsPostAssoc_List.csv";
		response.setHeader("Content-disposition", "attachment;filename="+reportName);
 
		List<String> rows = new ArrayList<String>();
		rows.add("S. No,Applicant ID,Name,Mobile Number,Email Id,Post,Division,Caste,Subcaste,Status");
		rows.add("\n");
 
		StringBuilder srtBldr = null;
		int serialNo = 1;
		for (Object[] applicantPostAssoc : applicantAppAssocs) {
			srtBldr = new StringBuilder();
			
			srtBldr.append(serialNo).append(",");
			srtBldr.append(applicantPostAssoc[1]).append(",");
			
			srtBldr.append(applicantPostAssoc[2]).append(",");
			
			srtBldr.append(applicantPostAssoc[3]).append(",");
			
			srtBldr.append(applicantPostAssoc[4]).append(",");
			
			srtBldr.append(applicantPostAssoc[5]).append(",");
			
			srtBldr.append(applicantPostAssoc[6]).append(",");
			
			srtBldr.append(applicantPostAssoc[7]).append(",");
			
			srtBldr.append(applicantPostAssoc[8] == null || "".equals(applicantPostAssoc[8]) ? "N.A." : applicantPostAssoc[8]).append(",");
			
			srtBldr.append(Integer.valueOf(2).equals(applicantPostAssoc[9]) ? "Paid" : "Registered").append(",");
			
			rows.add(srtBldr.toString());
			rows.add("\n");
			
			serialNo ++;
		}
		response.setCharacterEncoding("UTF-8");
		Iterator<String> iter = rows.iterator();
		while (iter.hasNext()) {
			String outputString = (String) iter.next();
			response.getWriter().print(outputString);
		}
 
		response.getWriter().flush();
    }

	@Override
	public List<Post> findAllPost() {
		return applicantService.findAllPost();
	}
    
}
