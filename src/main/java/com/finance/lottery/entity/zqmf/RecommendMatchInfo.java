package com.finance.lottery.entity.zqmf;

import lombok.Data;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/13 21:38
 */
@Data
public class RecommendMatchInfo {
    private String gsm_match_id;
    private String gsm_league_id;
    private String season_id;
    private String round_id;
    private String round;
    private String competition_name;
    private String league_name;
    private String match_time;
    private String home_name;
    private String away_name;
    private String home_team_id;
    private String away_team_id;
    private String status;
    private String status_txt;
    private String is_yp;
    private String is_dxq;
    private String is_jc;
}
