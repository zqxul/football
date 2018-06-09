package com.finance.lottery.service;

import com.finance.lottery.entity.StaticVisit;
import com.finance.lottery.mapper.StaticVisitMapper;
import com.finance.lottery.properties.BackgroundProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.Calendar;

/**
 * @Author: xuzhiqing
 * @Description: 定时任务服务类
 * @Date: 2018/6/5 17:12
 */
@Service
public class ScheduleService {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private BackgroundProperties backgroundProperties;

    @Autowired
    private StaticVisitMapper staticVisitMapper;

    public void saveAndResetDailyVisitCount() {
        String totalVisitCount = backgroundProperties.getCountVisitTotal();
        String footballNewsVisitCount = backgroundProperties.getCountVisitFootballNews();
        String matchAnalysisVisitCount = backgroundProperties.getCountVisitMatchAnalysis();
        String scoreLiveVisitCount = backgroundProperties.getCountVisitScoreLive();
        String bigDataVisitCount = backgroundProperties.getCountBigData();

        System.out.println("DailyVisitCount Save Start,CurrentTime:" + Calendar.getInstance().getTime());
        StaticVisit footballNewsVisit = StaticVisit.builder().visitUrl("/football/news/list").visitCount(Integer.valueOf(stringRedisTemplate.opsForValue().get(footballNewsVisitCount))).createTime(Calendar.getInstance().getTime()).build();
        StaticVisit matchAnalysisVisit = StaticVisit.builder().visitUrl("/analysis/info").visitCount(Integer.valueOf(stringRedisTemplate.opsForValue().get(matchAnalysisVisitCount))).createTime(Calendar.getInstance().getTime()).build();
        StaticVisit scoreLiveVisit = StaticVisit.builder().visitUrl("/live/matchs/lastest").visitCount(Integer.valueOf(stringRedisTemplate.opsForValue().get(scoreLiveVisitCount))).createTime(Calendar.getInstance().getTime()).build();
        StaticVisit bigDataVisit = StaticVisit.builder().visitUrl("/data").visitCount(Integer.valueOf(stringRedisTemplate.opsForValue().get(bigDataVisitCount))).createTime(Calendar.getInstance().getTime()).build();
        staticVisitMapper.insert(footballNewsVisit);
        staticVisitMapper.insert(matchAnalysisVisit);
        staticVisitMapper.insert(scoreLiveVisit);
        staticVisitMapper.insert(bigDataVisit);
        System.out.println("DailyVisitCount Save Complete");

        System.out.println("DailyVisitCount Reset Start,CurrentTime:" + Calendar.getInstance().getTime());
        stringRedisTemplate.opsForValue().set(totalVisitCount, "0");
        stringRedisTemplate.opsForValue().set(footballNewsVisitCount, "0");
        stringRedisTemplate.opsForValue().set(matchAnalysisVisitCount, "0");
        stringRedisTemplate.opsForValue().set(scoreLiveVisitCount, "0");
        stringRedisTemplate.opsForValue().set(bigDataVisitCount, "0");
        System.out.println("DailyVisitCount Reset Complete");
    }
}
