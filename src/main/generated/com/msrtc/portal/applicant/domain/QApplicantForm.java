package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QApplicantForm is a Querydsl query type for ApplicantForm
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QApplicantForm extends EntityPathBase<ApplicantForm> {

    private static final long serialVersionUID = 991700650L;

    public static final QApplicantForm applicantForm = new QApplicantForm("applicantForm");

    public final NumberPath<Long> createdBy = createNumber("createdBy", Long.class);

    public final DateTimePath<java.time.LocalDateTime> createdDate = createDateTime("createdDate", java.time.LocalDateTime.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath location = createString("location");

    public final StringPath name = createString("name");

    public final NumberPath<Long> postId = createNumber("postId", Long.class);

    public QApplicantForm(String variable) {
        super(ApplicantForm.class, forVariable(variable));
    }

    public QApplicantForm(Path<? extends ApplicantForm> path) {
        super(path.getType(), path.getMetadata());
    }

    public QApplicantForm(PathMetadata metadata) {
        super(ApplicantForm.class, metadata);
    }

}

