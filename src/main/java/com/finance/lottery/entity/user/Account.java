package com.finance.lottery.entity.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/5/30 13:40
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Account {
    private Integer id;
    private Integer amount;
    private Integer availableAmount;
    private Integer freezedAmount;
    private Date createTime;
}
