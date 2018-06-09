package com.finance.lottery.mapper;

import com.finance.lottery.entity.StaticVisit;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/25 22:14
 * @Description:
 */
@Mapper
public interface StaticVisitMapper extends BaseMapper<StaticVisit> {

    int selectCountByVisitUrl(String visitUrl);

    List<StaticVisit> selectTodayRecord();

}
