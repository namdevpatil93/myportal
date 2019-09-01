package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QTrade is a Querydsl query type for Trade
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QTrade extends EntityPathBase<Trade> {

    private static final long serialVersionUID = 374787368L;

    public static final QTrade trade = new QTrade("trade");

    public final BooleanPath active = createBoolean("active");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath messageKey = createString("messageKey");

    public final StringPath title = createString("title");

    public final NumberPath<Integer> tradeOrder = createNumber("tradeOrder", Integer.class);

    public QTrade(String variable) {
        super(Trade.class, forVariable(variable));
    }

    public QTrade(Path<? extends Trade> path) {
        super(path.getType(), path.getMetadata());
    }

    public QTrade(PathMetadata metadata) {
        super(Trade.class, metadata);
    }

}

