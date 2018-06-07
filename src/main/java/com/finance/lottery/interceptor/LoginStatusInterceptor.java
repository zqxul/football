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

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/5/29 18:42
 */
public class LoginStatusInterceptor implements HandlerInterceptor {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private RedisTemplate redisTemplate;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            String token = WebUtil.getCookieValue(request, "token");
            if (token != null) {
                User user = (User) redisTemplate.opsForValue().get(token);
                modelAndView.addObject("user", user);
                modelAndView.addObject("url",request.getRequestURL().toString());
            }
        }
    }
}
