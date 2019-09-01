package com.msrtc.portal.qualification.domain;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import java.io.Serializable;

@Entity
@Table(name = "qualifications")
public class Qualification implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    
    @NotNull
    @Column(name = "title")
    private String title;
    @NotNull
    @Column(name = "title_mr")
    private String titleInMarathi;
    @NotNull
    @Column(name = "priority")
    private Integer priority;
    
    @Column(name = "active")
    private boolean active;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitleInMarathi() {
        return titleInMarathi;
    }

    public void setTitleInMarathi(String titleInMarathi) {
        this.titleInMarathi = titleInMarathi;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}
    
    
}

