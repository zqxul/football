package com.finance.lottery.request;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/13 21:53
 */
@Component
@ConfigurationProperties(prefix = "lottery.recommend.matchs")
@Data
public class RecommendMatchRequest {
    private String url;
    private Map<String, String> params;
}
