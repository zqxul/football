package com.finance.lottery.service;

import com.finance.lottery.entity.RecommendScatter;
import com.finance.lottery.entity.zqmf.Recommend;
import com.finance.lottery.mapper.AchievementMapper;
import com.finance.lottery.mapper.RecommendMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

/**
 * ClassName: AchievementService
 * Description:
 *
 * @Author xuzhiqing
 * @Date 2018/7/2 at 14:01
 * @Version 1.0
 **/
@Service
public class AchievementService {
    final static int BASE = 30;

    @Autowired
    private AchievementMapper achievementMapper;

    @Autowired
    private RecommendMapper recommendMapper;

    public List<Integer> estimateStatus(Integer userId) {
        List<Recommend> recommends = achievementMapper.selectLastSeven(userId);
        if (recommends == null || recommends.size() == 0) {
            return Arrays.asList(BASE, BASE, BASE);
        }
        List<Recommend> euroRecommends = recommends.stream().filter(recommend -> recommend.getType() == 1).collect(Collectors.toList());
        List<Recommend> asiaRecommends = recommends.stream().filter(recommend -> recommend.getType() == 2).collect(Collectors.toList());
        List<Recommend> sizeRecommends = recommends.stream().filter(recommend -> recommend.getType() == 3).collect(Collectors.toList());
        long euroWinCount = recommends.stream().filter(recommend -> recommend.getMatchResult().intValue() == 2).count();
        long asiaWinCount = recommends.stream().filter(recommend -> recommend.getMatchResult().intValue() == 2).count();
        long sizeWinCount = recommends.stream().filter(recommend -> recommend.getMatchResult().intValue() == 2).count();
        int euro = BASE, asia = BASE, size = BASE;
        if (euroWinCount != 0 && euroRecommends.size() > 0) {
            euro = ((int) euroWinCount) * 100 / euroRecommends.size();
        }
        if (asiaWinCount != 0 && asiaRecommends.size() > 0) {
            asia = ((int) asiaWinCount) * 100 / asiaRecommends.size();
        }
        if (sizeWinCount != 0 && sizeRecommends.size() > 0) {
            size = ((int) sizeWinCount) * 100 / sizeRecommends.size();
        }
        return Arrays.asList(euro, asia, size);
    }

    public Integer estimateExperience(Integer userId) {
        Date startTime = achievementMapper.selectRecommendStartTime(userId);
        Date endTime = achievementMapper.selectRecommendEndTime(userId);
        int days = (int) ((startTime.getTime() - endTime.getTime()) / (1000 * 60 * 60 * 24));
        return days * 100 / (365 * 5);
    }

    public List<Integer> estimatePopularity(Integer userId) {
        int euroRecommendPayTotalCount = achievementMapper.selectNearlyRecommendPayCountByRecommendType(1);
        int asiaRecommendPayTotalCount = achievementMapper.selectNearlyRecommendPayCountByRecommendType(2);
        int sizeRecommendPayTotalCount = achievementMapper.selectNearlyRecommendPayCountByRecommendType(3);
        int euroRecommendPayCount = achievementMapper.selectNearlyRecommendPayCountByUserIdAndRecommendType(userId, 1);
        int asiaRecommendPayCount = achievementMapper.selectNearlyRecommendPayCountByUserIdAndRecommendType(userId, 2);
        int sizeRecommendPayCount = achievementMapper.selectNearlyRecommendPayCountByUserIdAndRecommendType(userId, 3);
        int euro = BASE, asia = BASE, size = BASE;
        if (euroRecommendPayTotalCount != 0 && euroRecommendPayCount != 0) {
            euro = (euroRecommendPayCount * 100) / euroRecommendPayTotalCount;
        }
        if (asiaRecommendPayTotalCount != 0 && asiaRecommendPayCount != 0) {
            asia = (asiaRecommendPayCount * 100) / asiaRecommendPayTotalCount;
        }
        if (sizeRecommendPayTotalCount != 0 && sizeRecommendPayCount != 0) {
            size = (sizeRecommendPayCount * 100) / sizeRecommendPayTotalCount;
        }
        return Arrays.asList(euro, asia, size);
    }

    public List<Integer> estimateAbility(Integer userId) {
        Integer euroWinCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(userId).matchResult(2).type(1).build());
        Integer asiaWinCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(userId).matchResult(2).type(2).build());
        Integer sizeWinCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(userId).matchResult(2).type(3).build());
        Integer euroTotalCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(userId).type(1).build());
        Integer asiaTotalCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(userId).type(2).build());
        Integer sizeTotalCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(userId).type(3).build());
        int euro = BASE, asia = BASE, size = BASE;
        if (euroWinCount != 0 && euroTotalCount != 0) {
            euro = euroWinCount * 100 / euroTotalCount;
        }
        if (asiaWinCount != 0 && asiaTotalCount != 0) {
            euro = asiaWinCount * 100 / asiaTotalCount;
        }
        if (sizeWinCount != 0 && sizeTotalCount != 0) {
            euro = sizeWinCount * 100 / sizeTotalCount;
        }
        return Arrays.asList(euro, asia, size);
    }

    public List<Integer> estimateStability(Integer userId) {
        List<Recommend> euroRecommends = achievementMapper.selectLastTenByRecommendType(userId, 1);
        List<Recommend> asiaRecommends = achievementMapper.selectLastTenByRecommendType(userId, 2);
        List<Recommend> sizeRecommends = achievementMapper.selectLastTenByRecommendType(userId, 3);
        int euroLoseCount = (int) euroRecommends.stream().filter(recommend -> recommend.getMatchResult().intValue() == 1).count();
        int asiaLoseCount = (int) asiaRecommends.stream().filter(recommend -> recommend.getMatchResult().intValue() == 1).count();
        int sizeLoseCount = (int) asiaRecommends.stream().filter(recommend -> recommend.getMatchResult().intValue() == 1).count();
        int euro = BASE, asia = BASE, size = BASE;
        if (euroRecommends.size() != 0 && euroLoseCount != 0) {
            euro = euroLoseCount * 100 / euroRecommends.size();
        }
        if (asiaRecommends.size() != 0 && asiaLoseCount != 0) {
            asia = asiaLoseCount * 100 / asiaRecommends.size();
        }
        if (sizeRecommends.size() != 0 && sizeLoseCount != 0) {
            size = sizeLoseCount * 100 / sizeRecommends.size();
        }
        return Arrays.asList(euro, asia, size);
    }

    public List<RecommendScatter> countLeagues(Integer userId) {
        List<RecommendScatter> recommendScatters = new ArrayList<>();
        List<Recommend> recommends = recommendMapper.select(Recommend.builder().userId(userId).build());
        Set<String> leagues = recommends.stream().map(recommend -> recommend.getLeagueName()).collect(Collectors.toSet());
        leagues.stream().forEach(leagueName -> {
            int count = (int) recommends.stream().filter(recommend -> recommend.getLeagueName().equals(leagueName)).count();
            recommendScatters.add(RecommendScatter.builder().name(leagueName).count(count).build());
        });
        return recommendScatters;
    }

    public List<Integer> countResult(Integer userId, String leagueName) {

        return null;
    }

    public List<Recommend> getRecommends(Integer userId) {
        List<Recommend> recommends = recommendMapper.select(Recommend.builder().userId(userId).build());
        return recommends;
    }

}
