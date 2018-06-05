package com.finance.lottery.controller;

import com.finance.lottery.entity.BigDataPara;
import com.finance.lottery.service.BigDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @Author: xuzhiqing
 * @Description: 大数据内容Controller
 * @Date: 2018/6/4 14:10
 */
@RestController
public class BigDataController {

    @Autowired
    private BigDataService bigDataService;

    /**
     * @param bigDataPara 大数据页面内容的请求参数(联赛、轮次、积分榜、射手榜、助攻榜、赛程表)
     * @Author: xuzhiqing
     * @Date: 2018/6/5 13:54
     * @Description: 获取大数据页面内容
     */
    @GetMapping("/data")
    public DeferredResult<ModelAndView> getMatchData(BigDataPara bigDataPara) {
        DeferredResult<ModelAndView> result = new DeferredResult<>();
        ModelAndView mav = new ModelAndView("bigdata");
        List<String> elements = bigDataService.getMatchData(bigDataPara);
        mav.addObject("statList", elements.get(0));
        mav.addObject("statDetail", elements.get(1));
        result.setResult(mav);
        return result;
    }

    /**
     * @param teamId 球员ID
     * @Author: xuzhiqing
     * @Date: 2018/6/5 13:56
     * @Description: 获取球队信息数据
     */
    @GetMapping("/team/{teamId}.html")
    public DeferredResult<ModelAndView> getTeamDetail(@PathVariable String teamId) {
        DeferredResult<ModelAndView> result = new DeferredResult<>();
        String teamDetail = bigDataService.getTeamData(teamId);
        ModelAndView mav = new ModelAndView("team");
        mav.addObject("teamDetail", teamDetail);
        result.setResult(mav);
        return result;
    }

    /**
     * @param playerId 球员ID
     * @Author: xuzhiqing
     * @Date: 2018/6/5 13:57
     * @Description: 获取球员信息
     */
    @GetMapping("/player/{playerId}.html")
    public DeferredResult<ModelAndView> getPlayerDetail(@PathVariable String playerId) {
        DeferredResult<ModelAndView> result = new DeferredResult<>();
        String playerDetail = bigDataService.getPlayerData(playerId);
        ModelAndView mav = new ModelAndView("player");
        mav.addObject("playerDetail", playerDetail);
        result.setResult(mav);
        return result;
    }
}
