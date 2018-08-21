package com.finance.lottery.mapper;

import com.finance.lottery.entity.Recharge;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/18 19:15
 */
@Mapper
public interface RechargeMapper extends BaseMapper<Recharge> {
    int updateStatus(@Param("rechargeId") Integer rechargeId, @Param("status") Integer status);

    List<Recharge> selectWaitingRecharges();

    List<Recharge> selectProcessedRecharges();

    List<Recharge> selectAbandonedRecharges();
}
