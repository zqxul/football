package com.finance.lottery.mapper;

import com.finance.lottery.entity.zqmf.RecommendPay;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/18 18:03
 */
@Mapper
public interface RecommendPayMapper extends BaseMapper<RecommendPay>{

    List<Integer> selectRecommendPayedUserIds();

    Integer selectRecommendPayedCountByUserId(@Param("userId") Integer userId);
}
