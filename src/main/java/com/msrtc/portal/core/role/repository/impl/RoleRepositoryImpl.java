package com.msrtc.portal.core.role.repository.impl;

import com.msrtc.portal.core.role.domain.Role;
import com.msrtc.portal.core.role.dto.RoleSearchDTO;
import com.msrtc.portal.core.role.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

import com.querydsl.core.BooleanBuilder;
import com.msrtc.portal.core.role.domain.QRole;
import com.msrtc.portal.core.role.repository.RoleRepositoryCustom;

public class RoleRepositoryImpl implements RoleRepositoryCustom {

	@Autowired
	private RoleRepository roleRepository;

	@Override
	public Page<Role> searchRoles(RoleSearchDTO roleSearchDTO, Pageable pageable) {
		QRole role = QRole.role;

		BooleanBuilder queryBuilder = new BooleanBuilder();

		int searchType = roleSearchDTO.getSearchType();

		switch (searchType) {
		case 1:
			// Basic Search
			String searchText = roleSearchDTO.getSearchText();
			if (!StringUtils.isEmpty(searchText)) {
				queryBuilder.or(role.role.title.containsIgnoreCase(searchText));
				queryBuilder.or(role.role.description.containsIgnoreCase(searchText));
			}
			break;
		case 2:
			// Advanced Search
			break;
		}

		return roleRepository.findAll(queryBuilder.getValue(), pageable);
	}
}
