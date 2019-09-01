package com.msrtc.portal.applicantQuery.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QApplicantQueryReply is a Querydsl query type for ApplicantQueryReply
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QApplicantQueryReply extends EntityPathBase<ApplicantQueryReply> {

    private static final long serialVersionUID = -1408740864L;

    public static final QApplicantQueryReply applicantQueryReply = new QApplicantQueryReply("applicantQueryReply");

    public final StringPath addAttachment = createString("addAttachment");

    public final DateTimePath<java.util.Date> createdDate = createDateTime("createdDate", java.util.Date.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final NumberPath<Long> parentReplyId = createNumber("parentReplyId", Long.class);

    public final NumberPath<Long> queryId = createNumber("queryId", Long.class);

    public final StringPath reply = createString("reply");

    public final BooleanPath status = createBoolean("status");

    public final NumberPath<Long> userId = createNumber("userId", Long.class);

    public final NumberPath<Integer> userType = createNumber("userType", Integer.class);

    public QApplicantQueryReply(String variable) {
        super(ApplicantQueryReply.class, forVariable(variable));
    }

    public QApplicantQueryReply(Path<? extends ApplicantQueryReply> path) {
        super(path.getType(), path.getMetadata());
    }

    public QApplicantQueryReply(PathMetadata metadata) {
        super(ApplicantQueryReply.class, metadata);
    }

}

