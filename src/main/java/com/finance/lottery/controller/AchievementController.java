package com.finance.lottery.controller;

import com.finance.lottery.entity.zqmf.Recommend;
import com.finance.lottery.service.AchievementService;
import com.finance.lottery.service.RecommendService;
import com.finance.lottery.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.stream.Collectors;

/**
 * ClassName: AchievementController
 * Description:
 *
 * @Author xuzhiqing
 * @Date 2018/7/2 at 13:57
 * @Version 1.0
 **/
@RestController
@RequestMapping("/achievement")
public class AchievementController {

    @Autowired
    private RecommendService recommendService;

    @Autowired
    private UserService userService;

    @Autowired
    private AchievementService achievementService;

    @GetMapping("/{userId}")
    public DeferredResult<ModelAndView> achievement(@PathVariable Integer userId) {
        DeferredResult<ModelAndView> result = new DeferredResult<>();
        ModelAndView mav = new ModelAndView("achievement");
        String photoUrl = "localhost:5555/custom/";
        List<Recommend> recommends = achievementService.getRecommends(userId);
        if (recommends != null) {
            List<String> leagues = recommends.parallelStream().map(recommend -> recommend.getLeagueName()).collect(Collectors.toSet()).stream().collect(Collectors.toList());
            mav.addObject("leagues", leagues);
            mav.addObject("recommends", recommends);
        }
        mav.addObject("status", achievementService.estimateStatus(userId));
        mav.addObject("experience", achievementService.estimateExperience(userId));
        mav.addObject("popularity", achievementService.estimatePopularity(userId));
        mav.addObject("ability", achievementService.estimateAbility(userId));
        mav.addObject("stability", achievementService.estimateStability(userId));
        mav.addObject("recommendScatters",achievementService.countLeagues(userId));
        result.setResult(mav);
        return result;
    }
}
