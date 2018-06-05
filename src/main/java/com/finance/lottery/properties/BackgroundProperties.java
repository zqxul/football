package com.finance.lottery.properties;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/4 12:13
 */

@Component
@Data
public class BackgroundProperties {
    @Value("${count.visit.total}")
    private String countVisitTotal;
    @Value("${count.visit.football-news}")
    private String countVisitFootballNews;
    @Value("${count.visit.match-analysis}")
    private String countVisitMatchAnalysis;
    @Value("${count.visit.score-live}")
    private String countVisitScoreLive;

    @Value("${count.newuser.total}")
    private String countNewUserTotal;
    @Value("${count.newuser.common}")
    private String countNewUserCommon;
    @Value("${count.newuser.senior}")
    private String countNewUserSenior;
    @Value("${count.newuser.finance}")
    private String countNewUserFinance;

    @Value("${count.recharge.total}")
    private String countRechargeTotal;
    @Value("${count.recharge.common}")
    private String countRechargeCommon;
    @Value("${count.recharge.senior}")
    private String countRechargeSenior;
    @Value("${count.recharge.finance}")
    private String countRechargeFinance;

    @Value("${count.withdraw.total}")
    private String countWithdrawTotal;
    @Value("${count.withdraw.common}")
    private String countWithdrawCommon;
    @Value("${count.withdraw.senior}")
    private String countWithdrawSenior;
    @Value("${count.withdraw.finance}")
    private String countWithdrawFinance;

    @Value("${count.profit.total}")
    private String countProfitTotal;
    @Value("${count.profit.recommend}")
    private String countProfitRecommend;
    @Value("${count.profit.view}")
    private String countProfitView;
    @Value("${count.profit.member}")
    private String countProfitmember;

    @Value("${todo.recharge-count}")
    private String todoRechargeCount;
    @Value("${todo.withdraw-count}")
    private String todoWithdrawCount;
    
}




