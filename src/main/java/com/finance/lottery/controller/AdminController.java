package com.finance.lottery.controller;

import com.finance.lottery.entity.StaticVisit;
import com.finance.lottery.entity.user.User;
import com.finance.lottery.mapper.StaticVisitMapper;
import com.finance.lottery.result.ResponseEnum;
import com.finance.lottery.service.AdminService;
import com.finance.lottery.service.UserService;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/9 13:02
 */
@Controller
public class AdminController {

    @Autowired
    private StaticVisitMapper staticVisitMapper;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private UserService userService;

    @Autowired
    private AdminService adminService;

    @RequestMapping("/admin")
    public ModelAndView admin(String username, String password) {
        ModelAndView mav = new ModelAndView("admin");
        User user = userService.loginUser(username, password);
        if (user == null) {
            mav.setViewName("invalid");
            mav.addObject("msg", "你不是管理员");
            return mav;
        }

        Map<String, String> todayVisitCountMap = adminService.getTodayVisitCount();
        mav.addObject("footballNewsVisitCount", todayVisitCountMap.get("footballNewsVisitCount"));
        mav.addObject("matchAnalysisVisitCount", todayVisitCountMap.get("matchAnalysisVisitCount"));
        mav.addObject("scoreLiveVisitCount", todayVisitCountMap.get("scoreLiveVisitCount"));
        mav.addObject("bigDataVisitCount", todayVisitCountMap.get("bigDataVisitCount"));
        return mav;
    }
}
