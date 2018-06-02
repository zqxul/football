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
@ConfigurationProperties(prefix = "lottery.live.matchinfo")
@Data
public class MatchAnalysisRequest {

    private String url;
    private String oddUrl;
    private Map<String, String> params;
}
