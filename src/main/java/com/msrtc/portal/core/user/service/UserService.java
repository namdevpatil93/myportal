package com.msrtc.portal.core.user.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.applicant.domain.Post;
import com.msrtc.portal.core.user.domain.User;
import com.msrtc.portal.core.user.dto.UserSearchDTO;

public interface UserService {

	List<User> findAllUsers();

	Page<User> searchUsers(UserSearchDTO userSearchDTO, Pageable pageable);

	User findUserById(Long userId);

	User findUserByEmail(String email);

	void saveUser(User user);

	void deleteUser(Long userId);
	
	void downloadCSV(HttpServletResponse response, List<Applicant> applicants) throws IOException;
	
	void downloadApplicantPostAssocCSV(HttpServletResponse response, List<Object[]> applicantAppAssocs) throws IOException;
	
	List<Post> findAllPost();
	
}
