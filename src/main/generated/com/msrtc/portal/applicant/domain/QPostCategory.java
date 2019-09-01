package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QPostCategory is a Querydsl query type for PostCategory
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QPostCategory extends EntityPathBase<PostCategory> {

    private static final long serialVersionUID = 1745500538L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QPostCategory postCategory = new QPostCategory("postCategory");

    public final StringPath categoryTitle = createString("categoryTitle");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath messageKey = createString("messageKey");

    public final ListPath<Post, QPost> postList = this.<Post, QPost>createList("postList", Post.class, QPost.class, PathInits.DIRECT2);

    public final QPostSuperCategory postSuperCategory;

    public QPostCategory(String variable) {
        this(PostCategory.class, forVariable(variable), INITS);
    }

    public QPostCategory(Path<? extends PostCategory> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QPostCategory(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QPostCategory(PathMetadata metadata, PathInits inits) {
        this(PostCategory.class, metadata, inits);
    }

    public QPostCategory(Class<? extends PostCategory> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.postSuperCategory = inits.isInitialized("postSuperCategory") ? new QPostSuperCategory(forProperty("postSuperCategory")) : null;
    }

}

