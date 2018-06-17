package com.finance.lottery.mapper;

import com.finance.lottery.entity.zqmf.Recommend;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/16 16:09
 */
@Mapper
public interface RecommendMapper extends BaseMapper<Recommend> {

    List<Recommend> selectTodayselectTodayRecord();
}
