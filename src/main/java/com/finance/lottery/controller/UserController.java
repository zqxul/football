package com.finance.lottery.controller;

import com.alibaba.fastjson.JSONObject;
import com.finance.lottery.entity.user.Account;
import com.finance.lottery.entity.user.User;
import com.finance.lottery.result.FootballResult;
import com.finance.lottery.result.ResponseEnum;
import com.finance.lottery.service.AccountService;
import com.finance.lottery.service.UserAccountService;
import com.finance.lottery.service.UserService;
import com.finance.lottery.util.WebUtil;
import com.sun.org.apache.regexp.internal.RE;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * @Author: xuzhiqing
 * @Date: 2018/5/24 17:39
 * @Description: 用户Controller
 */
@RestController
@RequestMapping("/user")
public class UserController {
    @Value("${football.redis.user.resetpass.prefix}")
    private String resetpass_prefix;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private UserService userService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private UserAccountService userAccountService;

    @PostMapping("/register")
    public ModelAndView register(User user) {
        ModelAndView mav = new ModelAndView("success");
        if (userService.userExist(user.getUsername())) {
            mav.addObject("response", ResponseEnum.USER_EXIST);
            return mav;
        }

        String password = user.getPassword();
        user.setPassword(DigestUtils.md5DigestAsHex(password.getBytes()));
        user.setCreateTime(Calendar.getInstance().getTime());
        user.setRole(0);
        user.setLevel(0);
        if (!userService.registerUser(user)) {
            mav.addObject("response", ResponseEnum.SERVER_ERROR);
            return mav;
        }
        int count = userService.getUserCount();
        mav.addObject("user", user);
        mav.addObject("response", ResponseEnum.SUCCESS);
        mav.addObject("count", count + 1);
        return mav;
    }

    @PostMapping("/login")
    public FootballResult login(HttpServletResponse response, @RequestParam String username, @RequestParam String password) {
        User user = userService.loginUser(username, password);
        if (null == user) {
            return new FootballResult(ResponseEnum.LOGIN_FAILURE);
        }
        if (user.getRole() == 1) {
            return new FootballResult(ResponseEnum.ADMINSUCCESS);
        }
        String token = UUID.randomUUID().toString();
        WebUtil.writeCookie(response, "token", token, 7200);
        redisTemplate.opsForValue().set(token, user, 2, TimeUnit.HOURS);
        return new FootballResult(ResponseEnum.SUCCESS);
    }

    @RequestMapping("/logout")
    public ModelAndView logout(HttpServletRequest request, String url) {
        ModelAndView mav = new ModelAndView("redirect:" + url);
        String token = WebUtil.getCookieValue(request, "token");
        redisTemplate.delete(token);
        return mav;
    }

    @GetMapping("/check")
    public FootballResult check(@RequestParam String username) {
        FootballResult result = new FootballResult();
        if (StringUtils.isBlank(username)) {
            result.setResult(ResponseEnum.PARAM_NULL);
            return result;
        }
        if (userService.userExist(username)) {
            result.setResult(ResponseEnum.USER_EXIST);
            return result;
        }
        result.setResult(ResponseEnum.USER_AVAILABLE);
        return result;
    }

    @RequestMapping("/reset/check/token")
    public ModelAndView checkResetToken(String token) {
        ModelAndView mav = new ModelAndView();
        if (!stringRedisTemplate.hasKey(resetpass_prefix + token)) {
            mav.setViewName("invalid");
            mav.addObject("msg", ResponseEnum.RESET_PASS_INVALID.getMsg());
            return mav;
        }
        mav.setViewName("resetpass");
        User user = JSONObject.parseObject(stringRedisTemplate.opsForValue().get(resetpass_prefix + token), User.class);
        mav.addObject("username", user.getUsername());
        mav.addObject("token", token);
        return mav;
    }

    @PostMapping("/reset/pass")
    public ModelAndView resetPassword(String token, String password) {
        ModelAndView mav = new ModelAndView("resetsuccess");
        if (!stringRedisTemplate.hasKey(resetpass_prefix + token)) {
            mav.addObject("response", ResponseEnum.RESET_PASS_INVALID);
            return mav;
        }
        if (!userService.resetPassword(token, password)) {
            mav.addObject("response", ResponseEnum.SERVER_ERROR);
            return mav;
        }
        mav.addObject("response", ResponseEnum.SUCCESS);
        return mav;
    }

    /**
     * MethodName: sendEmail
     * Description: 向指定用户发送邮件
     *
     * @param sendUsername 收件人
     * @Return com.finance.lottery.result.FootballResult
     */
    @GetMapping("/reset/send/email")
    public FootballResult sendEmail(@RequestParam String sendUsername) {

        //修改发送邮件的逻辑，通过填写用户名，根据用户名查询到邮箱地址并发送邮件
        FootballResult result = new FootballResult();
        if (StringUtils.isBlank(sendUsername)) {
            result.setResult(ResponseEnum.PARAM_NULL);
            return result;
        }
        User user = userService.getUser(User.builder().username(sendUsername).build());
        if (user == null) {
            result.setResult(ResponseEnum.EMAIL_NOT_BIND);
            return result;
        }
        try {
            userService.sendEmail(user);
        } catch (MessagingException e) {
            result.setResult(ResponseEnum.SERVER_ERROR);
            return result;
        }
        result.setResult(ResponseEnum.SUCCESS);
        return result;
    }

    /**
     * MethodName: fillInfo
     * Description: 完善用户信息页面
     *
     * @param request
     * @Return org.springframework.web.servlet.ModelAndView
     */
    @GetMapping("/fill/info")
    public ModelAndView fillInfo(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("information");
        User user = userService.getUser(request);
        mav.addObject("user", user);
        return mav;
    }

    /**
     * MethodName: fullInfo
     * Description: 完善用户信息
     *
     * @param user 用户
     * @Return com.finance.lottery.result.FootballResult
     */
    @GetMapping("/fill")
    public FootballResult fillInfo(User user) {
        FootballResult result = new FootballResult();
        if (!userService.fillInfo(user)) {
            result.setResult(ResponseEnum.FAILED);
            return result;
        }
        result.setResult(ResponseEnum.SUCCESS);
        return result;
    }
}
