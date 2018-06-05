package com.finance.lottery.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/4 10:47
 */
@Component
@ConfigurationProperties(prefix = "spring.mail")
@Data
public class MailProperties {
    private String host;
    private String username;
    private String password;
    private String properties;
}
