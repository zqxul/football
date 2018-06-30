package com.finance.lottery.entity.zqmf;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/17 18:58
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HotMan {
    private String photo;
    private Integer userId;
    private String username;
    private Integer winCount;
    private Integer loseCount;
    private Integer drawCount;
    private String totalRate;
    private String monthRate;
    private String weekRate;
    private String recentScore;
    private Integer viewTimes;
    private Integer recommendPayedCount;
    private Integer top5Wincount;
    private Integer top10WinCount;
}
