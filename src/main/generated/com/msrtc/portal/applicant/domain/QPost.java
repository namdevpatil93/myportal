package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QPost is a Querydsl query type for Post
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QPost extends EntityPathBase<Post> {

    private static final long serialVersionUID = 1258894428L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QPost post = new QPost("post");

    public final BooleanPath active = createBoolean("active");

    public final StringPath messageKey = createString("messageKey");

    public final QPostCategory postCategory;

    public final StringPath postCode = createString("postCode");

    public final NumberPath<Long> postId = createNumber("postId", Long.class);

    public final StringPath postLastDateOfApplication = createString("postLastDateOfApplication");

    public final NumberPath<Integer> postOrder = createNumber("postOrder", Integer.class);

    public final StringPath postTitle = createString("postTitle");

    public final BooleanPath showAdmitCard = createBoolean("showAdmitCard");

    public final BooleanPath showUserResponse = createBoolean("showUserResponse");

    public QPost(String variable) {
        this(Post.class, forVariable(variable), INITS);
    }

    public QPost(Path<? extends Post> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QPost(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QPost(PathMetadata metadata, PathInits inits) {
        this(Post.class, metadata, inits);
    }

    public QPost(Class<? extends Post> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.postCategory = inits.isInitialized("postCategory") ? new QPostCategory(forProperty("postCategory"), inits.get("postCategory")) : null;
    }

}

