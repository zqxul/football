package com.finance.lottery.controller;

import com.finance.lottery.entity.BigDataPara;
import com.finance.lottery.result.ResponseEnum;
import com.finance.lottery.service.BigDataService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @Author: xuzhiqing
 * @Description: 大数据内容Controller
 * @Date: 2018/6/4 14:10
 */
@RestController
public class BigDataController {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

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
        StringBuilder dataKey = new StringBuilder("lottery_bigdata_data");
        if(StringUtils.isNotBlank(bigDataPara.getCompetition())){
            dataKey.append("_"+bigDataPara.getCompetition());
        }
        if(StringUtils.isNotBlank(bigDataPara.getSeason_id())){
            dataKey.append("_"+bigDataPara.getSeason_id());
        }
        if(StringUtils.isNotBlank(bigDataPara.getRound_id())){
            dataKey.append("_"+bigDataPara.getRound_id());
        }
        if(StringUtils.isNotBlank(bigDataPara.getType())){
            dataKey.append("_"+bigDataPara.getType());
        }
        if(StringUtils.isNotBlank(bigDataPara.getGameweek())){
            dataKey.append("_"+bigDataPara.getGameweek());
        }
        List<String> elements = (List<String>) redisTemplate.opsForValue().get(dataKey.toString());
        if (elements != null && elements.size() > 1) {
            mav.addObject("statList", elements.get(0));
            mav.addObject("statDetail", elements.get(1));
            result.setResult(mav);
            return result;
        }
        elements = bigDataService.getMatchData(bigDataPara);
        if (elements == null) {
            mav.setViewName("invalid");
            mav.addObject("msg", ResponseEnum.INVALID);
            result.setResult(mav);
            return result;
        }
        if (elements != null && elements.size() > 0) {
            redisTemplate.opsForValue().set(dataKey.toString(), elements, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(dataKey.toString(), elements, 3, TimeUnit.MINUTES);
        }
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
        ModelAndView mav = new ModelAndView("team");
        String teamKey = "lottery_bigdata_team_" + teamId;
        String teamDetail = stringRedisTemplate.opsForValue().get(teamKey);
        if (teamDetail != null) {
            mav.addObject("teamDetail", teamDetail);
            result.setResult(mav);
            return result;
        }
        teamDetail = bigDataService.getTeamData(teamId);
        if (teamDetail == null) {
            mav.setViewName("invalid");
            mav.addObject("msg", ResponseEnum.INVALID.getMsg());
            result.setResult(mav);
            return result;
        }
        if (teamDetail != null) {
            stringRedisTemplate.opsForValue().set(teamKey, teamDetail, 3, TimeUnit.HOURS);
        } else {
            stringRedisTemplate.opsForValue().set(teamKey, teamDetail, 3, TimeUnit.MINUTES);
        }
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
        ModelAndView mav = new ModelAndView("player");
        String playerKey = "lottery_bigdata_player_" + playerId;
        List<String> elements = (List<String>) redisTemplate.opsForValue().get(playerKey);
        if (elements != null && elements.size() > 0) {
            mav.addObject("playerDetail", elements.get(0));
            mav.addObject("script", elements.get(1));
            result.setResult(mav);
            return result;
        }
        elements = bigDataService.getPlayerData(playerId);
        if (elements == null && elements.size() < 1) {
            mav.setViewName("invalid");
            mav.addObject("msg", ResponseEnum.INVALID);
            result.setResult(mav);
            return result;
        }
        if (elements != null && elements.size() > 1) {
            redisTemplate.opsForValue().set(playerKey, elements, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(playerKey, elements, 3, TimeUnit.MINUTES);
        }
        mav.addObject("playerDetail", elements.get(0));
        mav.addObject("script", elements.get(1));
        result.setResult(mav);
        return result;
    }
}
