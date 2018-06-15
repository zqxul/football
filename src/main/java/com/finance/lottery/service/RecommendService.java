package com.finance.lottery.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONPath;
import com.finance.lottery.entity.zqmf.RecommendMatchInfo;
import com.finance.lottery.request.RecommendDetailRequest;
import com.finance.lottery.request.RecommendMatchRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/14 15:15
 */
@Service
public class RecommendService {
    @Autowired
    private RecommendMatchRequest recommendMatchRequest;
    @Autowired
    private RecommendDetailRequest recommendDetailRequest;
    @Autowired
    private RestTemplate restTemplate;

    public List<RecommendMatchInfo> getRecommendMatchList() {
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
        return recommendMatchInfos;
    }
}
