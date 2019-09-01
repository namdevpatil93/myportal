package com.msrtc.portal.document.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QDocumentSubCategory is a Querydsl query type for DocumentSubCategory
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QDocumentSubCategory extends EntityPathBase<DocumentSubCategory> {

    private static final long serialVersionUID = 1551864010L;

    public static final QDocumentSubCategory documentSubCategory = new QDocumentSubCategory("documentSubCategory");

    public final com.msrtc.portal.core.audit.domain.QAbstractAuditingEntity _super = new com.msrtc.portal.core.audit.domain.QAbstractAuditingEntity(this);

    public final BooleanPath active = createBoolean("active");

    public final NumberPath<Integer> categoryType = createNumber("categoryType", Integer.class);

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

    public final StringPath subCategoryTitle = createString("subCategoryTitle");

    public final StringPath subCategoryTitleMarathi = createString("subCategoryTitleMarathi");

    public QDocumentSubCategory(String variable) {
        super(DocumentSubCategory.class, forVariable(variable));
    }

    public QDocumentSubCategory(Path<? extends DocumentSubCategory> path) {
        super(path.getType(), path.getMetadata());
    }

    public QDocumentSubCategory(PathMetadata metadata) {
        super(DocumentSubCategory.class, metadata);
    }

}

