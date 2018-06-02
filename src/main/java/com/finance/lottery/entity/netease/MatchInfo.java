package com.finance.lottery.entity.netease;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/13 00:40
 * @Description:
 */
@Data
@NoArgsConstructor
public class MatchInfo {
    private String leagueName;
    private String leagueNameStyle;
    private String matchTime;
    private String statusDesc;
    private String matchStatus;
    private String matchCode;
    private String matchOrder;
    private String round;
    private String teamA;
    private String teamALogo;
    private String score;
    private String halfScore;
    private String bidScore;
    private String teamB;
    private String teamBLogo;
    private int hostRedCard;
    private int hostYellowCard;
    private int visitRedCard;
    private int visitYellowCard;
    private String concede;

    public MatchInfo(String period, String eventStyle, String events, String playTime, String round, String hostRedCard, String hostYellowCard, String hostName, String hostTeamLogo, String score, String guestTeamLogo, String guestName, String guestYellowCard, String guestRedCard, String statusDesc, String matchStatus, String halfScore, String bidScore,String concede) {
        this.matchOrder = period;
        this.leagueNameStyle = eventStyle;
        this.leagueName = events;
        this.matchTime = playTime;
        this.round = round;
        this.hostRedCard = Integer.valueOf(hostRedCard);
        this.hostYellowCard = Integer.valueOf(hostYellowCard);
        this.teamA = hostName;
        this.teamALogo = hostTeamLogo;
        this.score = score;
        this.teamBLogo = guestTeamLogo;
        this.teamB = guestName;
        this.visitYellowCard = Integer.valueOf(guestYellowCard);
        this.visitRedCard = Integer.valueOf(guestRedCard);
        this.statusDesc = statusDesc;
        this.matchStatus = matchStatus;
        this.halfScore = halfScore;
        this.bidScore = bidScore;
        this.concede = concede;
    }
}
