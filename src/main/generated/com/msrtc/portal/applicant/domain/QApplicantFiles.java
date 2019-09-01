package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QApplicantFiles is a Querydsl query type for ApplicantFiles
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QApplicantFiles extends EntityPathBase<ApplicantFiles> {

    private static final long serialVersionUID = 677764433L;

    public static final QApplicantFiles applicantFiles = new QApplicantFiles("applicantFiles");

    public final NumberPath<Long> applicantId = createNumber("applicantId", Long.class);

    public final DateTimePath<java.time.LocalDateTime> createdDate = createDateTime("createdDate", java.time.LocalDateTime.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final DateTimePath<java.time.LocalDateTime> lastModifiedDate = createDateTime("lastModifiedDate", java.time.LocalDateTime.class);

    public final StringPath photoFileName = createString("photoFileName");

    public final StringPath signatureFileName = createString("signatureFileName");

    public final NumberPath<Integer> status = createNumber("status", Integer.class);

    public QApplicantFiles(String variable) {
        super(ApplicantFiles.class, forVariable(variable));
    }

    public QApplicantFiles(Path<? extends ApplicantFiles> path) {
        super(path.getType(), path.getMetadata());
    }

    public QApplicantFiles(PathMetadata metadata) {
        super(ApplicantFiles.class, metadata);
    }

}

