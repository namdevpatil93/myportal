package com.msrtc.portal.applicantQuery.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QApplicantQuery is a Querydsl query type for ApplicantQuery
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QApplicantQuery extends EntityPathBase<ApplicantQuery> {

    private static final long serialVersionUID = 1575724810L;

    public static final QApplicantQuery applicantQuery = new QApplicantQuery("applicantQuery");

    public final StringPath addAttachment = createString("addAttachment");

    public final NumberPath<Long> applicantId = createNumber("applicantId", Long.class);

    public final NumberPath<Long> createdBy = createNumber("createdBy", Long.class);

    public final DateTimePath<java.util.Date> createdDate = createDateTime("createdDate", java.util.Date.class);

    public final StringPath description = createString("description");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final NumberPath<Long> lastModifiedBy = createNumber("lastModifiedBy", Long.class);

    public final DateTimePath<java.util.Date> lastModifiedDate = createDateTime("lastModifiedDate", java.util.Date.class);

    public final StringPath title = createString("title");

    public final NumberPath<Integer> type = createNumber("type", Integer.class);

    public final StringPath typeOther = createString("typeOther");

    public QApplicantQuery(String variable) {
        super(ApplicantQuery.class, forVariable(variable));
    }

    public QApplicantQuery(Path<? extends ApplicantQuery> path) {
        super(path.getType(), path.getMetadata());
    }

    public QApplicantQuery(PathMetadata metadata) {
        super(ApplicantQuery.class, metadata);
    }

}

