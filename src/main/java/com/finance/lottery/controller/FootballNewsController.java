package com.finance.lottery.controller;

import com.finance.lottery.entity.news.FootballNews;
import com.finance.lottery.request.FootballNewsRequest;
import com.finance.lottery.service.FootballNewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/17 23:00
 * @Description:    每日球报
 */
@RestController
@RequestMapping("/football/news")
public class FootballNewsController {

    @Autowired
    private FootballNewsRequest footballNewsRequest;

    @Autowired
    private FootballNewsService footballNewsService;

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
        ModelAndView mav = new ModelAndView("footballnews");
        DeferredResult<ModelAndView> result = new DeferredResult<>();
        List<FootballNews> footballNews = footballNewsService.getFootballNews(footballNewsRequest);
        mav.addObject("footballNews", footballNews);
        result.setResult(mav);
        return result;
    }

    @GetMapping("/detail")
    public DeferredResult<String> getNewsDetail(@RequestParam String url) {
        DeferredResult<String> result = new DeferredResult<>();
        if (url.startsWith("https://")) {
            url = url.replaceFirst("https", "http");
        }
        String newsDetail = footballNewsService.getFootballNewsDetail(url);
        result.setResult(newsDetail);
        return result;
    }
}
