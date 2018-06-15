package com.finance.lottery.entity.zqmf;

import lombok.Data;

import java.util.List;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/13 22:19
 */
@Data
public class RecommendMatchDetail {
    private List<OddDetail> yp;
    private List<OddDetail> dxq;
    private OddDetail jc;
}
