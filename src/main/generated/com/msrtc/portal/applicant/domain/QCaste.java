package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QCaste is a Querydsl query type for Caste
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QCaste extends EntityPathBase<Caste> {

    private static final long serialVersionUID = 358598858L;

    public static final QCaste caste = new QCaste("caste");

    public final NumberPath<Integer> casteOrder = createNumber("casteOrder", Integer.class);

    public final StringPath casteTitle = createString("casteTitle");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath messageKey = createString("messageKey");

    public final NumberPath<Integer> postFees = createNumber("postFees", Integer.class);

    public QCaste(String variable) {
        super(Caste.class, forVariable(variable));
    }

    public QCaste(Path<? extends Caste> path) {
        super(path.getType(), path.getMetadata());
    }

    public QCaste(PathMetadata metadata) {
        super(Caste.class, metadata);
    }

}

