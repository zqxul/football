package com.finance.lottery.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/recharge")
public class RechargeController {

    @GetMapping("/")
    public ModelAndView recharge(){
        ModelAndView mav = new ModelAndView("recharge");
        return mav;
    }
}
