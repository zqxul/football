package com.finance.lottery.schedule;

import com.finance.lottery.properties.BackgroundProperties;
import com.finance.lottery.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Calendar;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/2 13:16
 */
@Component
public class EveryDaySchedule {
    @Autowired
    private ScheduleService scheduleService;

    @Scheduled(cron = "0 0 0/12 * * ?")
    public void SaveAndResetDailyVisitCount() {
        scheduleService.saveAndResetDailyVisitCount();
    }
}
