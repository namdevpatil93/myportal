package com.msrtc.portal.core.common.repository;

import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.io.Serializable;

/*
 ** Note that the intermediate repository interface is annotated with @NoRepositoryBean.
 ** Make sure you add that annotation to all repository interfaces that Spring Data should not create instances for at runtime.
*/
@NoRepositoryBean
public interface BaseRepository<T, ID extends Serializable> extends PagingAndSortingRepository<T, ID> , QueryDslPredicateExecutor<T> {


}
