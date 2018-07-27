package com.finance.lottery.controller;

import com.finance.lottery.entity.StaticVisit;
import com.finance.lottery.entity.user.User;
import com.finance.lottery.entity.zqmf.Recommend;
import com.finance.lottery.mapper.StaticVisitMapper;
import com.finance.lottery.result.FootballResult;
import com.finance.lottery.result.ResponseEnum;
import com.finance.lottery.service.AdminService;
import com.finance.lottery.service.RecommendService;
import com.finance.lottery.service.UserService;
import com.finance.lottery.vo.ReviewRecommend;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
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
@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private StaticVisitMapper staticVisitMapper;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private UserService userService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private RecommendService recommendService;

    @RequestMapping("")
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

    @GetMapping("/withdraw")
    public ModelAndView withdraw() {
        ModelAndView mav = new ModelAndView("withdraw");
        return mav;
    }

    @GetMapping("/recharge")
    public ModelAndView recharge() {
        ModelAndView mav = new ModelAndView("recharge");
        return mav;
    }

    @GetMapping("/review/recommend")
    public ModelAndView review() {
        ModelAndView mav = new ModelAndView("review");
        List<ReviewRecommend> waitingRecommends = recommendService.getUnReviewedRecommend();
        List<ReviewRecommend> reviewedRecommends = recommendService.getReviewedRecommend();
        mav.addObject("waitingRecommends",waitingRecommends);
        mav.addObject("reviewedRecommends",reviewedRecommends);
        return mav;
    }

    @GetMapping("/modify/recommend/status")
    public FootballResult modifyRecommendStatus(@RequestParam(required = false) Integer recommendId, @RequestParam(required = false) Integer status) {
        FootballResult result = new FootballResult();
        if (!recommendService.modifyRecommendStatus(recommendId, status)) {
            result.setResult(ResponseEnum.FAILED);
            return result;
        }
        result.setResult(ResponseEnum.SUCCESS);
        return result;
    }
}
