package com.msrtc.portal.message.domain;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "messages")
public class Message implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;

    @Column(name = "message")
    private String messageText;

    @Column(name = "message_mr")
    private String messageInMarathi;

    @Column(name = "active")
    private boolean active = false;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }

    public String getMessageInMarathi() {
        return messageInMarathi;
    }

    public void setMessageInMarathi(String messageInMarathi) {
        this.messageInMarathi = messageInMarathi;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
