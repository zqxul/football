package com.finance.lottery.request;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @Author: xuzhiqing
 * @Description: 必发指数请求
 * @Date: 2018/6/1 22:00
 */
@Component
@ConfigurationProperties(prefix = "lottery.index")
@Data
public class BFIndexRequest {
    private String url;
    private String jsonPath;
    private String cssPath;
}
