package com.finance.lottery.schedule;

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

    @Value("${football.redis.visit-count-key}")
    private String visitCountKey;

    @Scheduled(cron = "0 0 0/1 * * ?")
    public void resetVisitCount(){
        System.out.println("CurrentTime:"+Calendar.getInstance().getTime());
        stringRedisTemplate.opsForValue().set(visitCountKey,"0");
        System.out.println("VisitCount Reset to :"+stringRedisTemplate.opsForValue().get(visitCountKey));
    }

    public void saveVisitCount(){

    }
}
