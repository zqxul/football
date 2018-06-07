package com.finance.lottery.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/7 11:27
 */
@RestController
@RequestMapping("/recommend")
public class RecommendController {

    @GetMapping("/")
    public ModelAndView getRecommend() {
        ModelAndView mav = new ModelAndView("recommend");

        return mav;
    }
}
