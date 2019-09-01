package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QApplicantOtherInformationHistory is a Querydsl query type for ApplicantOtherInformationHistory
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QApplicantOtherInformationHistory extends EntityPathBase<ApplicantOtherInformationHistory> {

    private static final long serialVersionUID = 272405842L;

    public static final QApplicantOtherInformationHistory applicantOtherInformationHistory = new QApplicantOtherInformationHistory("applicantOtherInformationHistory");

    public final NumberPath<Long> applicant = createNumber("applicant", Long.class);

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

    public QApplicantOtherInformationHistory(String variable) {
        super(ApplicantOtherInformationHistory.class, forVariable(variable));
    }

    public QApplicantOtherInformationHistory(Path<? extends ApplicantOtherInformationHistory> path) {
        super(path.getType(), path.getMetadata());
    }

    public QApplicantOtherInformationHistory(PathMetadata metadata) {
        super(ApplicantOtherInformationHistory.class, metadata);
    }

}

