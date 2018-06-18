package com.finance.lottery.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPath;
import com.finance.lottery.entity.user.User;
import com.finance.lottery.entity.zqmf.*;
import com.finance.lottery.request.MatchRequest;
import com.finance.lottery.request.RecommendDetailRequest;
import com.finance.lottery.request.RecommendMatchRequest;
import com.finance.lottery.result.FootballResult;
import com.finance.lottery.result.ResponseEnum;
import com.finance.lottery.service.RecommendService;
import com.finance.lottery.service.ScoreLiveService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.net.*;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/7 11:27
 */
@RestController
@RequestMapping("/recommend")
public class RecommendController {
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;
    @Autowired
    private MatchRequest matchRequest;
    @Autowired
    private ScoreLiveService scoreLiveService;
    @Autowired
    private RecommendMatchRequest recommendMatchRequest;
    @Autowired
    private RecommendDetailRequest recommendDetailRequest;
    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private RecommendService recommendService;

    @GetMapping("/")
    public ModelAndView getRecommend() {
        ModelAndView mav = new ModelAndView("recommend");
        String recommendsKey = "lottery_recommends";
        List<Recommend> recommends = (List<Recommend>) redisTemplate.opsForValue().get(recommendsKey);
        if (recommends != null) {
            List<String> leagues = recommends.parallelStream().map(recommend -> recommend.getLeagueName()).collect(Collectors.toSet()).stream().collect(Collectors.toList());
            List<String> authors = recommends.parallelStream().map(recommend -> recommend.getCreateBy()).collect(Collectors.toSet()).stream().collect(Collectors.toList());
            mav.addObject("leagues", leagues);
            mav.addObject("authors", authors);
            mav.addObject("recommends", recommends);
            return mav;
        }
        recommends = recommendService.getRecommendList();
        if (recommends != null && recommends.size() > 0) {
            redisTemplate.opsForValue().set(recommendsKey, recommends, 3, TimeUnit.MINUTES);
        } else {
            redisTemplate.opsForValue().set(recommendsKey, new ArrayList<>(), 1, TimeUnit.MINUTES);
        }
        List<String> leagues = recommends.parallelStream().map(recommend -> recommend.getLeagueName()).collect(Collectors.toSet()).stream().collect(Collectors.toList());
        List<String> authors = recommends.parallelStream().map(recommend -> recommend.getCreateBy()).collect(Collectors.toSet()).stream().collect(Collectors.toList());
        mav.addObject("leagues", leagues);
        mav.addObject("authors", authors);
        mav.addObject("recommends", recommends);
        return mav;
    }

    @GetMapping("/leagues")
    public DeferredResult<List<String>> getLeagueList() {
        DeferredResult<List<String>> result = new DeferredResult<>();
        String recommendLeaguesKey = "lottery_recommend_leagues";
        List<String> leagues = (List<String>) redisTemplate.opsForValue().get(recommendLeaguesKey);
        if (leagues != null) {
            result.setResult(leagues);
            return result;
        }
        List<RecommendMatchInfo> recommendMatchInfos = recommendService.getRecommendMatchList();
        leagues = recommendMatchInfos.parallelStream().map(recommendMatchInfo -> recommendMatchInfo.getLeague_name()).collect(Collectors.toSet()).stream().collect(Collectors.toList());
        if (leagues != null && leagues.size() > 0) {
            redisTemplate.opsForValue().set(recommendLeaguesKey, leagues, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(recommendLeaguesKey, new ArrayList<>(), 3, TimeUnit.MINUTES);
        }
        result.setResult(leagues);
        return result;
    }

    @GetMapping("/matchs")
    public DeferredResult<List<RecommendMatchInfo>> getMatchList() {
        DeferredResult<List<RecommendMatchInfo>> result = new DeferredResult<>();
        String recommendMatchsKey = "lottery_recommend_matchs";
        List<RecommendMatchInfo> recommendMatchInfos = (List<RecommendMatchInfo>) redisTemplate.opsForValue().get(recommendMatchsKey);
        if (recommendMatchInfos != null) {
            result.setResult(recommendMatchInfos);
            return result;
        }
        recommendMatchInfos = recommendService.getRecommendMatchs();
        if (recommendMatchInfos != null && recommendMatchInfos.size() > 0) {
            redisTemplate.opsForValue().set(recommendMatchsKey, recommendMatchInfos, 3, TimeUnit.MINUTES);
        } else {
            redisTemplate.opsForValue().set(recommendMatchsKey, new ArrayList<>(), 1, TimeUnit.MINUTES);
        }
        result.setResult(recommendMatchInfos);
        return result;
    }

    @GetMapping("/detail")
    public DeferredResult<RecommendMatchDetail> getRecommendList(String matchId) {
        DeferredResult<RecommendMatchDetail> result = new DeferredResult<>();
        String recommendDetailKey = "lottery_recommend_detail_" + matchId;
        RecommendMatchDetail recommendMatchDetail = (RecommendMatchDetail) redisTemplate.opsForValue().get(recommendDetailKey);
        if (recommendMatchDetail != null) {
            result.setResult(recommendMatchDetail);
            return result;
        }
        String data = recommendDetailRequest.getParams().get("data");
        Map<String, String> dataMap = new HashMap<>();
        dataMap.put("data", String.format(data, matchId));
        dataMap.put("sign", recommendDetailRequest.getParams().get("sign"));
        String url = recommendDetailRequest.getUrl();
        String responseJson = restTemplate.getForObject(url, String.class, dataMap);
        JSONObject jsonObject = (JSONObject) JSONPath.read(responseJson, "$.data.odds");
        if (jsonObject == null) {
            result.setResult(new RecommendMatchDetail());
            return result;
        }
        recommendMatchDetail = jsonObject.toJavaObject(RecommendMatchDetail.class);
        if (recommendMatchDetail != null) {
            redisTemplate.opsForValue().set(recommendDetailKey, recommendMatchDetail, 3, TimeUnit.MINUTES);
        } else {
            redisTemplate.opsForValue().set(recommendDetailKey, new RecommendMatchDetail(), 1, TimeUnit.MINUTES);
        }
        result.setResult(recommendMatchDetail);
        return result;
    }

    @GetMapping("/deploy")
    public DeferredResult<FootballResult> deployRecommend(RecommendDetail recommendDetail) {
        DeferredResult<FootballResult> result = new DeferredResult<>();
        FootballResult footballResult = new FootballResult();
        if(StringUtils.isBlank(recommendDetail.getMatchId())){
            footballResult.setResult(ResponseEnum.RECOMMEND_MATCH_NULL);
            result.setResult(footballResult);
            return result;
        }

        if (StringUtils.isBlank(recommendDetail.getRecommendValue())) {
            footballResult.setResult(ResponseEnum.RECOMMEND_ODD_NULL);
            result.setResult(footballResult);
            return result;
        }
        if (StringUtils.isBlank(recommendDetail.getMatchId())) {
            footballResult.setResult(ResponseEnum.RECOMMEND_MATCH_NULL);
            result.setResult(footballResult);
            return result;
        }
        String price = recommendDetail.getRecommendPrice();
        if (price != null && !price.matches("\\d{1,3}")) {
            footballResult.setResult(ResponseEnum.DATA_FORMAT_ERROR);
            result.setResult(footballResult);
            return result;
        }

        Recommend recommend = new Recommend(recommendDetail);
        recommend.setCreateTime(Calendar.getInstance().getTime());
        if (!recommendService.saveRecommend(recommend)) {
            footballResult.setResult(ResponseEnum.INTERNAL_ERROR);
            result.setResult(footballResult);
            return result;
        }
        String recommendsKey = "lottery_recommends";
        redisTemplate.delete(recommendsKey);
        footballResult.setResult(ResponseEnum.SUCCESS);
        result.setResult(footballResult);
        return result;
    }

    @GetMapping("/hostman")
    public DeferredResult<List<HotMan>> getHotManList() {
        DeferredResult<List<HotMan>> result = new DeferredResult<>();
        //TODO
        List<HotMan> hotMans = recommendService.getHotMans();
        result.setResult(hotMans);
        return result;
    }
}

