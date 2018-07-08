package com.finance.lottery.mapper;

import com.finance.lottery.entity.Achievement;
import com.finance.lottery.entity.zqmf.Recommend;
import com.finance.lottery.entity.zqmf.RecommendPay;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * ClassName: AchievementMapper
 * Description:
 *
 * @Author xuzhiqing
 * @Date 2018/7/7 at 13:25
 * @Version 1.0
 **/
@Mapper
public interface AchievementMapper {

    List<Recommend> selectLastSeven(Integer userId);

    List<Recommend> selectLastSevenByRecommendType(Integer userId, Integer type);

    Date selectRecommendStartTime(Integer userId);

    Date selectRecommendStartTimeByRecommendType(Integer userId, Integer type);

    Date selectRecommendEndTime(Integer userId);

    Date selectRecommendEndTimeByRecommendType(Integer userId, Integer type);

    List<Recommend> selectLastTen(Integer userId);

    List<Recommend> selectLastTenByRecommendType(@Param("userId") Integer userId, @Param("type") Integer type);

    Integer selectNearlyRecommendPayCountByUserId(Integer userId);

    Integer selectNearlyRecommendPayCountByUserIdAndRecommendType(@Param("userId") Integer userId, @Param("recommendType") Integer recommendType);

    Integer selectNearlyRecommendPayCount();

    Integer selectNearlyRecommendPayCountByRecommendType(Integer type);

}
