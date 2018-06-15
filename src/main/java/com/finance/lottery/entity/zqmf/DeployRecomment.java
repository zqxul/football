package com.finance.lottery.entity.zqmf;

import lombok.Data;

import java.util.Date;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/14 11:54
 */
@Data
public class DeployRecomment {
    private Integer userId;
    private String matchId;
    private Integer type;
    private Integer value;
    private String handicap;
    private String matchResult;
    private Date createTime;
    private String createBy;
}
