package com.finance.lottery.entity.netease;

import lombok.Data;

import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/20 23:16
 * @Description:
 */
@Data
public class MatchOdd {
    List<MatchOddEurope> ouOdds;
    List<MatchOddAsia> asiaOdds;
    List<MatchOddSizeBall> dxpOdds;
}
