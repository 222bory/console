package com.sicc.admin.demo.model;

import java.io.Serializable;
import java.util.List;

public class AjaxResponseBody implements Serializable {

    String msg;
    List<User2> result;

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public List<User2> getResult() {
        return result;
    }

    public void setResult(List<User2> result) {
        this.result = result;
    }

}
