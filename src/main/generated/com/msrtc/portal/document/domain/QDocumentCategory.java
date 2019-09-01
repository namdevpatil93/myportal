package com.msrtc.portal.document.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QDocumentCategory is a Querydsl query type for DocumentCategory
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QDocumentCategory extends EntityPathBase<DocumentCategory> {

    private static final long serialVersionUID = -1077468398L;

    public static final QDocumentCategory documentCategory = new QDocumentCategory("documentCategory");

    public final com.msrtc.portal.core.audit.domain.QAbstractAuditingEntity _super = new com.msrtc.portal.core.audit.domain.QAbstractAuditingEntity(this);

    public final BooleanPath active = createBoolean("active");

    public final StringPath categoryTitle = createString("categoryTitle");

    public final StringPath categoryTitleMarathi = createString("categoryTitleMarathi");

    //inherited
    public final NumberPath<Long> createdBy = _super.createdBy;

    //inherited
    public final DateTimePath<java.util.Date> createdDate = _super.createdDate;

    public final NumberPath<Integer> documentType = createNumber("documentType", Integer.class);

    //inherited
    public final NumberPath<Long> id = _super.id;

    //inherited
    public final NumberPath<Long> lastModifiedBy = _super.lastModifiedBy;

    //inherited
    public final DateTimePath<java.util.Date> lastModifiedDate = _super.lastModifiedDate;

    public QDocumentCategory(String variable) {
        super(DocumentCategory.class, forVariable(variable));
    }

    public QDocumentCategory(Path<? extends DocumentCategory> path) {
        super(path.getType(), path.getMetadata());
    }

    public QDocumentCategory(PathMetadata metadata) {
        super(DocumentCategory.class, metadata);
    }

}

