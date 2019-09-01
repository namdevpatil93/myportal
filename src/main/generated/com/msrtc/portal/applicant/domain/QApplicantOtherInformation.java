package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QApplicantOtherInformation is a Querydsl query type for ApplicantOtherInformation
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QApplicantOtherInformation extends EntityPathBase<ApplicantOtherInformation> {

    private static final long serialVersionUID = -174521118L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QApplicantOtherInformation applicantOtherInformation = new QApplicantOtherInformation("applicantOtherInformation");

    public final QApplicant applicant;

    public final DateTimePath<java.time.LocalDateTime> createdDate = createDateTime("createdDate", java.time.LocalDateTime.class);

    public final BooleanPath deafAndMute = createBoolean("deafAndMute");

    public final BooleanPath earthQuakeEffected = createBoolean("earthQuakeEffected");

    public final BooleanPath exServiceMan = createBoolean("exServiceMan");

    public final StringPath exServicemanTotalExperienceInMonths = createString("exServicemanTotalExperienceInMonths");

    public final StringPath exServicemanTotalExperienceInYears = createString("exServicemanTotalExperienceInYears");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final DateTimePath<java.time.LocalDateTime> lastModifiedDate = createDateTime("lastModifiedDate", java.time.LocalDateTime.class);

    public final BooleanPath locomotorOrCerebralPalsy = createBoolean("locomotorOrCerebralPalsy");

    public final BooleanPath orphanedPerson = createBoolean("orphanedPerson");

    public final BooleanPath partTimeEmployee = createBoolean("partTimeEmployee");

    public final StringPath partTimeEmployeeTotalExperienceInMonths = createString("partTimeEmployeeTotalExperienceInMonths");

    public final StringPath partTimeEmployeeTotalExperienceInYears = createString("partTimeEmployeeTotalExperienceInYears");

    public final NumberPath<Long> preferredCity1 = createNumber("preferredCity1", Long.class);

    public final NumberPath<Long> preferredCity2 = createNumber("preferredCity2", Long.class);

    public final NumberPath<Long> preferredCity3 = createNumber("preferredCity3", Long.class);

    public final BooleanPath projectEffected = createBoolean("projectEffected");

    public final DatePath<java.time.LocalDate> retirementDate = createDate("retirementDate", java.time.LocalDate.class);

    public final StringPath sportsLevel = createString("sportsLevel");

    public final BooleanPath sportsPerson = createBoolean("sportsPerson");

    public final NumberPath<Integer> status = createNumber("status", Integer.class);

    public final BooleanPath stEmployee = createBoolean("stEmployee");

    public QApplicantOtherInformation(String variable) {
        this(ApplicantOtherInformation.class, forVariable(variable), INITS);
    }

    public QApplicantOtherInformation(Path<? extends ApplicantOtherInformation> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QApplicantOtherInformation(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QApplicantOtherInformation(PathMetadata metadata, PathInits inits) {
        this(ApplicantOtherInformation.class, metadata, inits);
    }

    public QApplicantOtherInformation(Class<? extends ApplicantOtherInformation> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.applicant = inits.isInitialized("applicant") ? new QApplicant(forProperty("applicant"), inits.get("applicant")) : null;
    }

}

