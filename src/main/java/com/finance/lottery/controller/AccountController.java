package com.finance.lottery.controller;

import com.finance.lottery.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author: xuzhiqing
 * @Description: 账户Controller
 * @Date: 2018/5/29 17:08
 */
@RestController
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private AccountService accountService;
}
