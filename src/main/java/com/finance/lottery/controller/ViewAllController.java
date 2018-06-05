package com.finance.lottery.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/2 15:02
 */
@RestController
@RequestMapping("/all")
public class ViewAllController {

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Value("${football.redis.admin.index.visit-count-key}")
    private String visitCountKey;

    @GetMapping("/visitCount")
    public String getVisitCount() {
        return redisTemplate.opsForValue().get(visitCountKey);
    }
}
