package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QChangePasswordRequest is a Querydsl query type for ChangePasswordRequest
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QChangePasswordRequest extends EntityPathBase<ChangePasswordRequest> {

    private static final long serialVersionUID = 1528913256L;

    public static final QChangePasswordRequest changePasswordRequest = new QChangePasswordRequest("changePasswordRequest");

    public final DatePath<java.time.LocalDate> createdDate = createDate("createdDate", java.time.LocalDate.class);

    public final StringPath emailAddress = createString("emailAddress");

    public final BooleanPath expired = createBoolean("expired");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath token = createString("token");

    public final NumberPath<Integer> userType = createNumber("userType", Integer.class);

    public QChangePasswordRequest(String variable) {
        super(ChangePasswordRequest.class, forVariable(variable));
    }

    public QChangePasswordRequest(Path<? extends ChangePasswordRequest> path) {
        super(path.getType(), path.getMetadata());
    }

    public QChangePasswordRequest(PathMetadata metadata) {
        super(ChangePasswordRequest.class, metadata);
    }

}

