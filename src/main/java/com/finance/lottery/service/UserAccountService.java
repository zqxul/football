package com.finance.lottery.service;

import com.finance.lottery.entity.user.UserAccount;
import com.finance.lottery.mapper.UserAccountMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;

/**
 * @Author: xuzhiqing
 * @Description: 用户账户Service
 * @Date: 2018/6/19 14:26
 */
@Service
public class UserAccountService {
    @Autowired
    private UserAccountMapper userAccountMapper;

    /**
     * MethodName: bindUserAccount
     * Description: 用户账户绑定
     *
     * @param userId    用户ID
     * @param accountId 账户ID
     * @Return com.finance.lottery.entity.user.UserAccount
     */
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
