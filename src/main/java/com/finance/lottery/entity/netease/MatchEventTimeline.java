package com.finance.lottery.entity.netease;

import lombok.Data;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/21 11:05
 * @Description:
 */
@Data
public class MatchEventTimeline {
    private String teamName;
    private int isHost;
    private String playerName;  //球员
    private Integer eventTime;  //时间
    private int eventType;  //事件类型: 1、进球 2、黄牌  3、4、5、换下 6、换上 7、红牌 12、乌龙 23、点球
}
