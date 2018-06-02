package com.finance.lottery.request;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/12 23:08
 * @Description:
 */
@Component
@ConfigurationProperties(prefix = "lottery.live.matchs")
@Data
public class MatchRequest {

    private String url;
    private Map<String, String> params;
}
