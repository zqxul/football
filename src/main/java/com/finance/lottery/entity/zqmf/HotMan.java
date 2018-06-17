package com.finance.lottery.entity.zqmf;

import lombok.Data;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/17 18:58
 */
@Data
public class HotMan {
    private String photo;
    private String userId;
    private String username;
    private String totalRate;
    private String recentScore;
    private Integer viewTimes;
}
