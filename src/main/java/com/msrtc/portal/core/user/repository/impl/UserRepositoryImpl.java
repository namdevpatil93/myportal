package com.msrtc.portal.core.user.repository.impl;

import com.msrtc.portal.core.user.domain.User;
import com.msrtc.portal.core.user.dto.UserSearchDTO;
import com.msrtc.portal.core.user.repository.UserRepository;
import com.msrtc.portal.core.user.repository.UserRepositoryCustom;
import com.querydsl.core.BooleanBuilder;
import com.msrtc.portal.core.user.domain.QUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

public class UserRepositoryImpl implements UserRepositoryCustom {

    @Autowired
    private UserRepository userRepository;

    @Override
    public Page<User> searchUsers(UserSearchDTO userSearchDTO, Pageable pageable) {
        QUser user = QUser.user;

        BooleanBuilder queryBuilder = new BooleanBuilder();

        int searchType = userSearchDTO.getSearchType();

        switch(searchType){
            case 1:
                // Basic Search
                String searchText = userSearchDTO.getSearchText();
                if(!StringUtils.isEmpty(searchText)){
                    queryBuilder.or(user.firstname.containsIgnoreCase(searchText));
                    queryBuilder.or(user.lastname.containsIgnoreCase(searchText));
                    queryBuilder.or(user.email.containsIgnoreCase(searchText));
                    queryBuilder.or(user.role.title.containsIgnoreCase(searchText));
                    queryBuilder.or(user.role.description.containsIgnoreCase(searchText));
                }
                break;
            case 2:
                // Advanced Search
                String firstname = userSearchDTO.getFirstname();
                String lastname = userSearchDTO.getLastname();
                String email = userSearchDTO.getEmail();
                Long roleId = userSearchDTO.getRoleId();

                if(!StringUtils.isEmpty(firstname)){
                    queryBuilder.or(user.firstname.containsIgnoreCase(firstname));
                }

                if(!StringUtils.isEmpty(lastname)){
                    queryBuilder.or(user.lastname.containsIgnoreCase(lastname));
                }

                if(!StringUtils.isEmpty(email)){
                    queryBuilder.or(user.email.containsIgnoreCase(email));
                }

                if(roleId != null && roleId != 0){
                    queryBuilder.or(user.role.id.eq(roleId));
                }
                break;
        }

        return userRepository.findAll(queryBuilder.getValue(), pageable);
   }
}
