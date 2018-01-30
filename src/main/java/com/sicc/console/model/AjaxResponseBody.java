package com.sicc.admin.model;

import java.util.List;

public class AjaxResponseBody {

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
