package com.finance.lottery.schedule;

import com.finance.lottery.properties.BackgroundProperties;
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
    private RedisTemplate redisTemplate;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private BackgroundProperties backgroundProperties;

    @Value("${football.redis.admin.index.visit-count-key}")
    private String visitCountKey;

    @Scheduled(cron = "0 0 0/1 * * ?")
    public void resetVisitCount() {
        System.out.println("CurrentTime:" + Calendar.getInstance().getTime());
        stringRedisTemplate.opsForValue().set(visitCountKey, "0");
        stringRedisTemplate.opsForValue().set(backgroundProperties.getCountVisitFootballNews(), "0");
        stringRedisTemplate.opsForValue().set(backgroundProperties.getCountVisitMatchAnalysis(), "0");
        stringRedisTemplate.opsForValue().set(backgroundProperties.getCountVisitScoreLive(), "0");
        stringRedisTemplate.opsForValue().set(backgroundProperties.getCountVisitTotal(), "0");
        System.out.println("VisitCount Reset to :" + stringRedisTemplate.opsForValue().get(visitCountKey));
    }

    public void saveVisitCount() {

    }
}
