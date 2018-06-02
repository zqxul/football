package com.finance.lottery.response;

import com.finance.lottery.entity.netease.MatchInfo;
import com.finance.lottery.result.ResponseEnum;
import lombok.Data;

import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/13 00:35
 * @Description:
 */
@Data
public class ScoreLiveMatchResponse {

    private int result;
    private List<MatchInfo> data;

    public ScoreLiveMatchResponse() {
    }

    public ScoreLiveMatchResponse(ResponseEnum responseEnum) {
        this.result = responseEnum.getCode();
    }
}
