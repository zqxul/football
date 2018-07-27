package com.finance.lottery.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPath;
import com.finance.lottery.entity.user.Account;
import com.finance.lottery.entity.user.User;
import com.finance.lottery.entity.user.UserAccount;
import com.finance.lottery.entity.zqmf.*;
import com.finance.lottery.mapper.*;
import com.finance.lottery.request.RecommendDetailRequest;
import com.finance.lottery.request.RecommendMatchRequest;
import com.finance.lottery.vo.ReviewRecommend;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/14 15:15
 */
@Service
public class RecommendService {
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    @Autowired
    private RecommendMatchRequest recommendMatchRequest;
    @Autowired
    private RecommendDetailRequest recommendDetailRequest;
    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private RecommendMapper recommendMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private RecommendPayMapper recommendPayMapper;

    @Autowired
    private AccountMapper accountMapper;

    @Autowired
    private UserAccountMapper userAccountMapper;

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

    public boolean saveRecommend(Recommend recommend) {
        recommend.setMatchResult(0);
        if (recommendMapper.insert(recommend) > 0) {
            //TODO 保存购买记录，自己推荐的比赛，默认购买自己的，自己不用支付球币就可以查看
            if (recommendPayMapper.insert(new RecommendPay(recommend.getUserId(), recommend.getId())) > 0) {
                return true;
            }
        }
        return false;
    }

    public List<Recommend> getRecommendList(Integer userId) {
        String recommendsKey = "lottery_recommends_" + userId;
        List<Recommend> recommends = (List<Recommend>) redisTemplate.opsForValue().get(recommendsKey);
        if (recommends != null) {
            return recommends;
        }
        recommends = recommendMapper.selectAll();

        //设置里面支付过该推荐内容
        recommends.stream().forEach(recommend -> {
            if (userId.intValue() == recommend.getUserId()) {
                recommend.setPayed(true);
            } else {
                RecommendPay recommendPay = recommendPayMapper.selectOne(new RecommendPay(userId, recommend.getId()));
                if (recommendPay != null) {
                    recommend.setPayed(true);
                } else {
                    recommend.setPayed(false);
                }
            }
        });
        if (recommends != null && recommends.size() > 0) {
            redisTemplate.opsForValue().set(recommendsKey, recommends, 3, TimeUnit.MINUTES);
        } else {
            redisTemplate.opsForValue().set(recommendsKey, new ArrayList<>(), 1, TimeUnit.MINUTES);
        }
        return recommends;
    }

    public List<RecommendMatchInfo> getRecommendMatchs() {
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

    public RecommendMatchDetail getRecommendMatchDetail(String matchId) {
        String data = recommendDetailRequest.getParams().get("data");
        Map<String, String> dataMap = new HashMap<>();
        dataMap.put("data", String.format(data, matchId));
        dataMap.put("sign", recommendDetailRequest.getParams().get("sign"));
        String url = recommendDetailRequest.getUrl();
        String responseJson = restTemplate.getForObject(url, String.class, dataMap);
        JSONObject jsonObject = (JSONObject) JSONPath.read(responseJson, "$.data.odds");
        if (jsonObject == null) {
            return null;
        }
        RecommendMatchDetail recommendMatchDetail = jsonObject.toJavaObject(RecommendMatchDetail.class);
        return recommendMatchDetail;
    }

    @Transactional
    public boolean payRecommend(Integer recommendId, User user) {
        Recommend recommend = recommendMapper.selectByPrimaryKey(recommendId);
        Integer price = recommend.getPrice();
        Integer fromUserId = user.getId();
        Integer toUserId = recommend.getUserId();

        //TODO 在recommend_pay表中插入购买记录，用户间的球币余额扣减与添加
        RecommendPay recommendPay = recommendPayMapper.selectOne(new RecommendPay(fromUserId, recommendId));
        if (recommendPay != null) {
            return true;
        }

        //TODO 用户账户间的球币余额扣减与添加
        UserAccount userAccountFrom = userAccountMapper.selectUserAccountByUserId(fromUserId);
        UserAccount userAccountTo = userAccountMapper.selectUserAccountByUserId(toUserId);
        Account fromAccount = accountMapper.selectByPrimaryKey(userAccountFrom.getAccountId());
        Account toAccount = accountMapper.selectByPrimaryKey(userAccountTo.getAccountId());
        Integer fromAmount = fromAccount.getAmount() - price;
        if (fromAmount < 0) {
            return false;
        }
        Integer toAmount = toAccount.getAmount() + price;
        int fromResult = accountMapper.updateAmount(fromAccount.getId(), fromAmount);
        int toResult = accountMapper.updateAmount(toAccount.getId(), toAmount);
        if (!(fromResult > 0) || !(toResult > 0)) {
            System.out.println("账户更新失败");
        }
        String recommendsKey = "lottery_recommends_" + user.getId();
        redisTemplate.delete(recommendsKey);
        int result = recommendPayMapper.insert(new RecommendPay(fromUserId, recommendId));
        if (result > 0) {
            return true;
        }
        return false;
    }

    public List<HotMan> getHotMans() {
        List<HotMan> hotMans = new ArrayList<>();
        List<Integer> hotManIds = recommendPayMapper.selectRecommendedUserIds();
        List<HotMan> totalRankings = getTotalRankings();
        hotManIds.stream().forEach(hotManId -> {
            Integer recommendPayedCount = recommendPayMapper.selectRecommendPayedCountByUserId(hotManId);
            User user = userMapper.selectByPrimaryKey(hotManId);
            String username = user.getUsername();
            Integer userId = user.getId();
            List<Recommend> top5Recommends = getTopRecommentByUserId(5, user.getId());
            Integer top5WinCount = (int) top5Recommends.stream().filter(top5Recommend -> top5Recommend.getMatchResult().equals(1)).count();
            List<Recommend> top10Recommends = getTopRecommentByUserId(10, user.getId());
            Integer top10WinCount = (int) top10Recommends.stream().filter(top10Recommend -> top10Recommend.getMatchResult().equals(1)).count();
            Optional<HotMan> optionalHotMan = totalRankings.stream().filter(hotMan -> hotManId.intValue() == hotMan.getUserId().intValue()).findFirst();
            if (optionalHotMan.isPresent()) {
                String totalRate = optionalHotMan.get().getTotalRate();
                hotMans.add(HotMan.builder().recommendPayedCount(recommendPayedCount).username(username).userId(userId).totalRate(totalRate).top5Wincount(top5WinCount).top10WinCount(top10WinCount).build());
            }
        });
        //TODO 计算并返回红人榜列表
        return hotMans;
    }

    public List<Recommend> getTopRecommentByUserId(Integer topNum, Integer userId) {
        List<Recommend> topRecommends = recommendMapper.selectTopRecommendByUserId(userId, topNum);
        return topRecommends;
    }

    public List<HotMan> getTotalRankings() {
        String totalRankingsKey = "lottery_recommend_totalRankings";
        List<HotMan> rankingList = (List<HotMan>) redisTemplate.opsForValue().get(totalRankingsKey);
        if (rankingList != null && rankingList.size() > 0) {
            return rankingList;
        }
        List<HotMan> rankings = new ArrayList<>();
        //TODO 计算并返回排行榜Top50总榜列表
        List<Integer> recommendUserIds = recommendMapper.selectRecommendUserIds();
        recommendUserIds.stream().forEach(recommendUserId -> {
            User user = userMapper.selectByPrimaryKey(recommendUserId);
            String username = user.getUsername();
            Integer userId = user.getId();
            Integer loseCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(recommendUserId).matchResult(1).build());
            Integer winCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(recommendUserId).matchResult(2).build());
            Integer totalCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(recommendUserId).build());
            if (totalCount != 0) {
                String totalRate = String.valueOf(winCount * 100 / totalCount) + "%";
                HotMan hotMan = HotMan.builder().userId(userId).username(username).winCount(winCount).loseCount(loseCount).drawCount(totalCount - winCount - loseCount).totalRate(totalRate).build();
                rankings.add(hotMan);
            }
        });
        rankingList = rankings.stream().sorted(Comparator.comparingInt(HotMan::getWinCount).reversed().thenComparingInt(HotMan::getLoseCount).thenComparingInt(HotMan::getDrawCount)).limit(50).collect(Collectors.toList());
        if (rankingList != null && rankingList.size() > 0) {
            redisTemplate.opsForValue().set(totalRankingsKey, rankingList, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(totalRankingsKey, rankingList, 3, TimeUnit.MINUTES);
        }
        return rankingList;

    }

    public List<HotMan> getMonthRankings() {
        String monthRankingsKey = "lottery_recommend_monthRankings";
        List<HotMan> rankingList = (List<HotMan>) redisTemplate.opsForValue().get(monthRankingsKey);
        if (rankingList != null && rankingList.size() > 0) {
            return rankingList;
        }
        List<HotMan> rankings = new ArrayList<>();
        //TODO 计算并返回排行榜Top50月榜列表
        List<Integer> recommendUserIds = recommendMapper.selectRecommendUserIds();
        recommendUserIds.parallelStream().forEach(recommendUserId -> {
            User user = userMapper.selectByPrimaryKey(recommendUserId);
            String username = user.getUsername();
            Integer userId = user.getId();
            Integer loseCount = recommendMapper.selectMonthCountByRecommend(Recommend.builder().userId(recommendUserId).matchResult(1).build());
            Integer winCount = recommendMapper.selectMonthCountByRecommend(Recommend.builder().userId(recommendUserId).matchResult(2).build());
            Integer totalCount = recommendMapper.selectMonthCountByRecommend(Recommend.builder().userId(recommendUserId).build());
            if (totalCount != 0) {
                String monthRate = String.valueOf(winCount * 100 / totalCount) + "%";
                HotMan hotMan = HotMan.builder().userId(userId).username(username).winCount(winCount).loseCount(loseCount).drawCount(totalCount - winCount - loseCount).monthRate(monthRate).build();
                rankings.add(hotMan);
            }
        });
        rankingList = rankings.stream().sorted(Comparator.comparingInt(HotMan::getWinCount).reversed().thenComparingInt(HotMan::getLoseCount).thenComparingInt(HotMan::getDrawCount)).limit(50).collect(Collectors.toList());
        if (rankingList != null && rankingList.size() > 0) {
            redisTemplate.opsForValue().set(monthRankingsKey, rankingList, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(monthRankingsKey, rankingList, 3, TimeUnit.MINUTES);
        }
        return rankingList;
    }

    public List<HotMan> getWeekRankings() {
        String weekRankingsKey = "lottery_recommend_weekRankings";
        List<HotMan> rankingList = (List<HotMan>) redisTemplate.opsForValue().get(weekRankingsKey);
        if (rankingList != null && rankingList.size() > 0) {
            return rankingList;
        }
        List<HotMan> rankings = new ArrayList<>();
        //TODO 计算并返回排行榜Top50周榜列表
        List<Integer> recommendUserIds = recommendMapper.selectRecommendUserIds();
        recommendUserIds.parallelStream().forEach(recommendUserId -> {
            User user = userMapper.selectByPrimaryKey(recommendUserId);
            String username = user.getUsername();
            Integer userId = user.getId();
            Integer loseCount = recommendMapper.selectWeekCountByRecommend(Recommend.builder().userId(recommendUserId).matchResult(1).build());
            Integer winCount = recommendMapper.selectWeekCountByRecommend(Recommend.builder().userId(recommendUserId).matchResult(2).build());
            Integer totalCount = recommendMapper.selectWeekCountByRecommend(Recommend.builder().userId(recommendUserId).build());
            if (totalCount != 0) {
                String weekRate = String.valueOf(winCount * 100 / totalCount) + "%";
                HotMan hotMan = HotMan.builder().userId(userId).username(username).winCount(winCount).loseCount(loseCount).drawCount(totalCount - winCount - loseCount).weekRate(weekRate).build();
                rankings.add(hotMan);
            }
        });
        rankingList = rankings.stream().sorted(Comparator.comparingInt(HotMan::getWinCount).reversed().thenComparingInt(HotMan::getLoseCount).thenComparingInt(HotMan::getDrawCount)).limit(50).collect(Collectors.toList());
        if (rankingList != null && rankingList.size() > 0) {
            redisTemplate.opsForValue().set(weekRankingsKey, rankingList, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(weekRankingsKey, rankingList, 3, TimeUnit.MINUTES);
        }
        return rankingList;
    }

    public boolean checkRecommendPayed(Integer recommendId, Integer userId) {
        RecommendPay recommendPay = recommendPayMapper.selectOne(RecommendPay.builder().recommendId(recommendId).userId(userId).build());
        return recommendPay != null;
    }

    public Recommend getRecommend(Integer recommendId) {
        Recommend recommend = recommendMapper.selectByPrimaryKey(recommendId);
        return recommend;
    }

    public List<ReviewRecommend> getUnReviewedRecommend(){
        return recommendMapper.selectRecommendUnReviewed();
    }

    public List<ReviewRecommend> getReviewedRecommend(){
        return recommendMapper.selectRecommendReviewed();
    }

    public boolean modifyRecommendStatus(Integer recommendId, Integer status) {
        return recommendMapper.updateMatchResult(recommendId, status) > 0;
    }


}
