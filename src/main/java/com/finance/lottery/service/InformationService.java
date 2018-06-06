package com.finance.lottery.service;

import com.finance.lottery.entity.netease.MatchTeamInfo;
import com.finance.lottery.request.InformationDetailRequest;
import com.finance.lottery.request.InformationRequest;
import com.finance.lottery.util.HttpUtil;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/13 10:33
 * @Description:
 */
@Service
public class InformationService {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private InformationRequest informationRequest;

    @Autowired
    private InformationDetailRequest informationDetailRequest;

//    public InformationResponse getInformationResponse(InformationRequest request) {
//        String responseJson = restTemplate.getForObject(request.getUrl(), String.class, request.getParams());
//        JSONObject jsonObject = (JSONObject) JSONPath.read(responseJson, request.getInfoJsonPath());
//        if (jsonObject == null) {
//            return new InformationResponse(ResponseEnum.DATA_ERROR);
//        }
//        MatchDetail matchDetail = JSON.parseObject(JSON.toJSONString(jsonObject), MatchDetail.class);
//        return new InformationResponse(ResponseEnum.SUCCESS, matchDetail);
//    }
//
//    public String getInformationResponseJson(InformationRequest request) {
//        String responseJson = restTemplate.getForObject(request.getUrl(), String.class, request.getParams());
//        JSONObject jsonObject = (JSONObject) JSONPath.read(responseJson, request.getInfoJsonPath());
//        if (jsonObject == null) {
//            return JSON.toJSONString(new InformationResponse(ResponseEnum.DATA_ERROR));
//        }
//        responseJson = JSON.toJSONString(jsonObject);
//        return responseJson;
//    }

    public String getInformation(MatchTeamInfo matchTeamInfo) {

        String matchOrder = matchTeamInfo.getMatchOrder();
        String matchDayPart = matchTeamInfo.getMatchDayPart();
        String matchTime = matchTeamInfo.getMatchTime();
        String matchCode = matchTeamInfo.getMatchCode();
        Elements elements = new Elements();
        for (int i = 1; ; i++) {
            String page;
            if (i < 10) {
                page = "0-" + String.valueOf(i);
            } else {
                StringBuffer sb = new StringBuffer(String.valueOf(i));
                sb.insert(1, "-");
                page = sb.toString();
            }
            String url = String.format(informationRequest.getUrl(), matchCode, page);
//            String responseHtml = restTemplate.getForObject(url, String.class);
            String responseHtml = HttpUtil.get(url);
            if (responseHtml == null) {
                break;
            }
            Document document = Jsoup.parse(responseHtml);
            Elements elementList = document.select(informationRequest.getCssPath());
            elements.addAll(elementList);
            if (elementList.size() < 10) {
                break;
            }
        }
        Optional<Element> optionalElement = elements.parallelStream().filter(element -> {
            String timestamp = element.selectFirst(".timestamp").text();
            if (timestamp.contains(matchOrder) && timestamp.contains(matchDayPart) && timestamp.contains(matchTime)) {
                return true;
            } else {
                return false;
            }
        }).findFirst();
        if (optionalElement.isPresent()) {
            String href = optionalElement.get().attr("href");
            return getInformationDetail(href);
        }
        return null;
    }

    public String getInformationDetail(String href) {
        String url = String.format(informationDetailRequest.getUrl(), href);
        String responseHtml = HttpUtil.get(url);
        if (responseHtml == null) {
            return null;
        }
        Document document = Jsoup.parse(responseHtml);
        Element element = document.selectFirst(informationDetailRequest.getCssPath());
        if (element != null) {
            return element.toString();
        }
        return null;
    }
}
