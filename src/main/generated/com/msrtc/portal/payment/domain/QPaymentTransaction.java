package com.msrtc.portal.payment.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QPaymentTransaction is a Querydsl query type for PaymentTransaction
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QPaymentTransaction extends EntityPathBase<PaymentTransaction> {

    private static final long serialVersionUID = 35754296L;

    public static final QPaymentTransaction paymentTransaction = new QPaymentTransaction("paymentTransaction");

    public final NumberPath<java.math.BigDecimal> amount = createNumber("amount", java.math.BigDecimal.class);

    public final NumberPath<Long> applicantId = createNumber("applicantId", Long.class);

    public final StringPath authStatus = createString("authStatus");

    public final DateTimePath<java.time.LocalDateTime> createdDate = createDateTime("createdDate", java.time.LocalDateTime.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final DateTimePath<java.time.LocalDateTime> lastModifiedDate = createDateTime("lastModifiedDate", java.time.LocalDateTime.class);

    public final StringPath orderNo = createString("orderNo");

    public final NumberPath<Integer> paymentMode = createNumber("paymentMode", Integer.class);

    public final StringPath responseMessage = createString("responseMessage");

    public final NumberPath<Integer> status = createNumber("status", Integer.class);

    public final StringPath txnReferenceNo = createString("txnReferenceNo");

    public QPaymentTransaction(String variable) {
        super(PaymentTransaction.class, forVariable(variable));
    }

    public QPaymentTransaction(Path<? extends PaymentTransaction> path) {
        super(path.getType(), path.getMetadata());
    }

    public QPaymentTransaction(PathMetadata metadata) {
        super(PaymentTransaction.class, metadata);
    }

}

