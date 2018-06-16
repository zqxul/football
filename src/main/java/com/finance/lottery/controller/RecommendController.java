package com.finance.lottery.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPath;
import com.finance.lottery.entity.zqmf.RecommendDetail;
import com.finance.lottery.entity.zqmf.RecommendMatchDetail;
import com.finance.lottery.entity.zqmf.RecommendMatchInfo;
import com.finance.lottery.request.MatchRequest;
import com.finance.lottery.request.RecommendDetailRequest;
import com.finance.lottery.request.RecommendMatchRequest;
import com.finance.lottery.service.RecommendService;
import com.finance.lottery.service.ScoreLiveService;
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
        List<RecommendMatchInfo> recommendMatchInfos = recommendService.getRecommendMatchList();
        List<String> leagues = recommendMatchInfos.parallelStream().map(recommendMatchInfo -> recommendMatchInfo.getLeague_name()).collect(Collectors.toSet()).stream().collect(Collectors.toList());
        mav.addObject("leagues",leagues);
        mav.addObject("recommendMatchInfos",recommendMatchInfos);
        return mav;
    }

    @GetMapping("/leagues")
    public DeferredResult<List<String>> getLeagueList() {
        DeferredResult<List<String>> result = new DeferredResult<>();
        List<RecommendMatchInfo> recommendMatchInfos = recommendService.getRecommendMatchList();
        List<String> leagues = recommendMatchInfos.parallelStream().map(recommendMatchInfo -> recommendMatchInfo.getLeague_name()).collect(Collectors.toSet()).stream().collect(Collectors.toList());
        result.setResult(leagues);
        return result;
    }

    @GetMapping("/matchs")
    public DeferredResult<List<RecommendMatchInfo>> getMatchList(String pageNo) {
        DeferredResult<List<RecommendMatchInfo>> result = new DeferredResult<>();
        List<RecommendMatchInfo> recommendMatchInfos = new ArrayList<>();
        String data = recommendMatchRequest.getParams().get("data");
        for (int i = 1; ; i++) {
            Map<String, String> dataMap = new HashMap<>();
            dataMap.put("sign", recommendMatchRequest.getParams().get("sign"));
            dataMap.put("data", String.format(data, String.valueOf(i)));
            String responseJson = restTemplate.getForObject(recommendMatchRequest.getUrl(), String.class, dataMap);
            JSONArray dataArray = (JSONArray) JSONPath.read(responseJson, "$.data");
            List<RecommendMatchInfo> recommendMatchInfoList = dataArray.toJavaList(RecommendMatchInfo.class);
            recommendMatchInfos.addAll(recommendMatchInfoList);
            if (recommendMatchInfoList.size() < 24) {
                break;
            }
        }
//        Map<String, String> dataMap = new HashMap<>();
//        dataMap.put("sign", recommendMatchRequest.getParams().get("sign"));
//        dataMap.put("data", String.format(data, page));
//        DeferredResult<List<RecommendMatchInfo>> result = new DeferredResult<>();
//        String responseJson = restTemplate.getForObject(recommendMatchRequest.getUrl(), String.class, dataMap);
//        JSONArray dataArray = (JSONArray) JSONPath.read(responseJson, "$.data");
//        List<RecommendMatchInfo> recommendMatchInfos = dataArray.toJavaList(RecommendMatchInfo.class);
        result.setResult(recommendMatchInfos);
        return result;
    }

    @GetMapping("/detail")
    public DeferredResult<RecommendMatchDetail> getRecommendList(String matchId) throws UnsupportedEncodingException, URISyntaxException, MalformedURLException {
//        matchId = "2731121";
        DeferredResult<RecommendMatchDetail> result = new DeferredResult<>();
        String data = recommendDetailRequest.getParams().get("data");
        Map<String, String> dataMap = new HashMap<>();
        dataMap.put("data", String.format(data, matchId));
        dataMap.put("sign", recommendDetailRequest.getParams().get("sign"));
        String url = recommendDetailRequest.getUrl();
        String responseJson = restTemplate.getForObject(url, String.class, dataMap);
        JSONObject jsonObject = (JSONObject) JSONPath.read(responseJson, "$.data.odds");
        RecommendMatchDetail recommendMatchDetail = jsonObject.toJavaObject(RecommendMatchDetail.class);
        result.setResult(recommendMatchDetail);
        return result;
    }

    @GetMapping("/deploy")
    public DeferredResult<String> deployRecommend(RecommendDetail recommendDetail) {
        DeferredResult<String> result = new DeferredResult<>();
        result.setResult("");
        return result;
    }
}

