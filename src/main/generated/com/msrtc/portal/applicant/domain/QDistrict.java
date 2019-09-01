package com.msrtc.portal.applicant.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QDistrict is a Querydsl query type for District
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QDistrict extends EntityPathBase<District> {

    private static final long serialVersionUID = 1688310090L;

    public static final QDistrict district = new QDistrict("district");

    public final NumberPath<Integer> districtOrder = createNumber("districtOrder", Integer.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath messageKey = createString("messageKey");

    public final StringPath name = createString("name");

    public QDistrict(String variable) {
        super(District.class, forVariable(variable));
    }

    public QDistrict(Path<? extends District> path) {
        super(path.getType(), path.getMetadata());
    }

    public QDistrict(PathMetadata metadata) {
        super(District.class, metadata);
    }

}

