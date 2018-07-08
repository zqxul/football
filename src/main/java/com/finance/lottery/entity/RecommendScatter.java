package com.finance.lottery.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * ClassName: RecommendScatter
 * Description:
 *
 * @Author xuzhiqing
 * @Date 2018/7/7 at 15:03
 * @Version 1.0
 **/
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RecommendScatter {
    private String name;
    private Integer count;
}
