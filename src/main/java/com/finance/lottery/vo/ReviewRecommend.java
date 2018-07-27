package com.finance.lottery.vo;

import com.finance.lottery.entity.zqmf.Recommend;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * ClassName: ReviewRecommend
 * Description:
 *
 * @Author xuzhiqing
 * @Date 2018/7/26 at 17:09
 * @Version 1.0
 **/
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewRecommend extends Recommend {
    private String author;
}
