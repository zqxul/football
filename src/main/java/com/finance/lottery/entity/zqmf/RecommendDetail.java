package com.finance.lottery.entity.zqmf;

import lombok.Data;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/16 12:50
 */
@Data
public class RecommendDetail {
    private String userId;
    private String username;
    private String matchId;
    private String leagueName;
    private String hostName;
    private String visitName;
    private String matchTime;
    private String recommendType;
    private String recommendValue;
    private String recommendPrice;
    private String recommendReason;
    private String handicap;
    private String handicapValue;
}
