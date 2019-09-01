package com.msrtc.portal.core.role.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QRole is a Querydsl query type for Role
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QRole extends EntityPathBase<Role> {

    private static final long serialVersionUID = -2064746987L;

    public static final QRole role = new QRole("role");

    public final StringPath description = createString("description");

    public final BooleanPath enabled = createBoolean("enabled");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final NumberPath<Long> parentRoleId = createNumber("parentRoleId", Long.class);

    public final ListPath<RoleModuleOperation, QRoleModuleOperation> roleModuleOperationList = this.<RoleModuleOperation, QRoleModuleOperation>createList("roleModuleOperationList", RoleModuleOperation.class, QRoleModuleOperation.class, PathInits.DIRECT2);

    public final BooleanPath systemDefined = createBoolean("systemDefined");

    public final StringPath title = createString("title");

    public QRole(String variable) {
        super(Role.class, forVariable(variable));
    }

    public QRole(Path<? extends Role> path) {
        super(path.getType(), path.getMetadata());
    }

    public QRole(PathMetadata metadata) {
        super(Role.class, metadata);
    }

}

