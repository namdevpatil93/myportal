package com.msrtc.portal.core.user.security;

import com.msrtc.portal.applicant.domain.Applicant;
import com.msrtc.portal.core.role.domain.Role;
import org.springframework.security.core.GrantedAuthority;

import com.msrtc.portal.core.user.domain.User;

import java.util.Collection;

public class SecurityUser extends org.springframework.security.core.userdetails.User {

    private static final long serialVersionUID = 6230244711955127017L;

    public SecurityUser(String username, String password, Role role, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, true, true, true, true, authorities);
        this.role = role;
    }

    private User user;

    private Applicant applicant;

    private Role role;

    private Long roleId;

    private Long parentRoleId;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Applicant getApplicant() {
        return applicant;
    }

    public void setApplicant(Applicant applicant) {
        this.applicant = applicant;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getParentRoleId() {
        return parentRoleId;
    }

    public void setParentRoleId(Long parentRoleId) {
        this.parentRoleId = parentRoleId;
    }
}
