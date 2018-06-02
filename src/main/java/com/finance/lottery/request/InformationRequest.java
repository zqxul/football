package com.finance.lottery.request;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.http.HttpEntity;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/13 11:04
 * @Description:
 */
@Component
@ConfigurationProperties(prefix = "lottery.information.matchs")
@Data
public class InformationRequest {
    private String url;
    private String cssPath;
}
