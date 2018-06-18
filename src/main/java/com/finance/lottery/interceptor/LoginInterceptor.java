package com.finance.lottery.interceptor;

import com.finance.lottery.entity.user.User;
import com.finance.lottery.util.WebUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.concurrent.TimeUnit;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/5/29 18:42
 */
public class LoginInterceptor implements HandlerInterceptor {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private RedisTemplate redisTemplate;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String token = WebUtil.getCookieValue(request, "token");
        if (token == null || !redisTemplate.hasKey(token)) {
            response.sendRedirect("/login");
            return false;
        }else{
            redisTemplate.expire(token,2, TimeUnit.HOURS);
        }
        return true;
    }
}
