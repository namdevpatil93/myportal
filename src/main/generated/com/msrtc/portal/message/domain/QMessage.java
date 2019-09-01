package com.msrtc.portal.message.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QMessage is a Querydsl query type for Message
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QMessage extends EntityPathBase<Message> {

    private static final long serialVersionUID = 1133662118L;

    public static final QMessage message = new QMessage("message");

    public final BooleanPath active = createBoolean("active");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath messageInMarathi = createString("messageInMarathi");

    public final StringPath messageText = createString("messageText");

    public QMessage(String variable) {
        super(Message.class, forVariable(variable));
    }

    public QMessage(Path<? extends Message> path) {
        super(path.getType(), path.getMetadata());
    }

    public QMessage(PathMetadata metadata) {
        super(Message.class, metadata);
    }

}

