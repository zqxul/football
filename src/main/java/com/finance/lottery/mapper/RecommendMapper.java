package com.finance.lottery.mapper;

import com.finance.lottery.entity.zqmf.Recommend;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/16 16:09
 */
@Mapper
public interface RecommendMapper extends BaseMapper<Recommend> {

    List<Recommend> selectTodayselectTodayRecord();

    List<Recommend> selectRecommendNoMatchResult();

    int updateMatchResult(@Param("recommendId") Integer recommendId, @Param("result") Integer result);

    List<Integer> selectRecommendUserIds();

    Integer selectTotalCountByRecommend(Recommend recommend);

    Integer selectMonthCountByRecommend(Recommend recommend);

    Integer selectWeekCountByRecommend(Recommend recommend);

    List<Recommend> selectTopRecommendByUserId(@Param("userId") Integer userId, @Param("topNum") Integer topNum);
}
