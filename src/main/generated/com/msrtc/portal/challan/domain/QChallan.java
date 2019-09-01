package com.msrtc.portal.challan.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QChallan is a Querydsl query type for Challan
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QChallan extends EntityPathBase<Challan> {

    private static final long serialVersionUID = -1364982938L;

    public static final QChallan challan = new QChallan("challan");

    public final StringPath accountNo = createString("accountNo");

    public final StringPath amount = createString("amount");

    public final StringPath applicantName = createString("applicantName");

    public final StringPath applicationNo = createString("applicationNo");

    public final StringPath category = createString("category");

    public final NumberPath<Long> createdBy = createNumber("createdBy", Long.class);

    public final DateTimePath<java.time.LocalDateTime> createdDate = createDateTime("createdDate", java.time.LocalDateTime.class);

    public final StringPath dob = createString("dob");

    public final StringPath feeType = createString("feeType");

    public final StringPath fromAccountSys = createString("fromAccountSys");

    public final StringPath fromAcctNo = createString("fromAcctNo");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath jrnlNo = createString("jrnlNo");

    public final StringPath lastDateForAcceptance = createString("lastDateForAcceptance");

    public final StringPath postApplied = createString("postApplied");

    public final StringPath tranBranch = createString("tranBranch");

    public final StringPath tranDate = createString("tranDate");

    public final StringPath tranMode = createString("tranMode");

    public final StringPath tranTime = createString("tranTime");

    public QChallan(String variable) {
        super(Challan.class, forVariable(variable));
    }

    public QChallan(Path<? extends Challan> path) {
        super(path.getType(), path.getMetadata());
    }

    public QChallan(PathMetadata metadata) {
        super(Challan.class, metadata);
    }

}

