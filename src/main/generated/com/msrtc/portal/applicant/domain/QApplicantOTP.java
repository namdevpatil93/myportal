package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QApplicantOTP is a Querydsl query type for ApplicantOTP
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QApplicantOTP extends EntityPathBase<ApplicantOTP> {

    private static final long serialVersionUID = -1076380539L;

    public static final QApplicantOTP applicantOTP = new QApplicantOTP("applicantOTP");

    public final NumberPath<Long> applicantId = createNumber("applicantId", Long.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath otp = createString("otp");

    public QApplicantOTP(String variable) {
        super(ApplicantOTP.class, forVariable(variable));
    }

    public QApplicantOTP(Path<? extends ApplicantOTP> path) {
        super(path.getType(), path.getMetadata());
    }

    public QApplicantOTP(PathMetadata metadata) {
        super(ApplicantOTP.class, metadata);
    }

}

