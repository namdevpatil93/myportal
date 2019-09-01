package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QApplicant is a Querydsl query type for Applicant
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QApplicant extends EntityPathBase<Applicant> {

    private static final long serialVersionUID = -1659864890L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QApplicant applicant = new QApplicant("applicant");

    public final StringPath address = createString("address");

    public final NumberPath<Integer> allocatedCategory = createNumber("allocatedCategory", Integer.class);

    public final StringPath applicationId = createString("applicationId");

    public final DatePath<java.time.LocalDate> birthDate = createDate("birthDate", java.time.LocalDate.class);

    public final QCaste caste;

    public final StringPath certificateNumber = createString("certificateNumber");

    public final DatePath<java.time.LocalDate> certificateValidityEndingDate = createDate("certificateValidityEndingDate", java.time.LocalDate.class);

    public final BooleanPath childOfFarmerWhoCommittedSuicide = createBoolean("childOfFarmerWhoCommittedSuicide");

    public final DateTimePath<java.time.LocalDateTime> createdDate = createDateTime("createdDate", java.time.LocalDateTime.class);

    public final NumberPath<Long> districtId = createNumber("districtId", Long.class);

    public final BooleanPath droughtAffected = createBoolean("droughtAffected");

    public final StringPath emailAddress = createString("emailAddress");

    public final StringPath ewsCertificateNumber = createString("ewsCertificateNumber");

    public final BooleanPath firstLogin = createBoolean("firstLogin");

    public final StringPath firstName = createString("firstName");

    public final StringPath firstNameMarathi = createString("firstNameMarathi");

    public final NumberPath<Integer> gender = createNumber("gender", Integer.class);

    public final NumberPath<Long> highestQualification = createNumber("highestQualification", Long.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final BooleanPath isBelongToEws = createBoolean("isBelongToEws");

    public final DateTimePath<java.time.LocalDateTime> lastModifiedDate = createDateTime("lastModifiedDate", java.time.LocalDateTime.class);

    public final StringPath lastName = createString("lastName");

    public final StringPath lastNameMarathi = createString("lastNameMarathi");

    public final BooleanPath maharashtraDomiciled = createBoolean("maharashtraDomiciled");

    public final NumberPath<Integer> maritalStatus = createNumber("maritalStatus", Integer.class);

    public final StringPath middleName = createString("middleName");

    public final StringPath middleNameMarathi = createString("middleNameMarathi");

    public final BooleanPath mobileNoVerified = createBoolean("mobileNoVerified");

    public final StringPath mobileNumber = createString("mobileNumber");

    public final BooleanPath nonCreamyLayer = createBoolean("nonCreamyLayer");

    public final StringPath password = createString("password");

    public final StringPath pinCode = createString("pinCode");

    public final BooleanPath readWriteSpeakMarathi = createBoolean("readWriteSpeakMarathi");

    public final com.msrtc.portal.core.role.domain.QRole role;

    public final NumberPath<Integer> status = createNumber("status", Integer.class);

    public final StringPath subcategory = createString("subcategory");

    public QApplicant(String variable) {
        this(Applicant.class, forVariable(variable), INITS);
    }

    public QApplicant(Path<? extends Applicant> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QApplicant(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QApplicant(PathMetadata metadata, PathInits inits) {
        this(Applicant.class, metadata, inits);
    }

    public QApplicant(Class<? extends Applicant> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.caste = inits.isInitialized("caste") ? new QCaste(forProperty("caste")) : null;
        this.role = inits.isInitialized("role") ? new com.msrtc.portal.core.role.domain.QRole(forProperty("role")) : null;
    }

}

