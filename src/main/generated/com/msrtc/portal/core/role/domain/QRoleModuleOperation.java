package com.msrtc.portal.core.role.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QRoleModuleOperation is a Querydsl query type for RoleModuleOperation
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QRoleModuleOperation extends EntityPathBase<RoleModuleOperation> {

    private static final long serialVersionUID = -1340572282L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QRoleModuleOperation roleModuleOperation = new QRoleModuleOperation("roleModuleOperation");

    public final com.msrtc.portal.core.module.domain.QModuleOperation moduleOperation;

    public final NumberPath<Long> moduleOperationId = createNumber("moduleOperationId", Long.class);

    public final NumberPath<Long> roleId = createNumber("roleId", Long.class);

    public final NumberPath<Long> roleModuleOperationId = createNumber("roleModuleOperationId", Long.class);

    public QRoleModuleOperation(String variable) {
        this(RoleModuleOperation.class, forVariable(variable), INITS);
    }

    public QRoleModuleOperation(Path<? extends RoleModuleOperation> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QRoleModuleOperation(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QRoleModuleOperation(PathMetadata metadata, PathInits inits) {
        this(RoleModuleOperation.class, metadata, inits);
    }

    public QRoleModuleOperation(Class<? extends RoleModuleOperation> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.moduleOperation = inits.isInitialized("moduleOperation") ? new com.msrtc.portal.core.module.domain.QModuleOperation(forProperty("moduleOperation")) : null;
    }

}

