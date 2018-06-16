package com.finance.lottery.entity.zqmf;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/16 12:45
 */
@Data
@Builder
public class Recomment {
    private Integer id;
    private Integer userId;
    private String matchId;
    private String leagueName;
    private String host;
    private String visit;
    private Integer type;
    private Integer value;
    private String handicap;
    private String matchResult;
    private Date createTime;
    private String createBy;
}
