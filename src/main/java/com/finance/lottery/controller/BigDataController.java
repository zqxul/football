package com.finance.lottery.controller;

import com.finance.lottery.entity.BigDataPara;
import com.finance.lottery.service.BigDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/4 14:10
 */
@RestController
public class BigDataController {

    @Autowired
    private BigDataService bigDataService;


//    public ModelAndView getMatchData(String competition) {
//        ModelAndView mav = new ModelAndView("bigdata");
//        List<String> elements = bigDataService.getMatchData(competition);
//        mav.addObject("statList", elements.get(0));
//        mav.addObject("statDetail", elements.get(1));
//        return mav;
//    }

    @GetMapping("/data")
    public ModelAndView getMatchData(BigDataPara bigDataPara) {
        ModelAndView mav = new ModelAndView("bigdata");
        List<String> elements = bigDataService.getMatchData(bigDataPara);
        mav.addObject("statList", elements.get(0));
        mav.addObject("statDetail", elements.get(1));
        return mav;
    }

    @GetMapping("/team/{teamId}.html")
    public ModelAndView getTeamDetail(@PathVariable String teamId) {
        String teamDetail = bigDataService.getTeamData(teamId);
        ModelAndView mav = new ModelAndView("team");
        mav.addObject("teamDetail",teamDetail);
        return mav;
    }

    @GetMapping("/player/{playerId}.html")
    public ModelAndView getPlayerDetail(@PathVariable String playerId) {
        String playerDetail = bigDataService.getPlayerData(playerId);
        ModelAndView mav = new ModelAndView("player");
        mav.addObject("playerDetail",playerDetail);
        return mav;
    }
}
