package com.sicc.admin.demo.model;

import org.hibernate.validator.constraints.NotBlank;

import java.io.Serializable;

public class SearchCriteria implements Serializable {

    @NotBlank(message = "username can't empty!")
    String username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}