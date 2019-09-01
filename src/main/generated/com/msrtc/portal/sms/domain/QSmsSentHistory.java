package com.msrtc.portal.sms.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QSmsSentHistory is a Querydsl query type for SmsSentHistory
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QSmsSentHistory extends EntityPathBase<SmsSentHistory> {

    private static final long serialVersionUID = 1623981334L;

    public static final QSmsSentHistory smsSentHistory = new QSmsSentHistory("smsSentHistory");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final DateTimePath<java.time.LocalDateTime> sentTime = createDateTime("sentTime", java.time.LocalDateTime.class);

    public final StringPath sentTo = createString("sentTo");

    public final StringPath smsType = createString("smsType");

    public final StringPath status = createString("status");

    public QSmsSentHistory(String variable) {
        super(SmsSentHistory.class, forVariable(variable));
    }

    public QSmsSentHistory(Path<? extends SmsSentHistory> path) {
        super(path.getType(), path.getMetadata());
    }

    public QSmsSentHistory(PathMetadata metadata) {
        super(SmsSentHistory.class, metadata);
    }

}

