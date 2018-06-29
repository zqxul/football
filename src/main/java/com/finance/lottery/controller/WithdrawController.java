package com.finance.lottery.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/withdraw")
public class WithdrawController {

    @GetMapping("/")
    public ModelAndView withdraw(){
        ModelAndView mav = new ModelAndView("withdraw");
        return mav;
    }
}
