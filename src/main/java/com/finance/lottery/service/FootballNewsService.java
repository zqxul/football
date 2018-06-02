package com.finance.lottery.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONPath;
import com.finance.lottery.entity.news.FootballNews;
import com.finance.lottery.request.FootballNewsRequest;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/17 23:04
 * @Description:    每日球报Service
 */
@Service
public class FootballNewsService {

    @Autowired
    private RestTemplate restTemplate;

    public List<FootballNews> getFootballNews(FootballNewsRequest request) {
        List<FootballNews> footballNews = new ArrayList<>();
        String responseJson = restTemplate.getForObject(request.getUrl(), String.class);
        JSONArray articlesJsonArray = (JSONArray) JSONPath.read(responseJson, "$.articles");
        if (articlesJsonArray != null) {
            footballNews = articlesJsonArray.toJavaList(FootballNews.class);
        }
        return footballNews;
    }

    public String getFootballNewsDetail(String url){
        String detailXmlPath = "article .con";
        String responseText = restTemplate.getForObject(url,String.class);
        Document document = Jsoup.parse(responseText);
        Element element = document.selectFirst(detailXmlPath);
        if(element!=null){
            return element.html();
        }
        return "";
    }
}
