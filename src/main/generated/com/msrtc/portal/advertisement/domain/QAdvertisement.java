package com.msrtc.portal.advertisement.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.Generated;
import com.querydsl.core.types.Path;


/**
 * QAdvertisement is a Querydsl query type for Advertisement
 */
@Generated("com.querydsl.codegen.EntitySerializer")
public class QAdvertisement extends EntityPathBase<Advertisement> {

    private static final long serialVersionUID = -1394727514L;

    public static final QAdvertisement advertisement = new QAdvertisement("advertisement");

    public final com.msrtc.portal.core.audit.domain.QAbstractAuditingEntity _super = new com.msrtc.portal.core.audit.domain.QAbstractAuditingEntity(this);

    public final BooleanPath active = createBoolean("active");

    public final StringPath advertisementNo = createString("advertisementNo");

    public final StringPath advertisementNoMarathi = createString("advertisementNoMarathi");

    public final DatePath<java.time.LocalDate> closingDate = createDate("closingDate", java.time.LocalDate.class);

    //inherited
    public final NumberPath<Long> createdBy = _super.createdBy;

    //inherited
    public final DateTimePath<java.util.Date> createdDate = _super.createdDate;

    public final StringPath description = createString("description");

    public final StringPath descriptionMarathi = createString("descriptionMarathi");

    public final StringPath documentName = createString("documentName");

    public final StringPath documentNameMarathi = createString("documentNameMarathi");

    //inherited
    public final NumberPath<Long> id = _super.id;

    //inherited
    public final NumberPath<Long> lastModifiedBy = _super.lastModifiedBy;

    //inherited
    public final DateTimePath<java.util.Date> lastModifiedDate = _super.lastModifiedDate;

    public final DatePath<java.time.LocalDate> startDate = createDate("startDate", java.time.LocalDate.class);

    public final StringPath title = createString("title");

    public final StringPath titleMarathi = createString("titleMarathi");

    public QAdvertisement(String variable) {
        super(Advertisement.class, forVariable(variable));
    }

    public QAdvertisement(Path<? extends Advertisement> path) {
        super(path.getType(), path.getMetadata());
    }

    public QAdvertisement(PathMetadata metadata) {
        super(Advertisement.class, metadata);
    }

}

