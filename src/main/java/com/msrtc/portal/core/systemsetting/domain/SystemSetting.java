package com.msrtc.portal.core.systemsetting.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * The type System setting.
 */
@Entity
@Table(name = "system_settings")
public class SystemSetting implements Serializable {

    private static final long serialVersionUID = 4009876374934890849L;

    @Id
	@Column(name = "id")
	private Long id;

	@Column(name = "value")
	private String value;

	@Column(name = "description", insertable = false, updatable = false)
	private String description;

	@Column(name = "modified_time", insertable = false, updatable = false)
	private Date modifiedTime;

    public SystemSetting(){

    }

    public SystemSetting(Long id, String value) {
        this.id = id;
        this.value = value;
    }

    /**
     * Gets id.
     *
     * @return the id
     */
    public Long getId() {
        return id;
    }

    /**
     * Sets id.
     *
     * @param id the id
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * Gets value.
     *
     * @return the value
     */
    public String getValue() {
        return value;
    }

    /**
     * Sets value.
     *
     * @param value the value
     */
    public void setValue(String value) {
        this.value = value;
    }

    /**
     * Gets description.
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets desc.
     *
     * @param description the description
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Gets modified time.
     *
     * @return the modified time
     */
    public Date getModifiedTime() {
        return modifiedTime;
    }

    /**
     * Sets modified time.
     *
     * @param modifiedTime the modified time
     */
    public void setModifiedTime(Date modifiedTime) {
        this.modifiedTime = modifiedTime;
    }

    @Override
    public String toString() {
        return "SystemSetting{" +
                "id=" + id +
                ", value='" + value + '\'' +
                ", description='" + description + '\'' +
                ", modifiedTime=" + modifiedTime +
                '}';
    }
}
