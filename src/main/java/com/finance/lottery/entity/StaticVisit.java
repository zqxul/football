package com.finance.lottery.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/8 15:09
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StaticVisit {
    private Integer id;
    private String visitUrl;
    private Integer visitCount;
    private Date createTime;
}
