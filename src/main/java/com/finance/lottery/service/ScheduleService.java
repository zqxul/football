package com.finance.lottery.service;

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

    public void saveAndResetDailyVisitCount() {
        System.out.println("DailyVisitCount Save Start,CurrentTime:" + Calendar.getInstance().getTime());

        System.out.println("DailyVisitCount Save Complete");
        System.out.println("DailyVisitCount Reset Start,CurrentTime:" + Calendar.getInstance().getTime());
        stringRedisTemplate.opsForValue().set(backgroundProperties.getCountVisitTotal(), "0");
        stringRedisTemplate.opsForValue().set(backgroundProperties.getCountVisitFootballNews(), "0");
        stringRedisTemplate.opsForValue().set(backgroundProperties.getCountVisitMatchAnalysis(), "0");
        stringRedisTemplate.opsForValue().set(backgroundProperties.getCountVisitScoreLive(), "0");
        stringRedisTemplate.opsForValue().set(backgroundProperties.getCountBigData(), "0");
        System.out.println("DailyVisitCount Reset Complete");
    }
}
