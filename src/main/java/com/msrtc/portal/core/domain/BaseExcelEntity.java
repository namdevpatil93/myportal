package com.msrtc.portal.core.domain;

import org.springframework.util.StringUtils;

import java.lang.reflect.Field;
import java.math.BigDecimal;

public abstract class BaseExcelEntity {

    public void setPropertyValue(Field field, Object fieldValue) {

        if (fieldValue == null || "".equals(fieldValue)) {
            return;
        }

        try {
            field.setAccessible(true);
            if (field.getType() == String.class) {
                field.set(this, StringUtils.trimWhitespace(fieldValue.toString()));
            } else if (field.getType() == BigDecimal.class) {
                field.set(this, new BigDecimal(fieldValue.toString()));
            } else if (field.getType() == Long.class) {
                field.set(this, new Long(Double.valueOf(fieldValue.toString()).longValue()));
            } else if (field.getType() == Integer.class) {
                field.set(this, new Integer(Double.valueOf(fieldValue.toString()).intValue()));
            } else if (field.getType() == Float.class) {
                field.set(this, new Float(fieldValue.toString()));
            } else if (field.getType() == Double.class) {
                field.set(this, new Double(fieldValue.toString()));
            }
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

}
