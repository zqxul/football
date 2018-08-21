package com.finance.lottery.service;

import com.finance.lottery.entity.Recharge;
import com.finance.lottery.entity.Withdraw;
import com.finance.lottery.entity.user.Account;
import com.finance.lottery.entity.user.UserAccount;
import com.finance.lottery.mapper.AccountMapper;
import com.finance.lottery.mapper.RechargeMapper;
import com.finance.lottery.mapper.UserAccountMapper;
import com.finance.lottery.mapper.WithdrawMapper;
import com.finance.lottery.properties.BackgroundProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/9 14:12
 */
@Service
public class AdminService {
    @Autowired
    private BackgroundProperties backgroundProperties;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private RechargeMapper rechargeMapper;

    @Autowired
    private WithdrawMapper withdrawMapper;

    @Autowired
    private AccountService accountService;

    @Autowired
    private AccountMapper accountMapper;

    @Autowired
    private UserAccountMapper userAccountMapper;

    public Map<String, String> getTodayVisitCount() {
        Map<String, String> todayVisitCountMap = new HashMap<>();
        String totalVisitCount = backgroundProperties.getCountVisitTotal();
        String footballNewsVisitCount = backgroundProperties.getCountVisitFootballNews();
        String matchAnalysisVisitCount = backgroundProperties.getCountVisitMatchAnalysis();
        String scoreLiveVisitCount = backgroundProperties.getCountVisitScoreLive();
        String bigDataVisitCount = backgroundProperties.getCountBigData();
        todayVisitCountMap.put("footballNewsVisitCount", stringRedisTemplate.opsForValue().get(footballNewsVisitCount));
        todayVisitCountMap.put("matchAnalysisVisitCount", stringRedisTemplate.opsForValue().get(matchAnalysisVisitCount));
        todayVisitCountMap.put("scoreLiveVisitCount", stringRedisTemplate.opsForValue().get(scoreLiveVisitCount));
        todayVisitCountMap.put("bigDataVisitCount", stringRedisTemplate.opsForValue().get(bigDataVisitCount));
        return todayVisitCountMap;
    }

    public Map<String, String> getOneWeekVisitCount() {
        Map<String, String> oneWeekVisitCountMap = new HashMap<>();
        return oneWeekVisitCountMap;
    }

    public Map<String, String> getTwoWeekVisitCount() {
        Map<String, String> twoWeekVisitCountMap = new HashMap<>();
        return twoWeekVisitCountMap;
    }

    public Map<String, String> getOneMonthVisitCount() {
        Map<String, String> oneMonthVisitCountMap = new HashMap<>();
        return oneMonthVisitCountMap;
    }

    public Map<String, String> getThreeMonthVisitCount() {
        Map<String, String> threeMonthVisitCountMap = new HashMap<>();
        return threeMonthVisitCountMap;
    }

    public Map<String, String> getHalfYearVisitCount() {
        Map<String, String> halfYearVisitCountMap = new HashMap<>();
        return halfYearVisitCountMap;
    }

    public Map<String, String> getOneYearVisitCount() {
        Map<String, String> oneYearVisitCountMap = new HashMap<>();
        return oneYearVisitCountMap;
    }

    public List<Recharge> getWaitingRecharges() {
        return rechargeMapper.selectWaitingRecharges();
    }

    public List<Recharge> getProcessedRecharges() {
        return rechargeMapper.selectProcessedRecharges();
    }

    public List<Recharge> getAbandonRecharges() {
        return rechargeMapper.selectAbandonedRecharges();
    }

    public List<Withdraw> getWaitingWithdraws() {
        return withdrawMapper.selectWaitingWithdraws();
    }

    public List<Withdraw> getProcessedWithdraws() {
        return withdrawMapper.selectProcessedWithdraws();
    }

    public List<Withdraw> getAbandonedWithdraws() {
        return withdrawMapper.selectAbandonedWithdraws();
    }

    @Transactional
    public boolean doRecharge(Integer userId, Integer amount, Integer rechargeId) {
        if (accountService.recharge(userId, amount) && rechargeMapper.updateStatus(rechargeId, 1) > 0) {
            return true;
        }
        return false;
    }

    @Transactional
    public boolean doAbandonRecharge(Integer userId, Integer amount, Integer rechargeId) {
        if (rechargeMapper.update(Recharge.builder().isActive(0).build()) > 0) {
            return true;
        }
        return false;
    }

    @Transactional
    public boolean doAbandonWithdraw(Integer userId, Integer amount, Integer rechargeId) {
        //TODO 取消冻结的余额

        if (withdrawMapper.updateSelective(Withdraw.builder().isActive(0).build()) > 0) {
            return true;
        }
        return false;
    }

    @Transactional
    public boolean doWithdrawe(Integer userId, Integer amount, Integer withdrawId) {
        if (accountService.withdraw(userId, amount) && withdrawMapper.updateStatus(withdrawId, 1) > 0) {
            return true;
        }
        return false;
    }

}
