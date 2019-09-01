package com.msrtc.portal.core.module.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QModuleOperation is a Querydsl query type for ModuleOperation
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QModuleOperation extends EntityPathBase<ModuleOperation> {

    private static final long serialVersionUID = -2034645530L;

    public static final QModuleOperation moduleOperation = new QModuleOperation("moduleOperation");

    public final StringPath displayName = createString("displayName");

    public final NumberPath<Long> moduleId = createNumber("moduleId", Long.class);

    public final NumberPath<Long> moduleOperationId = createNumber("moduleOperationId", Long.class);

    public final StringPath moduleOperationName = createString("moduleOperationName");

    public QModuleOperation(String variable) {
        super(ModuleOperation.class, forVariable(variable));
    }

    public QModuleOperation(Path<? extends ModuleOperation> path) {
        super(path.getType(), path.getMetadata());
    }

    public QModuleOperation(PathMetadata metadata) {
        super(ModuleOperation.class, metadata);
    }

}

