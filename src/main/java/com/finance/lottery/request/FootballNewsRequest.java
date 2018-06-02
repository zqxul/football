package com.finance.lottery.request;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/17 22:58
 * @Description:
 */
@Component
@ConfigurationProperties(prefix = "lottery.football.new")
@Data
public class FootballNewsRequest {
    private String url;
    private Map<String, String> params;
}
