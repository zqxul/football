package com.finance.lottery.schedule;

import com.finance.lottery.entity.zqmf.Recommend;
import com.finance.lottery.properties.BackgroundProperties;
import com.finance.lottery.service.RecommendService;
import com.finance.lottery.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Calendar;
import java.util.List;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/2 13:16
 */
@Component
public class LotterySchedule {
    @Autowired
    private ScheduleService scheduleService;

    @Scheduled(cron = "0 55 23 * * ?")
    public void SaveAndResetDailyVisitCount() {
        scheduleService.saveAndResetDailyVisitCount();
    }

    @Scheduled(cron = "0 40 0/1 * * ?")
    public void UpdateRecommendResult(){
        scheduleService.UpdateRecommendResult();
    }

    @Scheduled(cron = "0 0/1 * * * ?")
    public void UpdateRecommendResults(){
        scheduleService.UpdateRecommendResult();
    }
}
