package com.finance.lottery.controller;

import com.finance.lottery.entity.user.Account;
import com.finance.lottery.entity.user.User;
import com.finance.lottery.result.FootballResult;
import com.finance.lottery.result.ResponseEnum;
import com.finance.lottery.service.AccountService;
import com.finance.lottery.service.UserAccountService;
import com.finance.lottery.service.UserService;
import com.finance.lottery.util.WebUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * @Author: xuzhiqing
 * @Description: 账户Controller
 * @Date: 2018/5/29 17:08
 */
@RestController
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private AccountService accountService;

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public DeferredResult<ModelAndView> account(HttpServletRequest request) {
        DeferredResult<ModelAndView> result = new DeferredResult<>();
        ModelAndView mav = new ModelAndView("account");
        String token = WebUtil.getCookieValue(request, "token");
        User user = (User) redisTemplate.opsForValue().get(token);
        Account account = accountService.getAccount(user.getId());
        mav.addObject("account", account);
        result.setResult(mav);
        return result;
    }

    /**
     * MethodName: charge
     * Description:
     *
     * @param request
     * @param rechargeAmount
     * @Return org.springframework.web.context.request.async.DeferredResult<com.finance.lottery.result.FootballResult>
     */
    @GetMapping("/recharge")
    public DeferredResult<FootballResult> charge(HttpServletRequest request, Integer rechargeAmount) {
        DeferredResult<FootballResult> result = new DeferredResult<>();
        FootballResult footballResult = new FootballResult();
        if (rechargeAmount == null) {
            footballResult.setResult(ResponseEnum.ACCOUNT_CHARGE_AMOUNT_NULL);
            result.setResult(footballResult);
            return result;
        }
        String token = WebUtil.getCookieValue(request, "token");
        User user = (User) redisTemplate.opsForValue().get(token);
        if (userService.recharge(user.getId(), rechargeAmount)) {
            footballResult.setResult(ResponseEnum.ACCOUNT_CHARGE_SUCCESS);
        } else {
            footballResult.setResult(ResponseEnum.ACCOUNT_CHARGE_FAILURE);
        }
        result.setResult(footballResult);
        return result;
    }

    /**
     * Description:
     *
     * @param request
     * @param withdrawAmount
     * @Return org.springframework.web.context.request.async.DeferredResult<com.finance.lottery.result.FootballResult>
     */
    @GetMapping("/withdraw")
    public DeferredResult<FootballResult> withdraw(HttpServletRequest request, Integer withdrawAmount) {
        DeferredResult<FootballResult> result = new DeferredResult<>();
        FootballResult footballResult = new FootballResult();
        if (withdrawAmount == null) {
            footballResult.setResult(ResponseEnum.ACCOUNT_WITHDRAW_SUCCESS);
            result.setResult(footballResult);
            return result;
        }
        String token = WebUtil.getCookieValue(request, "token");
        User user = (User) redisTemplate.opsForValue().get(token);
        Account account = accountService.getAccount(user.getId());
        Integer amount = account.getAmount();
        if (withdrawAmount > amount) {
            footballResult.setResult(ResponseEnum.ACCOUNT_AMOUNT_NOT_ENOUGH);
            result.setResult(footballResult);
            return result;
        }
        if (userService.withdraw(user.getId(), withdrawAmount)) {
            footballResult.setResult(ResponseEnum.ACCOUNT_CHARGE_SUCCESS);
        } else {
            footballResult.setResult(ResponseEnum.ACCOUNT_CHARGE_FAILURE);
        }
        result.setResult(footballResult);
        return result;
    }

}
