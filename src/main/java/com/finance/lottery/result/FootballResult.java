package com.finance.lottery.result;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/24 17:51
 * @Description:
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FootballResult {
    private String msg;
    private Integer code;
    private Object data;

    public void setResult(ResponseEnum responseEnum) {
        this.msg = responseEnum.getMsg();
        this.code = responseEnum.getCode();
    }

    public void setResult(ResponseEnum responseEnum, Object data) {
        this.msg = responseEnum.getMsg();
        this.code = responseEnum.getCode();
        this.data = data;
    }

    public FootballResult(ResponseEnum responseEnum) {
        this.msg = responseEnum.getMsg();
        this.code = responseEnum.getCode();
    }

    public FootballResult(ResponseEnum responseEnum, Object data) {
        this.msg = responseEnum.getMsg();
        this.code = responseEnum.getCode();
        this.data = data;
    }
}
