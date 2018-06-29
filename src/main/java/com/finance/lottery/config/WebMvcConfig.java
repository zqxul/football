package com.finance.lottery.config;

import com.finance.lottery.interceptor.LoginInterceptor;
import com.finance.lottery.interceptor.LoginStatusInterceptor;
import com.finance.lottery.interceptor.VisitInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.ArrayList;
import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/26 08:45
 * @Description:
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/login").setViewName("login");
        registry.addViewController("/register").setViewName("register");
        registry.addViewController("/").setViewName("index");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor()).addPathPatterns("/account/**","/recommend/**").excludePathPatterns("/recommend/ranking/**");
        registry.addInterceptor(loginStatusInterceptor()).addPathPatterns("/**").excludePathPatterns("/user/**");
        List<String> visitPaths = new ArrayList<>();
        visitPaths.add("/football/news/list");
        visitPaths.add("/analysis/info");
        visitPaths.add("/live/matchs/lastest");
        visitPaths.add("/data");
        registry.addInterceptor(visitInterceptor()).addPathPatterns(visitPaths);
    }

    @Bean
    public LoginInterceptor loginInterceptor() {
        return new LoginInterceptor();
    }

    @Bean
    public VisitInterceptor visitInterceptor() {
        return new VisitInterceptor();
    }

    @Bean
    public LoginStatusInterceptor loginStatusInterceptor(){
        return new LoginStatusInterceptor();
    }
}
