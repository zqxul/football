package com.finance.lottery.entity.zqmf;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/16 16:15
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recommend {
    private Integer id;
    private Integer userId;
    private String matchId;
    private String leagueName;
    private Integer type;
    private Integer value;
    private String handicap;
    private String handicapValue;
    private String reason;
    private Integer price;
    private Integer matchResult;
    private String host;
    private String visit;
    private String matchTime;
    private Date createTime;
    private String createBy;

    public Recommend(RecommendDetail recommendDetail){
        this.userId = Integer.valueOf(recommendDetail.getUserId());
        this.matchId = recommendDetail.getMatchId();
        this.leagueName = recommendDetail.getLeagueName();
        this.type = Integer.valueOf(recommendDetail.getRecommendType());
        this.value = Integer.valueOf(recommendDetail.getRecommendValue());
        this.handicap = recommendDetail.getHandicap();
        this.handicapValue = recommendDetail.getHandicapValue();
        this.reason = recommendDetail.getRecommendReason();
        this.price = Integer.valueOf(recommendDetail.getRecommendPrice());
        this.host = recommendDetail.getHostName();
        this.visit = recommendDetail.getVisitName();
        this.matchTime = recommendDetail.getMatchTime();
        this.createBy = recommendDetail.getUsername();
    }
}
