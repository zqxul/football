package com.finance.lottery.mapper;

import com.finance.lottery.entity.user.Account;
import com.finance.lottery.entity.user.UserAccount;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/18 19:15
 */
@Mapper
public interface UserAccountMapper extends BaseMapper<UserAccount>{

    UserAccount selectUserAccountByUserId(Integer userId);
}
