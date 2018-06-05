package com.finance.lottery.service;

import com.alibaba.fastjson.JSON;
import com.finance.lottery.entity.netease.MatchInfo;
import com.finance.lottery.request.MatchAnalysisRequest;
import com.finance.lottery.request.MatchRequest;
import com.finance.lottery.request.ScoreLiveMatchRequest;
import com.finance.lottery.response.ScoreLiveMatchInfoResponse;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/13 08:20
 * @Description:
 */
@Service
public class ScoreLiveService {

    @Autowired
    private RestTemplate restTemplate;

    /**
     * @param request 封装了Rest风格的请求url和参数信息的对象
     * @Author: xuzhiqing
     * @Date: 2018/5/13 09:11
     * @Description:
     */
    public List<MatchInfo> getScoreLiveMatchs(ScoreLiveMatchRequest request) {
        String responseText = restTemplate.getForObject(request.getUrl(), String.class);
        Document document = Jsoup.parse(responseText);
        Elements elements = document.selectFirst("#gameList").children();
        List<MatchInfo> matchInfos = new ArrayList<>();
        elements.parallelStream().forEach(e -> {
            String hostRedCard = e.attr("hostredcard");
            String visitredcard = e.attr("visitredcard");
            String hostYellowCard = e.attr("hostyellowcard");
            String visitYellowCard = e.attr("visityellowcard");
            String score = e.attr("score");
            String halfScore = e.attr("halfscore");
            String bidScore = e.attr("bidscore");
            String statusDesc = e.attr("statusdesc");
            String matchStatus = e.attr("matchstatus");
            Element matchDetail = e.selectFirst(".matcheDetail");
            String period = matchDetail.selectFirst(".period").text();
            String events = matchDetail.selectFirst(".events a").text();
            String eventStyle = matchDetail.selectFirst(".events").attr("style");
            String playTime = matchDetail.selectFirst(".playTime").text();
            String concede = e.selectFirst(".concede").text();
            String round = matchDetail.selectFirst(".round").text();
            Element vsDetail = e.selectFirst(".vsDetail");
            String hostName = vsDetail.selectFirst(".host a").ownText();
            String hostLogo = "http://pimg1.126.net/caipiao_info/img/library/t24no.png";
            Element hostTeamLogo = vsDetail.selectFirst(".host .teamLogo img");
            if (hostTeamLogo != null) {
                hostLogo = hostTeamLogo.attr("src");
            }
            String guestName = vsDetail.selectFirst(".guest a").ownText();
            String guestLogo = "http://pimg1.126.net/caipiao_info/img/library/t24no.png";
            Element guestTeamLogo = vsDetail.selectFirst(".guest .teamLogo img");
            if (guestTeamLogo != null) {
                guestLogo = guestTeamLogo.attr("src");
            }
            matchInfos.add(new MatchInfo(period, eventStyle, events, playTime, round, hostRedCard, hostYellowCard, hostName, hostLogo, score, guestLogo, guestName, visitYellowCard, visitredcard, statusDesc, matchStatus, halfScore, bidScore, concede));
        });
        return matchInfos;
    }

    public List<MatchInfo> getScoreLiveMatchsByDate(ScoreLiveMatchRequest request, String date) {
        String responseText = restTemplate.getForObject(request.getUrl() + "/jcbf/?date=" + date, String.class);
        Document document = Jsoup.parse(responseText);
        Elements elements = document.selectFirst("#gameList").children();
        List<MatchInfo> matchInfos = new ArrayList<>();
        elements.parallelStream().forEach(e -> {
            String hostRedCard = e.attr("hostredcard");
            String visitredcard = e.attr("visitredcard");
            String hostYellowCard = e.attr("hostyellowcard");
            String visitYellowCard = e.attr("visityellowcard");
            String score = e.attr("score");
            String[] goals = score.split(":");
            int hostGoals = 0;
            int guestGoals = 0;
            if (goals.length == 2) {
                hostGoals = Integer.valueOf(goals[0]);
                guestGoals = Integer.valueOf(goals[1]);
            }
            String halfScore = e.attr("halfscore");
            String bidScore = e.attr("bidscore");
            String statusDesc = e.attr("statusdesc");
            String matchStatus = e.attr("matchstatus");
            Element matchDetail = e.selectFirst(".matcheDetail");
            String period = matchDetail.selectFirst(".period").text();
            String events = matchDetail.selectFirst(".events a").text();
            String eventStyle = matchDetail.selectFirst(".events").attr("style");
            String playTime = matchDetail.selectFirst(".playTime").text();
            String concede = e.selectFirst(".concede").text();
            String round = matchDetail.selectFirst(".round").text();
            Element vsDetail = e.selectFirst(".vsDetail");
            String hostName = vsDetail.selectFirst(".host a").ownText();
            String hostLogo = "http://pimg1.126.net/caipiao_info/img/library/t24no.png";
            Element hostTeamLogo = vsDetail.selectFirst(".host .teamLogo img");
            if (hostTeamLogo != null) {
                hostLogo = hostTeamLogo.attr("src");
            }
            String guestName = vsDetail.selectFirst(".guest a").ownText();
            String guestLogo = "http://pimg1.126.net/caipiao_info/img/library/t24no.png";
            Element guestTeamLogo = vsDetail.selectFirst(".guest .teamLogo img");
            if (guestTeamLogo != null) {
                guestLogo = guestTeamLogo.attr("src");
            }
            matchInfos.add(new MatchInfo(period, eventStyle, events, playTime, round, hostRedCard, hostYellowCard, hostName, hostLogo, score, guestLogo, guestName, visitYellowCard, visitredcard, statusDesc, matchStatus, halfScore, bidScore, concede));
        });
        return matchInfos;
    }

    public List<String> getMatchPeriods(ScoreLiveMatchRequest request) {
        String responseText = restTemplate.getForObject(request.getUrl(), String.class);
        Document document = Jsoup.parse(responseText);
        Elements elements = document.select("#selectDate .optionList a");
        List<String> periods = elements.stream().map(element -> element.text()).collect(Collectors.toList());
        return periods;
    }

    public ScoreLiveMatchInfoResponse getScoreLiveMatchInfoResponse(MatchAnalysisRequest request) {
        String responseJson = restTemplate.getForObject(request.getUrl(), String.class, request.getParams());
        return JSON.parseObject(responseJson, ScoreLiveMatchInfoResponse.class);
    }

    public String getScoreLiveMatchInfoResponseJson(MatchAnalysisRequest request) {
        return restTemplate.getForObject(request.getUrl(), String.class, request.getParams());
    }

    public String getScoreLiveMatchOddInfoResponseJson(MatchAnalysisRequest request) {
        return restTemplate.getForObject(request.getOddUrl(), String.class, request.getParams());
    }

    public String getMatchsResponseJson(MatchRequest request) {
        return restTemplate.getForObject(request.getUrl(), String.class, request.getParams());
    }
}
