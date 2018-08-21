package com.finance.lottery.service;

import com.finance.lottery.entity.Recharge;
import com.finance.lottery.entity.Withdraw;
import com.finance.lottery.entity.user.Account;
import com.finance.lottery.entity.user.User;
import com.finance.lottery.entity.user.UserAccount;
import com.finance.lottery.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;

/**
 * @Author: xuzhiqing
 * @Description: 账户服务类
 * @Date: 2018/5/29 17:10
 */
@Service
public class AccountService {

    @Autowired
    private AccountMapper accountMapper;

    @Autowired
    private UserAccountMapper userAccountMapper;

    @Autowired
    private RechargeMapper rechargeMapper;

    @Autowired
    private WithdrawMapper withdrawMapper;

    public Account createAccount() {
        Account account = new Account();
        account.setAmount(0);
        account.setAvailableAmount(0);
        account.setCreateTime(Calendar.getInstance().getTime());
        int accountResult = accountMapper.insert(account);
        if (accountResult > 0) {
            return account;
        }
        return null;
    }

    public Account getAccount(Integer userId) {
        UserAccount userAccount = userAccountMapper.selectUserAccountByUserId(userId);
        if (userAccount == null) {
            return null;
        }
        return accountMapper.selectByPrimaryKey(userAccount.getAccountId());
    }

    @Transactional
    public boolean recharge(Integer userId, Integer rechargeAmount) {
        UserAccount userAccount = userAccountMapper.selectUserAccountByUserId(userId);
        Account account = accountMapper.selectByPrimaryKeyForUpdate(userAccount.getId());
        Integer amount = account.getAmount() + rechargeAmount;
        int result = accountMapper.updateAmount(account.getId(), amount);
        if (result > 0) {
            return true;
        }
        return false;
    }

    @Transactional
    public boolean withdraw(Integer userId, Integer withdrawAmount) {
        UserAccount userAccount = userAccountMapper.selectUserAccountByUserId(userId);
        Account account = accountMapper.selectByPrimaryKeyForUpdate(userAccount.getId());
        Integer amount = account.getAmount() - withdrawAmount;
        if (amount < 0) {
            return false;
        }
        int result = accountMapper.updateSelective(Account.builder().id(account.getId()).freezedAmount(0).build());
        if (result > 0) {
            return true;
        }
        return false;
    }

}
