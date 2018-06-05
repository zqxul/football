package com.finance.lottery.interceptor;

import com.finance.lottery.properties.BackgroundProperties;
import com.finance.lottery.util.WebUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/2 13:04
 */
@Component
public class VisitInterceptor implements HandlerInterceptor {
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Value("${football.redis.admin.index.visit-count-key}")
    private String visitCountKey;

    @Autowired
    private BackgroundProperties backgroundProperties;

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {
        stringRedisTemplate.opsForValue().increment(backgroundProperties.getCountVisitTotal(), 1l);
        String ip = WebUtil.getIPAddress(request);

        System.out.println("来自 " + ip + " 的访问:" + stringRedisTemplate.opsForValue().get(backgroundProperties.getCountVisitTotal()));

        String uri = request.getRequestURI();
        if ("/analysis/info".equals(uri)) {
            stringRedisTemplate.opsForValue().increment(backgroundProperties.getCountVisitMatchAnalysis(), 1l);
        }
        if ("/live/matchs/lastest".equals(uri)) {
            stringRedisTemplate.opsForValue().increment(backgroundProperties.getCountVisitScoreLive(), 1l);
        }
        if ("/football/news/list".equals(uri)) {
            stringRedisTemplate.opsForValue().increment(backgroundProperties.getCountVisitFootballNews(), 1l);
        }
        if ("/data".equals(uri)) {
            stringRedisTemplate.opsForValue().increment(backgroundProperties.getCountBigData(), 1l);
        }
    }

}
