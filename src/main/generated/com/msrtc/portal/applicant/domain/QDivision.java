package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QDivision is a Querydsl query type for Division
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QDivision extends EntityPathBase<Division> {

    private static final long serialVersionUID = 1764068969L;

    public static final QDivision division = new QDivision("division");

    public final NumberPath<Long> divisionId = createNumber("divisionId", Long.class);

    public final NumberPath<Integer> divisionOrder = createNumber("divisionOrder", Integer.class);

    public final StringPath divisionTitle = createString("divisionTitle");

    public final BooleanPath isDroughtAffected = createBoolean("isDroughtAffected");

    public final StringPath messageKey = createString("messageKey");

    public QDivision(String variable) {
        super(Division.class, forVariable(variable));
    }

    public QDivision(Path<? extends Division> path) {
        super(path.getType(), path.getMetadata());
    }

    public QDivision(PathMetadata metadata) {
        super(Division.class, metadata);
    }

}

