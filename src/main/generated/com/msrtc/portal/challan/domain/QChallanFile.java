package com.msrtc.portal.challan.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QChallanFile is a Querydsl query type for ChallanFile
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QChallanFile extends EntityPathBase<ChallanFile> {

    private static final long serialVersionUID = -324449790L;

    public static final QChallanFile challanFile = new QChallanFile("challanFile");

    public final StringPath fileName = createString("fileName");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath originalFileName = createString("originalFileName");

    public final NumberPath<Long> uploadedBy = createNumber("uploadedBy", Long.class);

    public final DateTimePath<java.time.LocalDateTime> uploadedDate = createDateTime("uploadedDate", java.time.LocalDateTime.class);

    public QChallanFile(String variable) {
        super(ChallanFile.class, forVariable(variable));
    }

    public QChallanFile(Path<? extends ChallanFile> path) {
        super(path.getType(), path.getMetadata());
    }

    public QChallanFile(PathMetadata metadata) {
        super(ChallanFile.class, metadata);
    }

}

