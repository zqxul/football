package com.finance.lottery.entity.netease;

import lombok.Data;

import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/20 23:13
 * @Description:
 */
@Data
public class MatchHistory {
    private List<MatchHistoryVS> matchHistoryVS;
    private String vsWinCount;
    private String vsHostWinCount;
    private String vsDrawCount;
    private String vsHostDrawCount;
    private String vsLoseCount;
    private String vsHostLoseCount;
    private List<MatchHistoryRecent> matchHistoryHostRecents;
    private String hostRecentWinCount;
    private String hostRecentHostWinCount;
    private String hostRecentDrawCount;
    private String hostRecentHostDrawCount;
    private String hostRecentLoseCount;
    private String hostRecentHostLoseCount;
    private List<MatchHistoryRecent> matchHistoryVisitRecents;
    private String visitRecentWinCount;
    private String visitRecentVisitWinCount;
    private String visitRecentDrawCount;
    private String visitRecentVisitDrawCount;
    private String visitRecentLoseCount;
    private String visitRecentVisitLoseCount;
    private List<MatchHistoryFuture> matchHistoryHostFutures;
    private List<MatchHistoryFuture> matchHistoryVisitFutures;
}
