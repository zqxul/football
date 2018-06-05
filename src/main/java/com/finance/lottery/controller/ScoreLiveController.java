package com.finance.lottery.controller;

import com.alibaba.fastjson.JSON;
import com.finance.lottery.entity.netease.MatchInfo;
import com.finance.lottery.request.MatchAnalysisRequest;
import com.finance.lottery.request.ScoreLiveMatchRequest;
import com.finance.lottery.result.ResponseEnum;
import com.finance.lottery.service.ScoreLiveService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/12 19:32
 * @Description:
 */
@RestController
@RequestMapping("/live")
public class ScoreLiveController {

    @Autowired
    private ScoreLiveMatchRequest scoreLiveMatchRequest;

    @Autowired
    private MatchAnalysisRequest matchAnalysisRequest;

    @Autowired
    private ScoreLiveService scoreLiveService;

    /**
     * @param
     * @Author: xuzhiqing
     * @Date: 2018/5/13 08:10
     * @Description: 获取一周之内的所有比赛
     */
//    @GetMapping("/matchs/lastest")
//    public DeferredResult<List<MatchInfo>> getMatchsLastest() {
//        DeferredResult<List<MatchInfo>> deferredResult = new DeferredResult<>();
//        CompletableFuture.supplyAsync(() ->
//                scoreLiveService.getScoreLiveMatchResponse(scoreLiveMatchRequest)).thenApply(response -> {
//            String lastedPerid = response.getData().parallelStream().map(matchPeriod -> matchPeriod.getPeriod()).sorted(Comparator.reverseOrder()).findFirst().get().toString();
//            List<MatchInfo> matchInfos = response.getData().parallelStream().filter(matchPeriod -> lastedPerid.equals(matchPeriod.getPeriod())).findFirst().get().getMatchInfo();
//            return deferredResult.setResult(matchInfos);
//        });
//        return deferredResult;
//    }
//    @GetMapping("/matchs/lastest")
//    public DeferredResult<ModelAndView> getMatchsLastest() {
//        DeferredResult<ModelAndView> deferredResult = new DeferredResult<>();
//        long time1 = System.currentTimeMillis();
//        CompletableFuture.supplyAsync(() ->
//                scoreLiveService.getScoreLiveMatchs(scoreLiveMatchRequest)).thenApply(matchInfoList -> {
//            List<String> periods = scoreLiveService.getMatchPeriods(scoreLiveMatchRequest);
//            List<String> times = matchInfoList.parallelStream().map(matchInfo -> matchInfo.getMatchTime()).collect(Collectors.toSet()).parallelStream().sorted().collect(Collectors.toList());
//            List<String> leagues = matchInfoList.parallelStream().map(matchInfo -> matchInfo.getLeagueName()).collect(Collectors.toSet()).parallelStream().sorted().collect(Collectors.toList());
//            ModelAndView mav = new ModelAndView("scorelive");
//            mav.addObject("periods", periods);
//            mav.addObject("times", times);
//            mav.addObject("leagues", leagues);
//            mav.addObject("matchInfos", matchInfoList);
//            return deferredResult.setResult(mav);
//        });
//        System.out.println("It takes for " + (System.currentTimeMillis() - time1) + " seconds");
//        return deferredResult;
//    }
    @GetMapping("/matchs/lastest")
    public DeferredResult<ModelAndView> getMatchsLastest() {
        DeferredResult<ModelAndView> deferredResult = new DeferredResult<>();
        long time1 = System.currentTimeMillis();
        List<MatchInfo> matchInfoList = scoreLiveService.getScoreLiveMatchs(scoreLiveMatchRequest);
        List<String> times = matchInfoList.parallelStream().map(matchInfo -> matchInfo.getMatchTime()).collect(Collectors.toSet()).parallelStream().sorted().collect(Collectors.toList());
        List<String> leagues = matchInfoList.parallelStream().map(matchInfo -> matchInfo.getLeagueName()).collect(Collectors.toSet()).parallelStream().sorted().collect(Collectors.toList());
        ModelAndView mav = new ModelAndView("scorelive");
        mav.addObject("times", times);
        mav.addObject("leagues", leagues);
        mav.addObject("matchInfos", matchInfoList);
        deferredResult.setResult(mav);
        System.out.println("GetMatchsLastest uses " + (System.currentTimeMillis() - time1) + " ms");
        return deferredResult;
    }

    @GetMapping("/getPeriods")
    public List<String> getPeriods() {
        List<String> periods = scoreLiveService.getMatchPeriods(scoreLiveMatchRequest);
        return periods;
    }

    @GetMapping("/matchs")
    public DeferredResult<ModelAndView> getMatchsByDate(@RequestParam String date) {
        DeferredResult<ModelAndView> deferredResult = new DeferredResult<>();
        long time1 = System.currentTimeMillis();
        CompletableFuture.supplyAsync(() ->
                scoreLiveService.getScoreLiveMatchsByDate(scoreLiveMatchRequest, date)).thenApply(matchInfoList -> {
            List<String> periods = scoreLiveService.getMatchPeriods(scoreLiveMatchRequest);
            List<String> times = matchInfoList.parallelStream().map(matchInfo -> matchInfo.getMatchTime()).collect(Collectors.toSet()).parallelStream().sorted().collect(Collectors.toList());
            List<String> leagues = matchInfoList.parallelStream().map(matchInfo -> matchInfo.getLeagueName()).collect(Collectors.toSet()).parallelStream().sorted().collect(Collectors.toList());
            ModelAndView mav = new ModelAndView("scorelive");
            mav.addObject("periods", periods);
            mav.addObject("times", times);
            mav.addObject("leagues", leagues);
            mav.addObject("matchInfos", matchInfoList);
            mav.addObject("currentPeriod", date);
            return deferredResult.setResult(mav);
        });
        System.out.println("It takes for " + (System.currentTimeMillis() - time1) + " seconds");
        return deferredResult;
    }

//    @GetMapping("/matchs/{date}")
//    public DeferredResult<List<MatchInfo>> getMatchsByDate(@PathVariable String date) {
//        DeferredResult<List<MatchInfo>> deferredResult = new DeferredResult<>();
//        CompletableFuture.supplyAsync(() ->
//                scoreLiveService.getScoreLiveMatchResponse(scoreLiveMatchRequest)).thenApply(response -> {
//            List<MatchInfo> matchInfos = response.getData().parallelStream().filter(matchPeriod -> date.equals(matchPeriod.getPeriod())).findFirst().get().getMatchInfo();
//            return deferredResult.setResult(matchInfos);
//        });
//        return deferredResult;
//    }

    /**
     * @param hostId  主队id
     * @param matchId 比赛id
     * @param visitId 客队id
     * @param type    比赛信息类型: 10、赛事 11、战绩 12、积分 13、赔率 14、聊球
     * @Author: xuzhiqing
     * @Date: 2018/5/13 08:03
     * @Description: 获取某一场比赛的信息
     */
//    @GetMapping("/matchInfo")
//    public DeferredResult<ScoreLiveMatchInfoResponse> getMatchInfo(@RequestParam String hostId, @RequestParam String matchId, @RequestParam String visitId, @RequestParam String
//            type) {
//        DeferredResult<ScoreLiveMatchInfoResponse> deferredResult = new DeferredResult<>();
//        if (StringUtils.isBlank(hostId) || StringUtils.isBlank(matchId) || StringUtils.isBlank(visitId) || StringUtils.isBlank(type)) {
//            deferredResult.setResult(new ScoreLiveMatchInfoResponse(ResponseEnum.PARAM_ERROR));
//        }
//        Map<String, String> params = scoreLiveMatchRequest.getParams();
//        params.put("hostId", hostId);
//        params.put("matchId", matchId);
//        params.put("visitedId", visitId);
//        params.put("type", type);
//        CompletableFuture.supplyAsync(() ->
//                scoreLiveService.getScoreLiveMatchInfoResponse(scoreLiveMatchRequest)).thenApply(response -> deferredResult.setResult(response));
//        return deferredResult;
//    }
    @GetMapping("/matchInfo")
    public String getMatchInfo(@RequestParam String hostId, @RequestParam String matchId, @RequestParam String visitId, @RequestParam String
            type) {
        if (StringUtils.isBlank(hostId) || StringUtils.isBlank(matchId) || StringUtils.isBlank(visitId) || StringUtils.isBlank(type)) {
            return JSON.toJSONString(ResponseEnum.PARAM_ERROR);
        }
        Map<String, String> params = matchAnalysisRequest.getParams();
        params.put("hostId", hostId);
        params.put("matchId", matchId);
        params.put("visitId", visitId);
        params.put("type", type);
        return scoreLiveService.getScoreLiveMatchInfoResponseJson(matchAnalysisRequest);
    }

}
