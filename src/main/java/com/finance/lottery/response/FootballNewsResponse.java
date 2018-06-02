package com.finance.lottery.response;

import com.finance.lottery.result.ResponseEnum;
import lombok.Data;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/13 10:02
 * @Description:
 */
@Data
public class FootballNewsResponse {

    private int code;
    private String msg;
    private Object data;

    public FootballNewsResponse() {
    }

    public FootballNewsResponse(ResponseEnum responseEnum) {
        this.code = responseEnum.getCode();
        this.msg = responseEnum.getMsg();
    }

    public FootballNewsResponse(ResponseEnum responseEnum, Object data) {
        this.code = responseEnum.getCode();
        this.msg = responseEnum.getMsg();
        this.data = data;
    }
}
