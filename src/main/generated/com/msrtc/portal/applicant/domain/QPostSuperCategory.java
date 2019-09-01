package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QPostSuperCategory is a Querydsl query type for PostSuperCategory
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QPostSuperCategory extends EntityPathBase<PostSuperCategory> {

    private static final long serialVersionUID = 1330239133L;

    public static final QPostSuperCategory postSuperCategory = new QPostSuperCategory("postSuperCategory");

    public final StringPath categoryTitle = createString("categoryTitle");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath messageKey = createString("messageKey");

    public final ListPath<PostCategory, QPostCategory> posCategorytList = this.<PostCategory, QPostCategory>createList("posCategorytList", PostCategory.class, QPostCategory.class, PathInits.DIRECT2);

    public final NumberPath<Integer> superCategoryOrder = createNumber("superCategoryOrder", Integer.class);

    public QPostSuperCategory(String variable) {
        super(PostSuperCategory.class, forVariable(variable));
    }

    public QPostSuperCategory(Path<? extends PostSuperCategory> path) {
        super(path.getType(), path.getMetadata());
    }

    public QPostSuperCategory(PathMetadata metadata) {
        super(PostSuperCategory.class, metadata);
    }

}

