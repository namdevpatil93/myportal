package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QPostDivisionAssoc is a Querydsl query type for PostDivisionAssoc
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QPostDivisionAssoc extends EntityPathBase<PostDivisionAssoc> {

    private static final long serialVersionUID = 534782060L;

    public static final QPostDivisionAssoc postDivisionAssoc = new QPostDivisionAssoc("postDivisionAssoc");

    public final BooleanPath active = createBoolean("active");

    public final NumberPath<Long> divisionId = createNumber("divisionId", Long.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final NumberPath<Long> postId = createNumber("postId", Long.class);

    public QPostDivisionAssoc(String variable) {
        super(PostDivisionAssoc.class, forVariable(variable));
    }

    public QPostDivisionAssoc(Path<? extends PostDivisionAssoc> path) {
        super(path.getType(), path.getMetadata());
    }

    public QPostDivisionAssoc(PathMetadata metadata) {
        super(PostDivisionAssoc.class, metadata);
    }

}

