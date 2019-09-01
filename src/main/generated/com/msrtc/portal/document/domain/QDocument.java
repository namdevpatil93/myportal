package com.msrtc.portal.document.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QDocument is a Querydsl query type for Document
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QDocument extends EntityPathBase<Document> {

    private static final long serialVersionUID = -1045088780L;

    public static final QDocument document = new QDocument("document");

    public final com.msrtc.portal.core.audit.domain.QAbstractAuditingEntity _super = new com.msrtc.portal.core.audit.domain.QAbstractAuditingEntity(this);

    public final BooleanPath active = createBoolean("active");

    public final NumberPath<Integer> categoryType = createNumber("categoryType", Integer.class);

    //inherited
    public final NumberPath<Long> createdBy = _super.createdBy;

    //inherited
    public final DateTimePath<java.util.Date> createdDate = _super.createdDate;

    public final StringPath description = createString("description");

    public final StringPath descriptionMarathi = createString("descriptionMarathi");

    public final StringPath documentName = createString("documentName");

    public final StringPath documentNameMarathi = createString("documentNameMarathi");

    public final NumberPath<Integer> documentType = createNumber("documentType", Integer.class);

    //inherited
    public final NumberPath<Long> id = _super.id;

    //inherited
    public final NumberPath<Long> lastModifiedBy = _super.lastModifiedBy;

    //inherited
    public final DateTimePath<java.util.Date> lastModifiedDate = _super.lastModifiedDate;

    public final NumberPath<Integer> subCategoryType = createNumber("subCategoryType", Integer.class);

    public final StringPath title = createString("title");

    public final StringPath titleMarathi = createString("titleMarathi");

    public QDocument(String variable) {
        super(Document.class, forVariable(variable));
    }

    public QDocument(Path<? extends Document> path) {
        super(path.getType(), path.getMetadata());
    }

    public QDocument(PathMetadata metadata) {
        super(Document.class, metadata);
    }

}

