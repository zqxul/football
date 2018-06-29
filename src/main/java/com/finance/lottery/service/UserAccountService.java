package com.finance.lottery.service;

import com.finance.lottery.entity.user.Account;
import com.finance.lottery.entity.user.UserAccount;
import com.finance.lottery.mapper.UserAccountMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/19 14:26
 */
@Service
public class UserAccountService {
    @Autowired
    private UserAccountMapper userAccountMapper;

    public UserAccount bindUserAccount(Integer userId, Integer accountId) {
        UserAccount userAccount = new UserAccount();
        userAccount.setUserId(userId);
        userAccount.setAccountId(accountId);
        userAccount.setCreateTime(Calendar.getInstance().getTime());
        int bindResult = userAccountMapper.insert(userAccount);
        if (bindResult > 0) {
            return userAccount;
        }
        return null;
    }
}
