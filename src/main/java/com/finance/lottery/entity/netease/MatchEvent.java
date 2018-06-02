package com.finance.lottery.entity.netease;

import lombok.Data;

import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/20 23:13
 * @Description:
 */
@Data
public class MatchEvent {
    private List<MatchEventTimeline> hostTimeline;
    private List<MatchEventTimeline> visitTimeline;
    private List<MatchEventTimeline> timelines;
    private List<MatchEventLineup> hostLineup;
    private List<MatchEventLineup> visitLineup;
    private List<MatchEventInjure> hostInjuries;
    private List<MatchEventInjure> visitInjuries;
    private MatchEventTech techs;
}
