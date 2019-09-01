package com.msrtc.portal.core.systemsetting.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QSystemSetting is a Querydsl query type for SystemSetting
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QSystemSetting extends EntityPathBase<SystemSetting> {

    private static final long serialVersionUID = -1521954127L;

    public static final QSystemSetting systemSetting = new QSystemSetting("systemSetting");

    public final StringPath description = createString("description");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final DateTimePath<java.util.Date> modifiedTime = createDateTime("modifiedTime", java.util.Date.class);

    public final StringPath value = createString("value");

    public QSystemSetting(String variable) {
        super(SystemSetting.class, forVariable(variable));
    }

    public QSystemSetting(Path<? extends SystemSetting> path) {
        super(path.getType(), path.getMetadata());
    }

    public QSystemSetting(PathMetadata metadata) {
        super(SystemSetting.class, metadata);
    }

}

