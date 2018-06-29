package com.finance.lottery.entity;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Data
@Builder
public class Recharge {
    private Integer id;
    private Integer userId;
    private Integer amount;
    private Integer status;
    private Date createTime;
    private String createBy;
    private Integer isActive;
}
