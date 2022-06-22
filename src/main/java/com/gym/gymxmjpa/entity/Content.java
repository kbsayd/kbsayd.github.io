package com.gym.gymxmjpa.entity;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class Content {
    private JSONArray mobile;
    private String template_id;
    private int type;
    private JSONObject params;
    private String send_time;
    private String sign;

    public Content() {
    }

    public JSONArray getMobile() {
        return mobile;
    }

    public void setMobile(JSONArray mobile) {
        this.mobile = mobile;
    }

    public String getTemplate_id() {
        return template_id;
    }

    public void setTemplate_id(String template_id) {
        this.template_id = template_id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public JSONObject getParams() {
        return params;
    }

    public void setParams(JSONObject params) {
        this.params = params;
    }

    public String getSend_time() {
        return send_time;
    }

    public void setSend_time(String send_time) {
        this.send_time = send_time;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    @Override
    public String toString() {
        //return "{" +
        //        "mobile:['" + mobile +
        //        "'], template_id:'" + template_id + '\'' +
        //        ", type:" + type +
        //        ", params:" + params +
        //        ", send_time:'" + send_time + '\'' +
        //        ", sign:'" + sign + '\'' +
        //        '}';

        return "{\"mobile\":[\"15635964882\"]," +
                "\"type\":0," +
                "\"template_id\":\"ST_2022051100000001\"," +
                "\"sign\":\"健身房管理系统\"," +
                "\"send_time\":\"\"," +
                "\"params\":{\"code\":4568}}";


    }
}
