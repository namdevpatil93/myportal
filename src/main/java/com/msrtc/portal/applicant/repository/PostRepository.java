package com.msrtc.portal.applicant.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.msrtc.portal.applicant.domain.Post;
import com.msrtc.portal.core.common.repository.BaseRepository;

public interface PostRepository extends BaseRepository<Post, Long>{
	
	@Query("select p.postCategory.postSuperCategory.id from Post p where p.postId = :postId")
	int findPostSuperCategoryIdByPostId(@Param("postId") Long postId);
	
	@Query("from Post p where p.active=true")
	List<Post> findAllActivePost();

	@Query(value="SELECT DISTINCT post_type  FROM posts WHERE post_id IN  (:postId)", nativeQuery = true)
	List<Long> findUniquePostByPostType(@Param("postId") ArrayList<Long> postId);
	
}
