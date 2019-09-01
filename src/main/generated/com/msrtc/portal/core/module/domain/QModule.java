package com.msrtc.portal.core.module.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QModule is a Querydsl query type for Module
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QModule extends EntityPathBase<Module> {

    private static final long serialVersionUID = -1167380351L;

    public static final QModule module = new QModule("module");

    public final StringPath displayName = createString("displayName");

    public final NumberPath<Long> moduleId = createNumber("moduleId", Long.class);

    public final StringPath moduleName = createString("moduleName");

    public final ListPath<ModuleOperation, QModuleOperation> moduleOperationList = this.<ModuleOperation, QModuleOperation>createList("moduleOperationList", ModuleOperation.class, QModuleOperation.class, PathInits.DIRECT2);

    public QModule(String variable) {
        super(Module.class, forVariable(variable));
    }

    public QModule(Path<? extends Module> path) {
        super(path.getType(), path.getMetadata());
    }

    public QModule(PathMetadata metadata) {
        super(Module.class, metadata);
    }

}

