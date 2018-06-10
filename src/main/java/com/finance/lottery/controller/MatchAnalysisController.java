package com.finance.lottery.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPath;
import com.finance.lottery.entity.netease.*;
import com.finance.lottery.request.MatchAnalysisRequest;
import com.finance.lottery.request.MatchRequest;
import com.finance.lottery.result.ResponseEnum;
import com.finance.lottery.service.BFIndexService;
import com.finance.lottery.service.InformationService;
import com.finance.lottery.service.ScoreLiveService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/20 23:08
 * @Description:
 */
@RestController
@RequestMapping("/analysis")
public class MatchAnalysisController {

    @Autowired
    private MatchRequest matchRequest;

    @Autowired
    private MatchAnalysisRequest matchAnalysisRequest;

    @Autowired
    private ScoreLiveService scoreLiveService;

    @Autowired
    private InformationService informationService;

    @Autowired
    private BFIndexService bfIndexService;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @GetMapping("/info")
    public DeferredResult<ModelAndView> getAnalysisInfo() {
        DeferredResult<ModelAndView> result = new DeferredResult<>();
        ModelAndView mav = new ModelAndView("analysis");
        String infoKey = "lottery_analysis_info";
        List<MatchTeamInfo> matchTeamInfos = (List<MatchTeamInfo>) redisTemplate.opsForValue().get(infoKey);
        if (matchTeamInfos != null) {
            mav.addObject("matchTeamInfos", matchTeamInfos);
            result.setResult(mav);
            return result;
        }
        String responseJson = scoreLiveService.getMatchsResponseJson(matchRequest);
        String matchInfoJson = JSONPath.read(responseJson, "$.data[0].matchInfo").toString();
        List<MatchTeamInfo> matchTeamInfoList = JSONArray.parseArray(matchInfoJson, MatchTeamInfo.class);

        //设置排名
        matchTeamInfoList.parallelStream().forEach(matchTeamInfo -> {
            initRanking(matchTeamInfo);
        });

        matchTeamInfos = matchTeamInfoList.parallelStream().sorted(Comparator.comparing(MatchTeamInfo::getMatchCode).reversed()).collect(Collectors.toList());
        if (matchTeamInfos != null && matchTeamInfos.size() > 0) {
            redisTemplate.opsForValue().set(infoKey, matchTeamInfos, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(infoKey, new ArrayList<>(), 3, TimeUnit.MINUTES);
        }
        mav.addObject("matchTeamInfos", matchTeamInfos);
        result.setResult(mav);
        return result;
    }

//    @GetMapping("/info")
//    public DeferredResult<ModelAndView> getAnalysisInfos() {
//        DeferredResult<ModelAndView> result = new DeferredResult<>();
//        CompletableFuture.runAsync(() -> {
//            ModelAndView mav = new ModelAndView("analysis");
//            Long startTime = System.currentTimeMillis();
//            String responseJson = matchAnalysisService.getMatchsResponseJson(matchRequest);
//            String matchInfoJson = JSONPath.read(responseJson, "$.data[0].matchInfo").toString();
//            List<MatchTeamInfo> matchTeamInfoList = JSONArray.parseArray(matchInfoJson, MatchTeamInfo.class);
//            List<MatchTeamInfo> matchTeamInfos = matchTeamInfoList.parallelStream().sorted(Comparator.comparing(MatchTeamInfo::getMatchCode).reversed()).collect(Collectors.toList());
//            Long endTime = System.currentTimeMillis();
//            System.out.println("GetAnalysisInfo uses " + (endTime - startTime) + " ms");
//            mav.addObject("matchTeamInfos", matchTeamInfos);
//            result.setResult(mav);
//        });
//        return result;
//    }

    /**
     * @param matchTeamInfo 比赛信息(主要使用:比赛顺序、比赛日期、比赛时间)
     * @Author: xuzhiqing
     * @Date: 2018/6/1 15:04
     * @Description: 根据比赛顺序、比赛日期、比赛时间从足球魔方官网抓取情报数据
     */
    @GetMapping("/information")
    public String getInformation(MatchTeamInfo matchTeamInfo) {
        String informationKey = "lottery_analysis_information_" + matchTeamInfo.getMatchId();
        String information = stringRedisTemplate.opsForValue().get(informationKey);
        if (information != null) {
            return information;
        }
        information = informationService.getInformation(matchTeamInfo);
        if (information != null) {
            stringRedisTemplate.opsForValue().set(informationKey, information, 3, TimeUnit.HOURS);
        } else {
            stringRedisTemplate.opsForValue().set(informationKey, "", 3, TimeUnit.MINUTES);
        }
        return information;
    }

    @GetMapping("/bfindex")
    public List<String> getBFIndex(MatchTeamInfo matchTeamInfo) {
        String bfIndexKey = "lottery_analysis_bfindex_" + matchTeamInfo.getMatchId();
        List<String> bfIndex = (List<String>) redisTemplate.opsForValue().get(bfIndexKey);
        if (bfIndex != null) {
            return bfIndex;
        }
        bfIndex = bfIndexService.getBFIndex(matchTeamInfo);
        if (bfIndex != null) {
            redisTemplate.opsForValue().set(bfIndexKey, bfIndex, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(bfIndexKey, new ArrayList<>(), 3, TimeUnit.MINUTES);
        }
        return bfIndex;
    }

    /**
     * @param matchTeamInfo 比赛信息
     * @Author: xuzhiqing
     * @Date: 2018/5/24 00:03
     * @Description: 根据比赛双方的id和matchId获取赔率
     */
    @GetMapping("/odd")
    public DeferredResult<MatchOdd> getMatchOdd(MatchTeamInfo matchTeamInfo) {
        DeferredResult<MatchOdd> result = new DeferredResult<>();
        String oddKey = "lottery_analysis_odd_" + matchTeamInfo.getMatchId();
        MatchOdd matchOdd = (MatchOdd) redisTemplate.opsForValue().get(oddKey);
        if (matchOdd != null) {
            result.setResult(matchOdd);
            return result;
        }
        matchOdd = new MatchOdd();
        String responseJson = getMatchOddInfo(matchTeamInfo.getTeamAId(), matchTeamInfo.getMatchId(), matchTeamInfo.getTeamBId(), "13");
        JSONArray asiaOddsJsonArray = (JSONArray) JSONPath.read(responseJson, "$.data[0].asiaOdds");
        JSONArray ouOddsJsonArray = (JSONArray) JSONPath.read(responseJson, "$.data[0].ouOdds");
        JSONArray dxpOddsJsonArray = (JSONArray) JSONPath.read(responseJson, "$.data[0].dxpOdds");

        if (asiaOddsJsonArray != null) {
            matchOdd.setAsiaOdds(asiaOddsJsonArray.toJavaList(MatchOddAsia.class));
        }
        if (ouOddsJsonArray != null) {
            matchOdd.setOuOdds(ouOddsJsonArray.toJavaList(MatchOddEurope.class));
        }
        if (dxpOddsJsonArray != null) {
            matchOdd.setDxpOdds(dxpOddsJsonArray.toJavaList(MatchOddSizeBall.class));
        }

        //防止缓存击穿
        if (matchOdd.getAsiaOdds() != null || matchOdd.getOuOdds() != null || matchOdd.getDxpOdds() != null) {
            redisTemplate.opsForValue().set(oddKey, matchOdd, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(oddKey, matchOdd, 3, TimeUnit.MINUTES);
        }
        result.setResult(matchOdd);
        return result;
    }

    /**
     * @param matchTeamInfo 比赛信息
     * @Author: xuzhiqing
     * @Date: 2018/5/21 16:03
     * @Description: 根据比赛双方的id和matchId获取積分数据
     */
    @GetMapping("/point")
    public DeferredResult<MatchPoint> getMatchPoint(MatchTeamInfo matchTeamInfo) {
        DeferredResult<MatchPoint> result = new DeferredResult<>();
        String pointKey = "lottery_analysis_point_" + matchTeamInfo.getMatchId();
        MatchPoint matchPoint = (MatchPoint) redisTemplate.opsForValue().get(pointKey);
        if (matchPoint != null) {
            result.setResult(matchPoint);
            return result;
        }
        matchPoint = new MatchPoint();
        String matchPointResponseJson = getMatchInfo(matchTeamInfo.getTeamAId(), matchTeamInfo.getMatchId(), matchTeamInfo.getTeamBId(), "12");
        JSONObject matchPointTotalRankingJsonObject = (JSONObject) JSONPath.read(matchPointResponseJson, "$.data[0].rankings[0]");
        JSONObject matchPointHostRankingJsonObject = (JSONObject) JSONPath.read(matchPointResponseJson, "$.data[0].hostRankings[0]");
        JSONObject matchPointVisitRankingJsonObject = (JSONObject) JSONPath.read(matchPointResponseJson, "$.data[0].visitRankings[0]");
        if (matchPointTotalRankingJsonObject != null) {
            matchPoint.setMatchTotalRanking(matchPointTotalRankingJsonObject.toJavaObject(MatchPointRanking.class));
        }
        if (matchPointHostRankingJsonObject != null) {
            matchPoint.setMatchHostRanking(matchPointHostRankingJsonObject.toJavaObject(MatchPointRanking.class));
        }
        if (matchPointVisitRankingJsonObject != null) {
            matchPoint.setMatchVisitRanking(matchPointVisitRankingJsonObject.toJavaObject(MatchPointRanking.class));
        }

        //防止缓存击穿
        if (matchPoint.getMatchHostRanking() != null || matchPoint.getMatchTotalRanking() != null || matchPoint.getMatchVisitRanking() != null) {
            redisTemplate.opsForValue().set(pointKey, matchPoint, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(pointKey, matchPoint, 3, TimeUnit.MINUTES);
        }
        result.setResult(matchPoint);
        return result;
    }

    /**
     * @param matchTeamInfo 比赛信息
     * @Author: xuzhiqing
     * @Date: 2018/5/21 16:03
     * @Description: 根据比赛双方的id和matchId获取战绩数据
     */
    @GetMapping("/history")
    public DeferredResult<MatchHistory> getMatchHistory(MatchTeamInfo matchTeamInfo) {
        DeferredResult<MatchHistory> result = new DeferredResult<>();
        String historyKey = "lottery_analysis_history_" + matchTeamInfo.getMatchId();
        MatchHistory matchHistory = (MatchHistory) redisTemplate.opsForValue().get(historyKey);
        if (matchHistory != null) {
            result.setResult(matchHistory);
            return result;
        }
        matchHistory = new MatchHistory();
        String matchHistoryResponseJson = getMatchInfo(matchTeamInfo.getTeamAId(), matchTeamInfo.getMatchId(), matchTeamInfo.getTeamBId(), "11");
        JSONArray matchHistoryVSJsonArray = (JSONArray) JSONPath.read(matchHistoryResponseJson, "$.data[0].historyVS");
        JSONArray matchHistoryHostRecentJsonArray = (JSONArray) JSONPath.read(matchHistoryResponseJson, "$.data[0].hostRecentMatch");
        JSONArray matchHistoryVisitRecentJsonArray = (JSONArray) JSONPath.read(matchHistoryResponseJson, "$.data[0].visitRecentMatch");
        JSONArray matchHistoryHostFutureJsonArray = (JSONArray) JSONPath.read(matchHistoryResponseJson, "$.data[0].hostFutureMatch");
        JSONArray matchHistoryVisitFutureJsonArray = (JSONArray) JSONPath.read(matchHistoryResponseJson, "$.data[0].visitFutureMatch");
        String teamA = matchTeamInfo.getTeamA();
        String teamB = matchTeamInfo.getTeamB();
        if (matchHistoryVSJsonArray != null) {
            List<MatchHistoryVS> matchHistoryVSList = matchHistoryVSJsonArray.toJavaList(MatchHistoryVS.class);
            matchHistoryVSList.parallelStream().forEach(matchHistoryVS -> {
                String score = matchHistoryVS.getScore();
                String[] scores = score.split(":");
                if (matchHistoryVS.getHostName().equals(teamA)) {
                    if (Integer.valueOf(scores[0]) > Integer.valueOf(scores[1])) {
                        matchHistoryVS.setResult("胜");
                    } else if (Integer.valueOf(scores[0]) < Integer.valueOf(scores[1])) {
                        matchHistoryVS.setResult("负");
                    } else {
                        matchHistoryVS.setResult("平");
                    }
                } else {
                    if (Integer.valueOf(scores[0]) > Integer.valueOf(scores[1])) {
                        matchHistoryVS.setResult("负");
                    } else if (Integer.valueOf(scores[0]) < Integer.valueOf(scores[1])) {
                        matchHistoryVS.setResult("胜");
                    } else {
                        matchHistoryVS.setResult("平");
                    }
                }
            });
            long vsWinCount = matchHistoryVSList.parallelStream().filter(matchHistoryVS -> "胜".equals(matchHistoryVS.getResult())).count();
            long vsHostWinCount = matchHistoryVSList.parallelStream().filter(matchHistoryVS -> teamA.equals(matchHistoryVS.getHostName())).filter(matchHistoryVS -> "胜".equals(matchHistoryVS.getResult())).count();
            long vsDrawCount = matchHistoryVSList.parallelStream().filter(matchHistoryVS -> "平".equals(matchHistoryVS.getResult())).count();
            long vsHostDrawCount = matchHistoryVSList.parallelStream().filter(matchHistoryVS -> teamA.equals(matchHistoryVS.getHostName())).filter(matchHistoryVS -> "平".equals(matchHistoryVS.getResult())).count();
            long vsLoseCount = matchHistoryVSList.parallelStream().filter(matchHistoryVS -> "负".equals(matchHistoryVS.getResult())).count();
            long vsHostLoseCount = matchHistoryVSList.parallelStream().filter(matchHistoryVS -> teamA.equals(matchHistoryVS.getHostName())).filter(matchHistoryVS -> "负".equals(matchHistoryVS.getResult())).count();
            matchHistory.setMatchHistoryVS(matchHistoryVSList);
            matchHistory.setVsWinCount(String.valueOf(vsWinCount));
            matchHistory.setVsHostWinCount(String.valueOf(vsHostWinCount));
            matchHistory.setVsDrawCount(String.valueOf(vsDrawCount));
            matchHistory.setVsHostDrawCount(String.valueOf(vsHostDrawCount));
            matchHistory.setVsLoseCount(String.valueOf(vsLoseCount));
            matchHistory.setVsHostLoseCount(String.valueOf(vsHostLoseCount));
        }
        if (matchHistoryHostRecentJsonArray != null) {
            List<MatchHistoryRecent> matchHistoryRecents = matchHistoryHostRecentJsonArray.toJavaList(MatchHistoryRecent.class);
            long recentWinCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> "胜".equals(matchHistoryRecent.getResult())).count();
            long recentHostWinCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> teamA.equals(matchHistoryRecent.getHostName())).filter(matchHistoryRecent -> "胜".equals(matchHistoryRecent.getResult())).count();
            long recentDrawCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> "平".equals(matchHistoryRecent.getResult())).count();
            long recentHostDrawCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> teamA.equals(matchHistoryRecent.getHostName())).filter(matchHistoryRecent -> "平".equals(matchHistoryRecent.getResult())).count();
            long recentLoseCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> "负".equals(matchHistoryRecent.getResult())).count();
            long recentHostLoseCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> teamA.equals(matchHistoryRecent.getHostName())).filter(matchHistoryRecent -> "负".equals(matchHistoryRecent.getResult())).count();
            matchHistory.setMatchHistoryHostRecents(matchHistoryRecents);
            matchHistory.setHostRecentWinCount(String.valueOf(recentWinCount));
            matchHistory.setHostRecentHostWinCount(String.valueOf(recentHostWinCount));
            matchHistory.setHostRecentDrawCount(String.valueOf(recentDrawCount));
            matchHistory.setHostRecentHostDrawCount(String.valueOf(recentHostDrawCount));
            matchHistory.setHostRecentLoseCount(String.valueOf(recentLoseCount));
            matchHistory.setHostRecentHostLoseCount(String.valueOf(recentHostLoseCount));
        }
        if (matchHistoryVisitRecentJsonArray != null) {
            List<MatchHistoryRecent> matchHistoryRecents = matchHistoryVisitRecentJsonArray.toJavaList(MatchHistoryRecent.class);
            long recentWinCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> "胜".equals(matchHistoryRecent.getResult())).count();
            long recentVisitWinCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> teamB.equals(matchHistoryRecent.getVisitName())).filter(matchHistoryRecent -> "胜".equals(matchHistoryRecent.getResult())).count();
            long recentDrawCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> "平".equals(matchHistoryRecent.getResult())).count();
            long recentVisitDrawCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> teamB.equals(matchHistoryRecent.getVisitName())).filter(matchHistoryRecent -> "平".equals(matchHistoryRecent.getResult())).count();
            long recentLoseCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> "负".equals(matchHistoryRecent.getResult())).count();
            long recentVisitLoseCount = matchHistoryRecents.parallelStream().filter(matchHistoryRecent -> teamB.equals(matchHistoryRecent.getVisitName())).filter(matchHistoryRecent -> "负".equals(matchHistoryRecent.getResult())).count();
            matchHistory.setMatchHistoryVisitRecents(matchHistoryRecents);
            matchHistory.setVisitRecentWinCount(String.valueOf(recentWinCount));
            matchHistory.setVisitRecentVisitWinCount(String.valueOf(recentVisitWinCount));
            matchHistory.setVisitRecentDrawCount(String.valueOf(recentDrawCount));
            matchHistory.setVisitRecentVisitDrawCount(String.valueOf(recentVisitDrawCount));
            matchHistory.setVisitRecentLoseCount(String.valueOf(recentLoseCount));
            matchHistory.setVisitRecentVisitLoseCount(String.valueOf(recentVisitLoseCount));
        }
        if (matchHistoryHostFutureJsonArray != null) {
            matchHistory.setMatchHistoryHostFutures(matchHistoryHostFutureJsonArray.toJavaList(MatchHistoryFuture.class));
        }
        if (matchHistoryVisitFutureJsonArray != null) {
            matchHistory.setMatchHistoryVisitFutures(matchHistoryVisitFutureJsonArray.toJavaList(MatchHistoryFuture.class));
        }

        //防止缓存击穿
        if (matchHistory.getMatchHistoryVS() != null || matchHistory.getMatchHistoryHostRecents() != null || matchHistory.getMatchHistoryVisitRecents() != null || matchHistory.getMatchHistoryVisitRecents() != null || matchHistory.getMatchHistoryVisitFutures() != null) {
            redisTemplate.opsForValue().set(historyKey, matchHistory, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(historyKey, matchHistory, 5, TimeUnit.SECONDS);
        }
        result.setResult(matchHistory);
        return result;
    }

    /**
     * @param matchTeamInfo 比赛信息
     * @Author: xuzhiqing
     * @Date: 2018/5/21 14:25
     * @Description: 根据比赛双方的id和matchId获取赛事数据
     */
    @GetMapping("/event")
    public DeferredResult<MatchEvent> getMatchEvent(MatchTeamInfo matchTeamInfo) {
        DeferredResult<MatchEvent> result = new DeferredResult<>();
        String eventKey = "lottery_analysis_event_" + matchTeamInfo.getMatchId();
        MatchEvent matchEvent = (MatchEvent) redisTemplate.opsForValue().get(eventKey);
        if (matchEvent != null) {
            result.setResult(matchEvent);
            return result;
        }
        matchEvent = new MatchEvent();
        String matchEventResponseJson = getMatchInfo(matchTeamInfo.getTeamAId(), matchTeamInfo.getMatchId(), matchTeamInfo.getTeamBId(), "10");
        JSONArray matchEventHostTimelineJsonArray = (JSONArray) JSONPath.read(matchEventResponseJson, "$.data[0].hostTimelineEvents");
        JSONArray matchEventVisitTimelineJsonArray = (JSONArray) JSONPath.read(matchEventResponseJson, "$.data[0].visitTimelineEvents");
        JSONArray matchEventHostInjuriesJsonArray = (JSONArray) JSONPath.read(matchEventResponseJson, "$.data[0].hostInjuries");
        JSONArray matchEventVisitInjuriesJsonArray = (JSONArray) JSONPath.read(matchEventResponseJson, "$.data[0].visitInjuries");
        JSONArray matchEventHostLineupJsonArray = (JSONArray) JSONPath.read(matchEventResponseJson, "$.data[0].lineup[0].players");
        JSONArray matchEventVisitLineupJsonArray = (JSONArray) JSONPath.read(matchEventResponseJson, "$.data[0].lineup[1].players");
        JSONObject matchEventTechJsonArray = (JSONObject) JSONPath.read(matchEventResponseJson, "$.data[0]");
        if (matchEventHostTimelineJsonArray != null) {
            matchEvent.setHostTimeline(matchEventHostTimelineJsonArray.toJavaList(MatchEventTimeline.class));
        }
        if (matchEventVisitTimelineJsonArray != null) {
            matchEvent.setVisitTimeline(matchEventVisitTimelineJsonArray.toJavaList(MatchEventTimeline.class));
        }
        List<MatchEventTimeline> timelines = mergeTimelines(matchEvent);
        matchEvent.setTimelines(timelines);
        if (matchEventHostInjuriesJsonArray != null) {
            matchEvent.setHostInjuries(matchEventHostInjuriesJsonArray.toJavaList(MatchEventInjure.class));
        }
        if (matchEventVisitInjuriesJsonArray != null) {
            matchEvent.setVisitInjuries(matchEventVisitInjuriesJsonArray.toJavaList(MatchEventInjure.class));
        }
        if (matchEventHostLineupJsonArray != null) {
            matchEvent.setHostLineup(matchEventHostLineupJsonArray.toJavaList(MatchEventLineup.class));
        }
        if (matchEventVisitLineupJsonArray != null) {
            matchEvent.setVisitLineup(matchEventVisitLineupJsonArray.toJavaList(MatchEventLineup.class));
        }
        if (matchEventTechJsonArray != null) {
            matchEvent.setTechs(matchEventTechJsonArray.toJavaObject(MatchEventTech.class));
        }

        //防止缓存击穿
        if (matchEvent.getHostTimeline() != null || matchEvent.getVisitTimeline() != null || matchEvent.getHostInjuries() != null || matchEvent.getVisitInjuries() != null || matchEvent.getHostLineup() != null || matchEvent.getVisitLineup() != null) {
            redisTemplate.opsForValue().set(eventKey, matchEvent, 3, TimeUnit.HOURS);
        } else {
            redisTemplate.opsForValue().set(eventKey, matchEvent, 3, TimeUnit.MINUTES);
        }
        result.setResult(matchEvent);
        return result;
    }

    /**
     * @param teamAId 主队id
     * @param matchId 比赛id
     * @param teamBId 客队id
     * @param type    比赛信息类型: 10、赛事 11、战绩 12、积分 13、赔率 14、聊球
     * @Author: xuzhiqing
     * @Date: 2018/5/13 08:03
     * @Description: 获取某一场比赛的信息
     */
    @GetMapping("/matchInfo")
    public String getMatchInfo(@RequestParam String teamAId, @RequestParam String matchId, @RequestParam String teamBId, @RequestParam String
            type) {
        if (StringUtils.isBlank(teamAId) || StringUtils.isBlank(matchId) || StringUtils.isBlank(teamBId) || StringUtils.isBlank(type)) {
            return JSON.toJSONString(ResponseEnum.PARAM_ERROR);
        }
        Map<String, String> params = matchAnalysisRequest.getParams();
        params.put("hostId", teamAId);
        params.put("matchId", matchId);
        params.put("visitId", teamBId);
        params.put("type", type);
        return scoreLiveService.getScoreLiveMatchInfoResponseJson(matchAnalysisRequest);
    }

    public void initRanking(MatchTeamInfo matchTeamInfo) {
        DeferredResult<String> result = new DeferredResult<>();
        Map<String, String> params = matchAnalysisRequest.getParams();
        params.put("hostId", matchTeamInfo.getTeamAId());
        params.put("matchId", matchTeamInfo.getMatchId());
        params.put("visitId", matchTeamInfo.getTeamBId());
        params.put("type", "12");
        String ranking = scoreLiveService.getScoreLiveMatchInfoResponseJson(matchAnalysisRequest);
        JSONObject jsonObject = (JSONObject) JSONPath.read(ranking, "data[0]");
        matchTeamInfo.setHostRankingTotal(jsonObject.getString("hostRankAll"));
        matchTeamInfo.setHostRankingHost(jsonObject.getString("hostRankHomeCourt"));
        matchTeamInfo.setVisitRankingTotal(jsonObject.getString("visitRankAll"));
        matchTeamInfo.setVisitRankingVisit(jsonObject.getString("visitRankAwayCourt"));
    }

    @GetMapping("/matchInfo/odds")
    public String getMatchOddInfo(@RequestParam String hostId, @RequestParam String matchId, @RequestParam String visitId, @RequestParam String
            type) {
        if (StringUtils.isBlank(hostId) || StringUtils.isBlank(matchId) || StringUtils.isBlank(visitId) || StringUtils.isBlank(type)) {
            return JSON.toJSONString(ResponseEnum.PARAM_ERROR);
        }
        Map<String, String> params = matchAnalysisRequest.getParams();
        params.put("hostId", hostId);
        params.put("matchId", matchId);
        params.put("visitId", visitId);
        params.put("type", type);
        return scoreLiveService.getScoreLiveMatchOddInfoResponseJson(matchAnalysisRequest);
    }

    public List<MatchEventTimeline> mergeTimelines(MatchEvent matchEvent) {
        List<MatchEventTimeline> hostTimeline = matchEvent.getHostTimeline();
        List<MatchEventTimeline> visitTimeline = matchEvent.getVisitTimeline();
        List<MatchEventTimeline> timelines = new ArrayList<>();
        if (hostTimeline != null && hostTimeline.size() > 0) {
            timelines.addAll(hostTimeline);
        }
        if (visitTimeline != null && visitTimeline.size() > 0) {
            timelines.addAll(visitTimeline);
        }
        return timelines.stream().sorted(Comparator.comparing(MatchEventTimeline::getEventTime).reversed()).collect(Collectors.toList());
    }

}
