package com.finance.lottery.service;

import com.finance.lottery.properties.BackgroundProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/9 14:12
 */
@Service
public class AdminService {
    @Autowired
    private BackgroundProperties backgroundProperties;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    public Map<String, String> getTodayVisitCount() {
        Map<String, String> todayVisitCountMap = new HashMap<>();
        String totalVisitCount = backgroundProperties.getCountVisitTotal();
        String footballNewsVisitCount = backgroundProperties.getCountVisitFootballNews();
        String matchAnalysisVisitCount = backgroundProperties.getCountVisitMatchAnalysis();
        String scoreLiveVisitCount = backgroundProperties.getCountVisitScoreLive();
        String bigDataVisitCount = backgroundProperties.getCountBigData();
        todayVisitCountMap.put("footballNewsVisitCount", stringRedisTemplate.opsForValue().get(footballNewsVisitCount));
        todayVisitCountMap.put("matchAnalysisVisitCount", stringRedisTemplate.opsForValue().get(matchAnalysisVisitCount));
        todayVisitCountMap.put("scoreLiveVisitCount", stringRedisTemplate.opsForValue().get(scoreLiveVisitCount));
        todayVisitCountMap.put("bigDataVisitCount", stringRedisTemplate.opsForValue().get(bigDataVisitCount));
        return todayVisitCountMap;
    }

    public Map<String, String> getOneWeekVisitCount() {
        Map<String, String> oneWeekVisitCountMap = new HashMap<>();
        return oneWeekVisitCountMap;
    }

    public Map<String, String> getTwoWeekVisitCount() {
        Map<String, String> twoWeekVisitCountMap = new HashMap<>();
        return twoWeekVisitCountMap;
    }

    public Map<String, String> getOneMonthVisitCount() {
        Map<String, String> oneMonthVisitCountMap = new HashMap<>();
        return oneMonthVisitCountMap;
    }

    public Map<String, String> getThreeMonthVisitCount() {
        Map<String, String> threeMonthVisitCountMap = new HashMap<>();
        return threeMonthVisitCountMap;
    }

    public Map<String, String> gethalfYearVisitCount() {
        Map<String, String> halfYearVisitCountMap = new HashMap<>();
        return halfYearVisitCountMap;
    }

    public Map<String, String> getOneYearVisitCount() {
        Map<String, String> oneYearVisitCountMap = new HashMap<>();
        return oneYearVisitCountMap;
    }
}
