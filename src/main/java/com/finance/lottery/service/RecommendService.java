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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.*;
import java.util.stream.Collectors;

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
        if (recommendMapper.insert(recommend) > 0) {
            //TODO 保存购买记录，自己推荐的比赛，默认购买自己的，自己不用支付球币就可以查看
            return true;
        }
        return false;
    }

    public List<Recommend> getRecommendList() {
        return recommendMapper.selectAll();
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
    public Recommend payRecommend(Integer recommendId, User user) {
        Recommend recommend = recommendMapper.selectByPrimaryKey(recommendId);
        Integer price = recommend.getPrice();
        Integer fromUserId = user.getId();
        Integer toUserId = recommend.getUserId();

        //TODO 在recommend_pay表中插入购买记录，用户间的球币余额扣减与添加
        int result = recommendPayMapper.insert(new RecommendPay(fromUserId, recommendId));
        if (result > 0) {
            //TODO 用户账户间的球币余额扣减与添加
            UserAccount userAccountFrom = userAccountMapper.selectUserAccountByUserId(fromUserId);
            UserAccount userAccountTo = userAccountMapper.selectUserAccountByUserId(toUserId);
            Account fromAccount = accountMapper.selectByPrimaryKey(userAccountFrom.getAccountId());
            Account toAccount = accountMapper.selectByPrimaryKey(userAccountTo.getId());
            Integer fromAmount = fromAccount.getAmount() - price;
            Integer toAmount = toAccount.getAmount() + price;
            int fromResult = accountMapper.updateAmount(fromAccount.getId(), fromAmount);
            int toResult = accountMapper.updateAmount(toAccount.getId(), toAmount);
            if (!(fromResult > 0) || !(toResult > 0)) {
                System.out.println("账户更新失败");
            }
        }
        return recommend;
    }

    public List<HotMan> getHotMans() {
        List<HotMan> hotMans = new ArrayList<>();
        List<Integer> hotManIds = recommendPayMapper.selectRecommendPayedUserIds();
        hotManIds.parallelStream().forEach(hotManId -> {
            Integer recommendPayedCount = recommendPayMapper.selectRecommendPayedCountByUserId(hotManId);
            String username = userMapper.selectByPrimaryKey(hotManId).getUsername();
            List<Recommend> top5Recommends = getTopRecomment(5);
            List<Recommend> top10Recommends = getTopRecomment(10);
            String totalRate = getTotalRankings().stream().filter(hotMan -> hotManId.equals(hotMan.getUserId())).findFirst().get().getTotalRate();

        });
        //TODO 计算并返回红人榜列表
        return hotMans;
    }

    public List<Recommend> getTopRecomment(Integer topNum) {
        List<Recommend> topRecommends = recommendMapper.selectTopRecommend(topNum);
        return topRecommends;
    }

    public List<HotMan> getTotalRankings() {
        List<HotMan> hotmans = new ArrayList<>();
        //TODO 计算并返回排行榜Top50总榜列表
        List<Integer> recommendUserIds = recommendMapper.selectRecommendUserIds();
        recommendUserIds.parallelStream().forEach(recommendUserId -> {
            User user = userMapper.selectByPrimaryKey(recommendUserId);
            String username = user.getUsername();
            Integer userId = user.getId();
            Integer loseCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(recommendUserId).matchResult(1).build());
            Integer winCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(recommendUserId).matchResult(2).build());
            Integer totalCount = recommendMapper.selectTotalCountByRecommend(Recommend.builder().userId(recommendUserId).build());
            if (totalCount != 0) {
                String totalRate = String.valueOf(winCount * 100 / totalCount) + "%";
                HotMan hotMan = HotMan.builder().userId(String.valueOf(userId)).username(username).winCount(winCount).loseCount(loseCount).drawCount(totalCount - winCount - loseCount).totalRate(totalRate).build();
                hotmans.add(hotMan);
            }
        });
        List<HotMan> rankings = hotmans.stream().sorted(Comparator.comparing(HotMan::getWinCount).reversed().thenComparing(HotMan::getLoseCount).thenComparing(HotMan::getDrawCount)).collect(Collectors.toList());
        return rankings;
    }

    public List<HotMan> getMonthRankings() {
        List<HotMan> hotmans = new ArrayList<>();
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
                HotMan hotMan = HotMan.builder().userId(String.valueOf(userId)).username(username).winCount(winCount).loseCount(loseCount).drawCount(totalCount - winCount - loseCount).monthRate(monthRate).build();
                hotmans.add(hotMan);
            }
        });
        List<HotMan> rankings = hotmans.stream().sorted(Comparator.comparing(HotMan::getWinCount).reversed().thenComparing(HotMan::getLoseCount).thenComparing(HotMan::getDrawCount)).collect(Collectors.toList());
        return rankings;
    }

    public List<HotMan> getWeekRankings() {
        List<HotMan> hotmans = new ArrayList<>();
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
                HotMan hotMan = HotMan.builder().userId(String.valueOf(userId)).username(username).winCount(winCount).loseCount(loseCount).drawCount(totalCount - winCount - loseCount).weekRate(weekRate).build();
                hotmans.add(hotMan);
            }
        });
        List<HotMan> rankings = hotmans.stream().sorted(Comparator.comparing(HotMan::getWinCount).reversed().thenComparing(HotMan::getLoseCount).thenComparing(HotMan::getDrawCount)).collect(Collectors.toList());
        return rankings;
    }


}
