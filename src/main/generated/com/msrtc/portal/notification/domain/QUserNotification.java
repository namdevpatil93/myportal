package com.msrtc.portal.notification.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QUserNotification is a Querydsl query type for UserNotification
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QUserNotification extends EntityPathBase<UserNotification> {

    private static final long serialVersionUID = -1678404865L;

    public static final QUserNotification userNotification = new QUserNotification("userNotification");

    public final NumberPath<Long> applicantId = createNumber("applicantId", Long.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final NumberPath<Long> notificationId = createNumber("notificationId", Long.class);

    public final BooleanPath notificationRead = createBoolean("notificationRead");

    public final DateTimePath<java.time.LocalDateTime> sentOn = createDateTime("sentOn", java.time.LocalDateTime.class);

    public QUserNotification(String variable) {
        super(UserNotification.class, forVariable(variable));
    }

    public QUserNotification(Path<? extends UserNotification> path) {
        super(path.getType(), path.getMetadata());
    }

    public QUserNotification(PathMetadata metadata) {
        super(UserNotification.class, metadata);
    }

}

