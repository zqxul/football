package com.finance.lottery.service;

import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPath;
import com.finance.lottery.entity.netease.MatchTeamInfo;
import com.finance.lottery.request.BFIndexRequest;
import com.finance.lottery.util.HttpUtil;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/1 22:03
 */
@Service
public class BFIndexService {

    @Autowired
    private BFIndexRequest bfIndexRequest;

    public List<String> getBFIndex(MatchTeamInfo matchTeamInfo) {
        String matchCode = matchTeamInfo.getMatchCode().replaceAll("-", "");
        String matchOrder = matchTeamInfo.getMatchOrder();
        String url = String.format(bfIndexRequest.getUrl(), matchCode);
        String responseJson = HttpUtil.get(url);
        if (responseJson == null) {
            return null;
        }
        JSONObject jsonObject = JSONObject.parseObject(responseJson);
        if (jsonObject == null) {
            return null;
        }
        String result = jsonObject.get("result").toString();
        String status = jsonObject.get("status").toString();
        if (StringUtils.isBlank(result) || "fail".equals(status)) {
            return null;
        }
        String responseHtml = (String) JSONPath.read(responseJson, "$.result.bf_page");
        Document document = Jsoup.parse(responseHtml);
        Elements elements = document.select(bfIndexRequest.getCssPath());
        Optional<Element> optionalElement = elements.parallelStream().filter(element -> matchOrder.equals(element.selectFirst(".c_yellow").text())).findFirst();
        if (optionalElement.isPresent()) {
            Element element = optionalElement.get();
            Element oddElement = element.selectFirst(".data_table");
            Element totalDealElement = element.getElementById("jq_cj_" + matchOrder);
            Element bigDealElement = element.getElementById("jq_big_" + matchOrder);
            List<String> elementList = new ArrayList<>();
            elementList.add(oddElement.toString());
            elementList.add(totalDealElement.toString());
            elementList.add(bigDealElement.toString());
            return elementList;
        }
        return null;
    }
}
