package com.msrtc.portal.qualification.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QQualification is a Querydsl query type for Qualification
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QQualification extends EntityPathBase<Qualification> {

    private static final long serialVersionUID = -300442650L;

    public static final QQualification qualification = new QQualification("qualification");

    public final BooleanPath active = createBoolean("active");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final NumberPath<Integer> priority = createNumber("priority", Integer.class);

    public final StringPath title = createString("title");

    public final StringPath titleInMarathi = createString("titleInMarathi");

    public QQualification(String variable) {
        super(Qualification.class, forVariable(variable));
    }

    public QQualification(Path<? extends Qualification> path) {
        super(path.getType(), path.getMetadata());
    }

    public QQualification(PathMetadata metadata) {
        super(Qualification.class, metadata);
    }

}

