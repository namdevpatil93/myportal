package com.msrtc.portal.challan.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QApplicantPostPaymentMismatch is a Querydsl query type for ApplicantPostPaymentMismatch
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QApplicantPostPaymentMismatch extends EntityPathBase<ApplicantPostPaymentMismatch> {

    private static final long serialVersionUID = 957059029L;

    public static final QApplicantPostPaymentMismatch applicantPostPaymentMismatch = new QApplicantPostPaymentMismatch("applicantPostPaymentMismatch");

    public final NumberPath<Integer> actualPaymentSuccessfulForPostCount = createNumber("actualPaymentSuccessfulForPostCount", Integer.class);

    public final NumberPath<java.math.BigDecimal> amount = createNumber("amount", java.math.BigDecimal.class);

    public final NumberPath<Long> applicantId = createNumber("applicantId", Long.class);

    public final StringPath applicationId = createString("applicationId");

    public final StringPath casteTitle = createString("casteTitle");

    public final NumberPath<Integer> gender = createNumber("gender", Integer.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final BooleanPath nonCreamyLayer = createBoolean("nonCreamyLayer");

    public final StringPath orderNo = createString("orderNo");

    public final NumberPath<Integer> paymentMadeForPostCount = createNumber("paymentMadeForPostCount", Integer.class);

    public final NumberPath<Integer> postFees = createNumber("postFees", Integer.class);

    public final DateTimePath<java.util.Date> transactionDate = createDateTime("transactionDate", java.util.Date.class);

    public QApplicantPostPaymentMismatch(String variable) {
        super(ApplicantPostPaymentMismatch.class, forVariable(variable));
    }

    public QApplicantPostPaymentMismatch(Path<? extends ApplicantPostPaymentMismatch> path) {
        super(path.getType(), path.getMetadata());
    }

    public QApplicantPostPaymentMismatch(PathMetadata metadata) {
        super(ApplicantPostPaymentMismatch.class, metadata);
    }

}

