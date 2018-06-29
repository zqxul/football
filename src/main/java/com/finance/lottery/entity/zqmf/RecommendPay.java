package com.finance.lottery.entity.zqmf;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Calendar;
import java.util.Date;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/18 18:04
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RecommendPay {
    private Integer id;
    private Integer userId;
    private Integer recommendId;
    private Date createTime;

    public RecommendPay(Integer userId,Integer recommendId){
        this.userId = userId;
        this.recommendId = recommendId;
        this.createTime = Calendar.getInstance().getTime();
    }
}
