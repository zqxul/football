package com.finance.lottery.mapper;

import com.finance.lottery.entity.Recharge;
import com.finance.lottery.entity.Withdraw;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/18 19:15
 */
@Mapper
public interface WithdrawMapper extends BaseMapper<Withdraw> {
    int updateStatus(@Param("withdrawId") Integer rechargeId, @Param("status") Integer status);
}
