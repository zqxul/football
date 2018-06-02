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
public class ScoreLiveMatchInfoResponse {

    private int result;
    private List<MatchInfo> data;

    public ScoreLiveMatchInfoResponse() {
    }

    public ScoreLiveMatchInfoResponse(ResponseEnum responseEnum) {
        this.result = responseEnum.getCode();
    }
}
