package com.finance.lottery.service;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPath;
import com.finance.lottery.entity.StaticVisit;
import com.finance.lottery.entity.zqmf.Recommend;
import com.finance.lottery.entity.zqmf.RecommendMatchDetail;
import com.finance.lottery.mapper.RecommendMapper;
import com.finance.lottery.mapper.StaticVisitMapper;
import com.finance.lottery.properties.BackgroundProperties;
import com.finance.lottery.request.RecommendResultRequest;
import com.finance.lottery.util.HttpUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

/**
 * @Author: xuzhiqing
 * @Description: 定时任务服务类
 * @Date: 2018/6/5 17:12
 */
@Service
public class ScheduleService {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private BackgroundProperties backgroundProperties;

    @Autowired
    private StaticVisitMapper staticVisitMapper;

    @Autowired
    private RecommendMapper recommendMapper;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private RecommendResultRequest recommendResultRequest;

    public void saveAndResetDailyVisitCount() {
        String totalVisitCount = backgroundProperties.getCountVisitTotal();
        String footballNewsVisitCount = backgroundProperties.getCountVisitFootballNews();
        String matchAnalysisVisitCount = backgroundProperties.getCountVisitMatchAnalysis();
        String scoreLiveVisitCount = backgroundProperties.getCountVisitScoreLive();
        String bigDataVisitCount = backgroundProperties.getCountBigData();

        System.out.println("DailyVisitCount Save Start,CurrentTime:" + Calendar.getInstance().getTime());
        StaticVisit footballNewsVisit = StaticVisit.builder().visitUrl("/football/news/list").visitCount(Integer.valueOf(stringRedisTemplate.opsForValue().get(footballNewsVisitCount))).createTime(Calendar.getInstance().getTime()).build();
        StaticVisit matchAnalysisVisit = StaticVisit.builder().visitUrl("/analysis/info").visitCount(Integer.valueOf(stringRedisTemplate.opsForValue().get(matchAnalysisVisitCount))).createTime(Calendar.getInstance().getTime()).build();
        StaticVisit scoreLiveVisit = StaticVisit.builder().visitUrl("/live/matchs/lastest").visitCount(Integer.valueOf(stringRedisTemplate.opsForValue().get(scoreLiveVisitCount))).createTime(Calendar.getInstance().getTime()).build();
        StaticVisit bigDataVisit = StaticVisit.builder().visitUrl("/data").visitCount(Integer.valueOf(stringRedisTemplate.opsForValue().get(bigDataVisitCount))).createTime(Calendar.getInstance().getTime()).build();
        staticVisitMapper.insert(footballNewsVisit);
        staticVisitMapper.insert(matchAnalysisVisit);
        staticVisitMapper.insert(scoreLiveVisit);
        staticVisitMapper.insert(bigDataVisit);
        System.out.println("DailyVisitCount Save Complete");

        System.out.println("DailyVisitCount Reset Start,CurrentTime:" + Calendar.getInstance().getTime());
        stringRedisTemplate.opsForValue().set(totalVisitCount, "0");
        stringRedisTemplate.opsForValue().set(footballNewsVisitCount, "0");
        stringRedisTemplate.opsForValue().set(matchAnalysisVisitCount, "0");
        stringRedisTemplate.opsForValue().set(scoreLiveVisitCount, "0");
        stringRedisTemplate.opsForValue().set(bigDataVisitCount, "0");
        System.out.println("DailyVisitCount Reset Complete");
    }

    public void UpdateRecommendResult() {
        String url = recommendResultRequest.getUrl();
        String dataTemplate = recommendResultRequest.getParams().get("data");
        String sign = recommendResultRequest.getParams().get("sign");
        List<Recommend> recommends = recommendMapper.selectRecommendNoMatchResult();
        //TODO 根据matchId获取比赛结果(比赛状态，比分信息)，并更新推荐结果
        recommends.stream().forEach(recommend -> {
            String matchId = recommend.getMatchId();
            String data = String.format(dataTemplate, matchId);
            HashMap dataMap = new HashMap();
            dataMap.put("data", data);
            dataMap.put("sign", sign);
            String responseJson = restTemplate.getForObject(url, String.class, dataMap);
            if (responseJson == null||responseJson.contains("{\"msg_code\":\"0011\"")) {
                return;
            }
            JSONObject jsonObject = (JSONObject) JSONPath.read(responseJson, "$.data.match");
            if (jsonObject == null) {
                return;
            }
            String status = jsonObject.getString("status");//1、未开赛，2、已完场 3、进行中
            if ("2".equals(status)) {
                Integer result = null;//1、输，2、赢，3、走
                int recommendType = recommend.getType();
                int recommendValue = recommend.getValue();
                String score = jsonObject.getString("score");
                String[] scores = score.split(":");
                double value = Double.valueOf(scores[0]) - Double.valueOf(scores[1]);
                double total = Double.valueOf(scores[0]) - Double.valueOf(scores[1]);
                if (1 == recommendType) {
                    if ((value > 0 && recommendValue == 1) || (value < 0 && recommendValue == 2) || (value == 0 && recommendValue == 2)) {
                        result = 2;
                    } else {
                        result = 1;
                    }
                } else if (2 == recommendType) {
                    String handicapValueStr = recommend.getHandicapValue();
                    double handValue = 0d;
                    if (handicapValueStr.contains("/")) {
                        String[] hands = handicapValueStr.split("/");
                        handValue = (Double.valueOf(hands[0]) + Double.valueOf(hands[1])) / 2;
                    } else {
                        handValue = Double.valueOf(handicapValueStr);
                    }
                    if (value - handValue > 0) {
                        result = 1;
                    } else if (value - result < 0) {
                        result = 2;
                    } else {
                        result = 3;
                    }
                } else {
                    double handValue = Double.valueOf(recommend.getHandicapValue());
                    if (total < handValue) {
                        result = 1;
                    } else if (total > handValue) {
                        result = 2;
                    } else {
                        result = 3;
                    }
                }
                int updateResult = recommendMapper.updateMatchResult(recommend.getId(), result);

            }

        });
        System.out.println("update recommend result");
    }
}
