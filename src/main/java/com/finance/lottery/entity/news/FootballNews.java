package com.finance.lottery.entity.news;

import lombok.Data;

import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/17 22:52
 * @Description:
 */
@Data
public class FootballNews {
    private String id;
    private String title;
    private String share;
    private String thumb;
    private String is_video;
    private String new_video_detail;
    private String published_at;
    private String sort_timestamp;
    private String channel;
}
