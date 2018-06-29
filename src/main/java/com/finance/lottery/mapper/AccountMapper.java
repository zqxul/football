package com.finance.lottery.mapper;

import com.finance.lottery.entity.user.Account;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/18 19:15
 */
@Mapper
public interface AccountMapper extends BaseMapper<Account>{

    int updateAmount(@Param("accountId") Integer accountId, @Param("amount") Integer amount);

    Account selectByPrimaryKeyForUpdate(Integer id);

}
