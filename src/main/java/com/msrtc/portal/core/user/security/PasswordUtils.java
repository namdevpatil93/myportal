package com.msrtc.portal.core.user.security;

import org.jasypt.digest.PooledStringDigester;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("passwordUtil")
public class PasswordUtils {

	@Autowired
	private PooledStringDigester _stringDigester;

	public String encryptUserPassword(String originalPassword) {
		String encryptedPassword = _stringDigester.digest(originalPassword);
		return encryptedPassword;
	}

	public boolean isPasswordsMatch(String newPassword, String passwordFromDb) {
		return _stringDigester.matches(newPassword, passwordFromDb);
	}
}
