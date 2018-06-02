package com.finance.lottery.entity.netease;

import lombok.Data;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/22 23:32
 * @Description:
 */
@Data
public class MatchEventTech {
    private String hostPossession;
    private String visitPossession;
    private int hostShoot;
    private int visitShoot;
    private int hostShotsOnTarget;
    private int visitShotsOnTarget;
    private int hostDangerousAttack;
    private int visitDangerousAttack;
    private int hostAttack;
    private int visitAttack;
    private int hostCorner;
    private int visitCorner;
    private int hostFoul;
    private int visitFoul;
    private int hostYellowCard;
    private int visitYellowCard;
    private int hostRedCard;
    private int visitRedCard;
}
