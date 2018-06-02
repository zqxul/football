package com.finance.lottery.entity.netease;

import lombok.Data;

import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/20 23:14
 * @Description:
 */
@Data
public class MatchPointRanking {
    private List<MatchPointRankingInfo> rankings;
    private String title;
    private List<MatchPointRankingCup> cup;
}
