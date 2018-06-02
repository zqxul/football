package com.finance.lottery.entity.netease;

import lombok.Data;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/21 11:33
 * @Description:
 */
@Data
public class MatchOddEurope {
    private String companyCnName;
    private String companyId;
    private String firstDrawOdds;
    private String firstHostOdds;
    private String firstVisitOdds;
    private String nowDrawOdds;
    private String nowHostOdds;
    private String nowVisitOdds;
}
