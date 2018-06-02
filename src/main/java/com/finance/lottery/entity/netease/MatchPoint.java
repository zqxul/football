package com.finance.lottery.entity.netease;

import lombok.Data;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/20 23:14
 * @Description:
 */
@Data
public class MatchPoint {
    private MatchPointRanking matchTotalRanking;
    private MatchPointRanking matchHostRanking;
    private MatchPointRanking matchVisitRanking;
}
