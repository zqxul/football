package com.finance.lottery.controller;

import com.finance.lottery.entity.news.FootballNews;
import com.finance.lottery.request.FootballNewsRequest;
import com.finance.lottery.service.FootballNewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/17 23:00
 * @Description: 每日球报
 */
@RestController
@RequestMapping("/football/news")
public class FootballNewsController {

    @Autowired
    private FootballNewsRequest footballNewsRequest;

    @Autowired
    private FootballNewsService footballNewsService;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

//    @GetMapping("/news")
//    public String getFootballNews(@RequestParam(required = false, defaultValue = "0") String pageIndex, @RequestParam(required = false, defaultValue = "30") String pageSize) {
//        Map<String,String> params = footballNewsRequest.getParams();
//        params.put("pageIndex",pageIndex);
//        params.put("pageSize",pageSize);
//        footballNewsRequest.setParams(params);
//        String json = footballNewsService.getFootballNews(footballNewsRequest);
//        FootballNewsResponse response = new FootballNewsResponse();
//
//        return json;
//    }

    @GetMapping("/list")
    public DeferredResult<ModelAndView> getNewsList() {
        DeferredResult<ModelAndView> result = new DeferredResult<>();
        ModelAndView mav = new ModelAndView("footballnews");
        String listKey = "lottery_football_news_list";
        List<FootballNews> footballNews = (List<FootballNews>) redisTemplate.opsForValue().get(listKey);
        if (footballNews != null) {
            mav.addObject("footballNews", footballNews);
            result.setResult(mav);
            return result;
        }
        footballNews = footballNewsService.getFootballNews(footballNewsRequest);
        if (footballNews != null && footballNews.size() > 0) {
            redisTemplate.opsForValue().set(listKey, footballNews, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(listKey, new ArrayList<>(), 3, TimeUnit.MINUTES);
        }
        mav.addObject("footballNews", footballNews);
        result.setResult(mav);
        return result;
    }

    @GetMapping("/detail")
    public DeferredResult<String> getNewsDetail(@RequestParam String url) {
        DeferredResult<String> result = new DeferredResult<>();
        String detailKey = "lottery_analysis_detail_" + url;
        String newsDetail = stringRedisTemplate.opsForValue().get(detailKey);
        if (newsDetail != null) {
            result.setResult(newsDetail);
            return result;
        }
        if (url.startsWith("https://")) {
            url = url.replaceFirst("https", "http");
        }
        newsDetail = footballNewsService.getFootballNewsDetail(url);
        if (newsDetail != null) {
            stringRedisTemplate.opsForValue().set(detailKey, newsDetail, 3, TimeUnit.HOURS);
        } else {
            stringRedisTemplate.opsForValue().set(detailKey, newsDetail, 3, TimeUnit.MINUTES);
        }
        result.setResult(newsDetail);
        return result;
    }
}
