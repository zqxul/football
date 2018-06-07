<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Information</title>
    <link href="/production/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/custom/css/information.css">
    <link rel="stylesheet" href="/production/font-awesome/css/font-awesome.min.css">
    <script src="/production/jquery/jquery.min.js"></script>
    <script>
        //当img标签的src加载出错时的处理
        function setDefaultImgSrc(element) {
            var defaultSrc = "http://pimg1.126.net/caipiao_info/img/library/t24no.png";
            $(element).attr('src', defaultSrc);
        }
    </script>
</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="#">足球计划</a>
    <div class="collapse navbar-collapse justify-content-between">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/"><i class="fa fa-home">&nbsp;首页</i></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/football/news/list">每日球报</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/analysis/info">赛事分析</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/live/matchs/lastest">比分直播</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/data">大数据</a>
            </li>
            <#--<li class="nav-item">-->
                <#--<a class="nav-link" href="/recommend/">足彩推荐</a>-->
            <#--</li>-->
            <#--<li class="nav-item">-->
                <#--<a class="nav-link" href="#">博彩心得</a>-->
            <#--</li>-->
            <#--<li class="nav-item">-->
                <#--<a class="nav-link" href="#">我的账户</a>-->
            <#--</li>-->
            <#--<li class="nav-item">-->
                <#--<a class="nav-link" href="#">投资收益</a>-->
            <#--</li>-->
        </ul>
        <ul class="navbar-nav">
            <#if user??>
                <li class="nav-item dropdown" style="width: 100px">
                    <a class="nav-link dropdown-toggle text-center" data-toggle="dropdown" href="#">${user.username}</a>
                    <div class="dropdown-menu dropdown-menu-right text-center" style="min-width: 100px;width: 100px;font-size: 1.2vw">
                        <a class="dropdown-item px-2 py-1" href="#">我的账户</a>
                        <a class="dropdown-item px-2 py-1" href="#">修改密码</a>
                        <a class="dropdown-item px-2 py-1" href="#">完善信息</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item px-2 py-1" href="/user/logout?url=${url}">登出</a>
                    </div>
                </li>
            <#else>
            <li class="nav-item">
                <a class="nav-link" href="/login">登录</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/register">注册</a>
            </li>
            </#if>
        </ul>
    </div>
</nav>
<main class="container-fluid">
    <div id="match-items" class="p-2">
        <#list matchTeamInfos>
            <#items as matchTeamInfo>
            <div class="col-4 p-2" style="float: left;">
                <div class="card p-0">
                    <div id="card-head-${matchTeamInfo_index}" class="teamInfo card-header p-0 text-center"
                         style="height: 100px;font-size: 8px" aria-expanded="true">
                        <div class="row m-0 h-100">
                            <div class="col p-0">
                                <div class="col-12 p-1 h-50">
                                    <img src="${matchTeamInfo.teamALogo}" onerror="setDefaultImgSrc(this)">
                                </div>
                                <div class="col-12 pt-1 h-25">${matchTeamInfo.teamA}</div>
                                <div id="rank-host-${matchTeamInfo_index}" class="col-12 p-1 h-25">
                                    排名：总${matchTeamInfo.hostRankingTotal}主${matchTeamInfo.hostRankingHost}</div>
                            </div>
                            <div class="col p-0">
                                <div class="col-12 p-1 h-35" style="font-size: 24px">
                                    ${matchTeamInfo.teamAGoal}&nbsp;:&nbsp;${matchTeamInfo.teamBGoal}
                                </div>
                                <div class="col-12 pt-1 h-20">${matchTeamInfo.statusDesc}</div>
                                <div class="col-12 p-0 pt-1 h-20">${matchTeamInfo.matchDay?date('yyyy-MM-dd')?string('MM-dd')}
                                    &nbsp;&nbsp;&nbsp;&nbsp;${matchTeamInfo.matchTime}</div>
                                <div class="col-12 p-0">
                                    <a id="btn-toggle-${matchTeamInfo_index}"
                                       data-target="#card-content-${matchTeamInfo_index}" data-toggle="collapse"
                                       aria-expanded="true">
                                        <i data-index="${matchTeamInfo_index}"
                                           class="fa fa-angle-double-down fa-3x btn-link icon-updown"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col p-0">
                                <div class="col-12 p-1 h-50">
                                    <img src="${matchTeamInfo.teamBLogo}" onerror="setDefaultImgSrc(this)">
                                </div>
                                <div class="col-12 pt-1 h-25">${matchTeamInfo.teamB}</div>
                                <div id="rank-visit-${matchTeamInfo_index}" class="col-12 p-1 h-25">
                                    排名：总${matchTeamInfo.visitRankingTotal}客${matchTeamInfo.visitRankingVisit}</div>
                            </div>
                        <#--<span class="pt-0 pr-1"><a href="#"><i class="fa fa-refresh"></i></a></span>-->
                        </div>
                    </div>
                    <div style="display: none;">
                        <form id="item-form-${matchTeamInfo_index}">
                            <input name="teamAId" value="${matchTeamInfo.teamAId}">
                            <input name="matchId" value="${matchTeamInfo.matchId}">
                            <input name="teamBId" value="${matchTeamInfo.teamBId}">
                            <input name="teamA" value="${matchTeamInfo.teamA}">
                            <input name="teamB" value="${matchTeamInfo.teamB}">
                            <input name="matchOrder" value="${matchTeamInfo.matchOrder}">
                            <input name="matchDay" value="${matchTeamInfo.matchDay}">
                            <input name="matchDayPart"
                                   value="${matchTeamInfo.matchDay?date('yyyy-MM-dd')?string('MM-dd')}">
                            <input name="matchTime" value="${matchTeamInfo.matchTime}">
                            <input name="matchCode"
                                   value="${matchTeamInfo.matchCode?substring(0,8)?date('yyyyMMdd')?string('yyyy-MM-dd')}">
                        </form>
                    </div>
                    <div id="card-content-${matchTeamInfo_index}" class="collapse hide"
                         aria-labelledby="btn-toggle-${matchTeamInfo_index}">
                        <div class="card-body p-0 information-content">
                            <ul class="nav nav-tabs text-center" style="font-size: 15px">
                                <li class="col p-0 nav-item active">
                                    <a class="nav-link active" href="#timelineEvents-${matchTeamInfo_index}">赛事</a>
                                </li>
                                <li class="col p-0 nav-item">
                                    <a class="nav-link" href="#matchEvent-${matchTeamInfo_index}">战绩</a>
                                </li>
                                <li class="col p-0 nav-item">
                                    <a class="nav-link" href="#information-${matchTeamInfo_index}">情报</a>
                                </li>
                                <li class="col p-0 nav-item">
                                    <a class="nav-link" href="#ranking-${matchTeamInfo_index}">积分</a>
                                </li>
                                <li class="col p-0 nav-item">
                                    <a class="nav-link" href="#odds-${matchTeamInfo_index}">赔率</a>
                                </li>
                                <li class="col p-0 nav-item">
                                    <a class="nav-link" href="#bfindex-${matchTeamInfo_index}">冷热</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div id="timelineEvents-${matchTeamInfo_index}" class="tab-pane active timelineEvents">
                                    <div class="events">
                                        <div id="timeline-event-header-${matchTeamInfo_index}" class="card-header"
                                             data-toggle="collapse"
                                             data-target="#timeline-event-body-${matchTeamInfo_index}">比赛事件&nbsp;<i
                                                class="fa fa-angle-down"></i>
                                        </div>
                                        <div id="timeline-event-body-${matchTeamInfo_index}"
                                             aria-labelledby="#timeline-event-header-${matchTeamInfo_index}"
                                             class="collapse show timeline-event-body">
                                            <div class="card-body p-0" style="font-size: 8px">
                                            <#--<div class="row m-0">-->
                                            <#--<div class="col-5 p-0 text-right"><span class="p-0">加布里埃尔.奥切</span>&nbsp;<i-->
                                            <#--class="fa fa-square text-warning"></i></div>-->
                                            <#--<div class="col-2 p-0 text-center">82</div>-->
                                            <#--<div class="col-5 p-0 text-left"><i-->
                                            <#--class="fa fa-square text-danger"></i>&nbsp;<span class="p-0">霍纳坦.奥罗斯科</span>-->
                                            <#--</div>-->
                                            <#--</div>-->
                                            </div>
                                            <div id="timeline-event-footer-${matchTeamInfo_index}"
                                                 class="card-footer p-0 timeline-event-footer bg-white">
                                                <ul class="nav nav-tabs text-center p-1">
                                                    <li class="col"><i class="fa fa-soccer-ball-o text-dark"></i>&nbsp;进球
                                                    </li>
                                                    <li class="col"><i class="fa fa-soccer-ball-o text-success"></i>&nbsp;点球
                                                    </li>
                                                    <li class="col"><i class="fa fa-soccer-ball-o text-danger"></i>&nbsp;乌龙
                                                    </li>
                                                    <li class="col-3"><i class="fa fa-clone text-warning bg-danger"></i>&nbsp;双黄变红
                                                    </li>
                                                    <li class="col"><i class="fa fa-arrow-up text-success"></i>&nbsp;换入
                                                    </li>
                                                    <li class="col"><i class="fa fa-arrow-down text-warning"></i>&nbsp;换出
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="injure">
                                        <div id="timeline-injure-header-${matchTeamInfo_index}" class="card-header"
                                             data-toggle="collapse"
                                             data-target="#timeline-injure-body-${matchTeamInfo_index}">伤停信息&nbsp;<i
                                                class="fa fa-angle-down"></i>
                                        </div>
                                        <div id="timeline-injure-body-${matchTeamInfo_index}"
                                             aria-labelledby="#timeline-injure-header-${matchTeamInfo_index}"
                                             class="collapse show">
                                            <div class="card-body p-0">
                                                <div class="card hostInjuries">
                                                    <div class="card-header p-0 text-left bg-white">
                                                        <i class="fa fa-circle text-dark"></i>&nbsp;${matchTeamInfo.teamA}
                                                    </div>
                                                    <div class="card-body p-0 text-center" style="font-size: 8px;">
                                                    <#--<div class="row m-0">-->
                                                    <#--<div class="col-1 p-0">37</div>-->
                                                    <#--<div class="col-5 p-0">努涅斯.马尼亚斯</div>-->
                                                    <#--<div class="col-2 p-0">前锋</div>-->
                                                    <#--<div class="col-2 p-0"><i class="fa fa-circle"></i>&nbsp;伤病-->
                                                    <#--</div>-->
                                                    <#--<div class="col-2 p-0">详细</div>-->
                                                    <#--</div>-->
                                                    </div>
                                                </div>
                                                <div class="card visitInjuries">
                                                    <div class="card-header p-0 text-left bg-white">
                                                        <i class="fa fa-circle text-dark"></i>&nbsp;${matchTeamInfo.teamB}
                                                    </div>
                                                    <div class="card-body p-0 text-center" style="font-size: 8px;">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="lineup">
                                        <div id="timeline-lineup-header-${matchTeamInfo_index}" class="card-header"
                                             data-toggle="collapse"
                                             data-target="#timeline-lineup-body-${matchTeamInfo_index}">双方阵容&nbsp;<i
                                                class="fa fa-angle-down"></i>
                                        </div>
                                        <div id="timeline-lineup-body-${matchTeamInfo_index}"
                                             aria-labelledby="#timeline-lineup-header-${matchTeamInfo_index}"
                                             class="collapse show">
                                            <div class="card-body p-0 text-center">
                                                <div class="row m-0">
                                                    <div class="col card p-0">
                                                        <div class="card-header p-0 bg-white">${matchTeamInfo.teamA}</div>
                                                        <div class="host-lineup-detail card-body p-0"
                                                             style="font-size: 8px;">
                                                        <#--<div class="row m-0">-->
                                                        <#--<div class="col-4 p-0">门将</div>-->
                                                        <#--<div class="col-8 p-0">特尔斯特根据</div>-->
                                                        <#--</div>-->
                                                        </div>
                                                    </div>
                                                    <div class="col card p-0">
                                                        <div class="card-header p-0 bg-white">${matchTeamInfo.teamB}</div>
                                                        <div class="visit-lineup-detail card-body p-0"
                                                             style="font-size: 8px;">
                                                        <#--<div class="row m-0">-->
                                                        <#--<div class="col-4 p-0">门将</div>-->
                                                        <#--<div class="col-8 p-0">莫亚</div>-->
                                                        <#--</div>-->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tech">
                                        <div id="timeline-tech-header-${matchTeamInfo_index}" class="card-header"
                                             data-toggle="collapse"
                                             data-target="#timeline-tech-body-${matchTeamInfo_index}">技术统计&nbsp;<i
                                                class="fa fa-angle-down"></i>
                                        </div>
                                        <div id="timeline-tech-body-${matchTeamInfo_index}"
                                             aria-labelledby="#timeline-tech-header-${matchTeamInfo_index}"
                                             class="collapse show">
                                            <div class="card-body p-0 text-center" style="font-size: 8px;">
                                                <div class="card p-0">
                                                    <div class="card-header p-0 bg-white">
                                                        <div class="row m-0">
                                                            <div class="col p-0">${matchTeamInfo.teamA}(主)</div>
                                                            <div class="col p-0">${matchTeamInfo.teamB}(客)</div>
                                                        </div>
                                                    </div>
                                                    <div class="card-body p-0">
                                                        <div class="row m-0">
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="p-0 visitPossessionPercent"></div>
                                                                    <div class="hostPossession hostPossessionPercent progress-bar pr-0"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-2 p-1">控球率</div>
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="visitPossession visitPossessionPercent progress-bar"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                    <div class="p-0 hostPossessionPercent"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row m-0">
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="p-0 visitShootPercent"></div>
                                                                    <div class="hostShoot hostShootPercent progress-bar p-0"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-2 p-1">射门</div>
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="visitShoot visitShootPercent progress-bar"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                    <div class="p-0 hostShootPercent"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row m-0">
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="p-0 visitShotsOnTargetPercent"></div>
                                                                    <div class="hostShotsOnTarget hostShotsOnTargetPercent progress-bar pr-0"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-2 p-1">射正</div>
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="visitShotsOnTarget visitShotsOnTargetPercent progress-bar"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                    <div class="p-0 hostShotsOnTargetPercent"></div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row m-0">
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="p-0 visitDangerousAttackPercent"></div>
                                                                    <div class="hostDangerousAttack hostDangerousAttackPercent progress-bar pr-0"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-2 p-1">危险进攻</div>
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="visitDangerousAttack visitDangerousAttackPercent progress-bar"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                    <div class="p-0 hostDangerousAttackPercent"
                                                                         style="width: 43%"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row m-0">
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="p-0 visitAttackPercent"></div>
                                                                    <div class="hostAttack hostAttackPercent progress-bar pr-0"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-2 p-1">进攻</div>
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="visitAttack visitAttackPercent progress-bar"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                    <div class="p-0 hostAttackPercent"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row m-0">
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="p-0 visitCornerPercent"></div>
                                                                    <div class="hostCorner hostCornerPercent progress-bar pr-0"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-2 p-1">角球</div>
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="visitCorner visitCornerPercent progress-bar"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                    <div class="p-0 hostCornerPercent"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row m-0">
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="p-0 visitFoulPercent"></div>
                                                                    <div class="hostFoul hostFoulPercent progress-bar pr-0"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-2 p-1">犯规</div>
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="visitFoul visitFoulPercent progress-bar"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                    <div class="p-0 hostFoulPercent"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row m-0">
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="p-0 visitYellowCardPercent"></div>
                                                                    <div class="hostYellowCard hostYellowCardPercent progress-bar pr-0"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-2 p-1">黄牌数</div>
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="visitYellowCard visitYellowCardPercent progress-bar"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                    <div class="p-0 hostYellowCardPercent"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row m-0">
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="p-0 visitRedCardPercent"></div>
                                                                    <div class="hostRedCard hostRedCardPercent progress-bar pr-0"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-2 p-1">红牌数</div>
                                                            <div class="col-5 p-1">
                                                                <div class="progress">
                                                                    <div class="visitRedCard visitRedCardPercent progress-bar"
                                                                         role="progressbar" aria-valuemin="0"
                                                                         aria-valuemax="100">
                                                                    </div>
                                                                    <div class="p-0 hostRedCardPercent"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="matchEvent-${matchTeamInfo_index}" class="tab-pane matchEvent">
                                    <div class="history">
                                        <div id="matchEvent-history-header-${matchTeamInfo_index}" class="card-header"
                                             data-toggle="collapse"
                                             data-target="#matchEvent-history-body-${matchTeamInfo_index}">历史交锋&nbsp;<i
                                                class="fa fa-angle-down"></i>
                                        </div>
                                        <div id="matchEvent-history-body-${matchTeamInfo_index}"
                                             aria-labelledby="#matchEvent-history-header-${matchTeamInfo_index}"
                                             class="collapse show matchEvent-history-body">
                                            <div class="card-header p-0" style="font-size: 10px;">
                                                <div class="p-0 text-left bg-white">
                                                    <i class="fa fa-circle text-dark"></i>&nbsp;近10场，${matchTeamInfo.teamA}
                                                    <span class="text-danger"><span
                                                            id="totalWin-history-${matchTeamInfo_index}">0</span>胜</span>
                                                    <span class="text-primary"><span
                                                            id="totalDraw-history-${matchTeamInfo_index}">0</span>平</span>
                                                    <span class="text-success"><span
                                                            id="totalLose-history-${matchTeamInfo_index}">0</span>负</span>；主场
                                                    <span class="text-danger"><span
                                                            id="hostWin-history-${matchTeamInfo_index}">0</span>胜</span>
                                                    <span class="text-primary"><span
                                                            id="hostDraw-history-${matchTeamInfo_index}">0</span>平</span>
                                                    <span class="text-success"><span
                                                            id="hostLose-history-${matchTeamInfo_index}">0</span>负</span>
                                                </div>
                                                <div class="row m-0 p-0 text-center" style="background-color: #e0e0e0">
                                                    <span class="col-2 p-0">赛事</span>
                                                    <span class="col-3 p-0">日期</span>
                                                    <span class="col p-0">主</span>
                                                    <span class="col-1 p-0">比分</span>
                                                    <span class="col p-0">客</span>
                                                    <span class="col-1 p-0">赛果</span>
                                                </div>
                                            </div>
                                            <div id="matchEvent-vs-cardbody-${matchTeamInfo_index}"
                                                 class="card-body p-0 text-center" style="font-size: 8px;">
                                            <#--<div class="row m-0">-->
                                            <#--<span class="col-2 p-0">解放者杯</span>-->
                                            <#--<span class="col-3 p-0">18-02-28</span>-->
                                            <#--<span class="col p-0">竞技</span>-->
                                            <#--<span class="col-1 p-0">4:2</span>-->
                                            <#--<span class="col p-0">克鲁塞罗</span>-->
                                            <#--<span class="col-1 p-0">负</span>-->
                                            <#--</div>-->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="nearly">
                                        <div id="matchEvent-nearly-header-${matchTeamInfo_index}" class="card-header"
                                             data-toggle="collapse"
                                             data-target="#matchEvent-nearly-body-${matchTeamInfo_index}">近期战绩&nbsp;<i
                                                class="fa fa-angle-down"></i>
                                        </div>
                                        <div id="matchEvent-nearly-body-${matchTeamInfo_index}"
                                             aria-labelledby="#matchEvent-nearly-header-${matchTeamInfo_index}"
                                             class="collapse show matchEvent-nearly-body">
                                            <div class="card matchEvent-nearly-host-card p-0">
                                                <div class="card-header p-0 text-left" style="font-size: 10px;">
                                                    <div class="p-0 text-left bg-white">
                                                        <i class="fa fa-circle text-dark"></i>&nbsp;近10场(主)，${matchTeamInfo.teamA}
                                                        <span class="text-danger"><span
                                                                id="host-totalWin-nearly-${matchTeamInfo_index}">0</span>胜</span>
                                                        <span class="text-primary"><span
                                                                id="host-totalDraw-nearly-${matchTeamInfo_index}">0</span>平</span>
                                                        <span class="text-success"><span
                                                                id="host-totalLose-nearly-${matchTeamInfo_index}">0</span>负</span>；主场
                                                        <span class="text-danger"><span
                                                                id="host-hostWin-nearly-${matchTeamInfo_index}">0</span>胜</span>
                                                        <span class="text-primary"><span
                                                                id="host-hostDraw-nearly-${matchTeamInfo_index}">0</span>平</span>
                                                        <span class="text-success"><span
                                                                id="host-hostLose-nearly-${matchTeamInfo_index}">0</span>负</span>
                                                    </div>
                                                    <div class="row m-0 p-0 text-center"
                                                         style="background-color: #e0e0e0">
                                                        <span class="col-2 p-0">赛事</span>
                                                        <span class="col-3 p-0">日期</span>
                                                        <span class="col p-0">主</span>
                                                        <span class="col-1 p-0">比分</span>
                                                        <span class="col p-0">客</span>
                                                        <span class="col-1 p-0">赛果</span>
                                                    </div>
                                                </div>
                                                <div id="matchEvent-nearly-host-cardbody-${matchTeamInfo_index}"
                                                     class="card-body p-0 text-center" style="font-size: 8px;">
                                                </div>
                                            </div>
                                            <div class="card matchEvent-nearly-visit-card p-0">
                                                <div class="card-header p-0 text-left" style="font-size: 10px;">
                                                    <div class="p-0 text-left bg-white">
                                                        <i class="fa fa-circle text-dark"></i>&nbsp;近10场(客)，${matchTeamInfo.teamB}
                                                        <span class="text-danger"><span
                                                                id="visit-totalWin-nearly-${matchTeamInfo_index}">0</span>胜</span>
                                                        <span class="text-primary"><span
                                                                id="visit-totalDraw-nearly-${matchTeamInfo_index}">0</span>平</span>
                                                        <span class="text-success"><span
                                                                id="visit-totalLose-nearly-${matchTeamInfo_index}">0</span>负</span>；客场
                                                        <span class="text-danger"><span
                                                                id="visit-visitWin-nearly-${matchTeamInfo_index}">0</span>胜</span>
                                                        <span class="text-primary"><span
                                                                id="visit-visitDraw-nearly-${matchTeamInfo_index}">0</span>平</span>
                                                        <span class="text-success"><span
                                                                id="visit-visitLose-nearly-${matchTeamInfo_index}">0</span>负</span>
                                                    </div>
                                                    <div class="row m-0 p-0 text-center"
                                                         style="background-color: #e0e0e0">
                                                        <span class="col-2 p-0">赛事</span>
                                                        <span class="col-3 p-0">日期</span>
                                                        <span class="col p-0">主</span>
                                                        <span class="col-1 p-0">比分</span>
                                                        <span class="col p-0">客</span>
                                                        <span class="col-1 p-0">赛果</span>
                                                    </div>
                                                </div>
                                                <div id="matchEvent-nearly-visit-cardbody-${matchTeamInfo_index}"
                                                     class="card-body p-0 text-center" style="font-size: 8px;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="future">
                                        <div id="matchEvent-future-header-${matchTeamInfo_index}" class="card-header"
                                             data-toggle="collapse"
                                             data-target="#matchEvent-future-body-${matchTeamInfo_index}">未来赛事&nbsp;<i
                                                class="fa fa-angle-down"></i>
                                        </div>
                                        <div id="matchEvent-future-body-${matchTeamInfo_index}"
                                             aria-labelledby="#matchEvent-future-header-${matchTeamInfo_index}"
                                             class="collapse show matchEvent-future-body">
                                            <div class="card matchEvent-future-host-card p-0">
                                                <div class="card-header p-0 text-left" style="font-size: 10px;">
                                                    <div class="p-0 text-left bg-white">
                                                        <i class="fa fa-dot-circle-o text-dark"></i>&nbsp;${matchTeamInfo.teamA}
                                                    </div>
                                                    <div class="row m-0 p-0 text-center"
                                                         style="background-color: #e0e0e0">
                                                        <span class="col-2 p-0">赛事</span>
                                                        <span class="col-3 p-0">日期</span>
                                                        <span class="col p-0">主</span>
                                                        <span class="col-1 p-0"></span>
                                                        <span class="col p-0">客</span>
                                                        <span class="col-1 p-0">赛果</span>
                                                    </div>
                                                </div>
                                                <div id="matchEvent-future-host-cardbody-${matchTeamInfo_index}"
                                                     class="card-body p-0 text-center" style="font-size: 8px;">
                                                </div>
                                            </div>
                                            <div class="card matchEvent-future-visit-card p-0">
                                                <div class="card-header p-0 text-left bg-white"
                                                     style="font-size: 10px;">
                                                    <div class="p-0 text-left bg-white">
                                                        <i class="fa fa-dot-circle-o text-dark"></i>&nbsp;${matchTeamInfo.teamB}
                                                    </div>
                                                    <div class="row m-0 p-0 text-center"
                                                         style="background-color: #e0e0e0">
                                                        <span class="col-2 p-0">赛事</span>
                                                        <span class="col-3 p-0">日期</span>
                                                        <span class="col p-0">主</span>
                                                        <span class="col-1 p-0"></span>
                                                        <span class="col p-0">客</span>
                                                        <span class="col-1 p-0">赛果</span>
                                                    </div>
                                                </div>
                                                <div id="matchEvent-future-visit-cardbody-${matchTeamInfo_index}"
                                                     class="card-body p-0 text-center" style="font-size: 8px;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="information-${matchTeamInfo_index}" class="tab-pane h-100">
                                </div>
                                <div id="ranking-${matchTeamInfo_index}" class="tab-pane">
                                    <div class="btn-group nav nav-tabs col justify-content-center" role="group"
                                         style="padding: .5rem .5rem;">
                                        <a href="#totalPoint-${matchTeamInfo_index}"
                                           class="btn btn-sm btn-light active">总积分</a>
                                        <a href="#hostPoint-${matchTeamInfo_index}"
                                           class="btn btn-sm btn-light">主场积分</a>
                                        <a href="#guestPoint-${matchTeamInfo_index}"
                                           class="btn btn-sm btn-light">客场积分</a>
                                    </div>
                                    <div class="tab-content ranking">
                                        <div id="totalPoint-${matchTeamInfo_index}" class="tab-pane active totalPoint">
                                            <div id="totalPoint-header-${matchTeamInfo_index}" class="card-header"
                                                 data-toggle="collapse"
                                                 data-target="#totalPoint-body-${matchTeamInfo_index}">
                                                <span id="totalPoint-title-${matchTeamInfo_index}"></span>&nbsp;<i
                                                    class="fa fa-angle-down"></i>
                                            </div>
                                            <div id="totalPoint-body-${matchTeamInfo_index}"
                                                 aria-labelledby="#totalPoint-header-${matchTeamInfo_index}"
                                                 class="collapse show">
                                                <div class="card-header p-0 text-center bg-white"
                                                     style="font-size: 10px;">
                                                    <div class="row m-0">
                                                        <span class="col p-0">排名</span>
                                                        <span class="col-2 p-0">球队</span>
                                                        <span class="col p-0">已赛</span>
                                                        <span class="col p-0">胜</span>
                                                        <span class="col p-0">平</span>
                                                        <span class="col p-0">负</span>
                                                        <span class="col p-0">进</span>
                                                        <span class="col p-0">失</span>
                                                        <span class="col p-0">净</span>
                                                        <span class="col p-0">积分</span>
                                                    </div>
                                                </div>
                                                <div id="totalPoint-cardbody-${matchTeamInfo_index}"
                                                     class="card-body p-0 text-center bg-white"
                                                     style="font-size: 8px;">
                                                <#--<div class="row m-0">-->
                                                <#--<span class="col p-0">3</span>-->
                                                <#--<span class="col-2 p-0">皇家马德里</span>-->
                                                <#--<span class="col p-0">37</span>-->
                                                <#--<span class="col p-0">22</span>-->
                                                <#--<span class="col p-0">9</span>-->
                                                <#--<span class="col p-0">6</span>-->
                                                <#--<span class="col p-0">92</span>-->
                                                <#--<span class="col p-0">42</span>-->
                                                <#--<span class="col p-0">50</span>-->
                                                <#--<span class="col p-0">75</span>-->
                                                <#--</div>-->
                                                </div>
                                            </div>
                                        </div>
                                        <div id="hostPoint-${matchTeamInfo_index}" class="tab-pane hostPoint">
                                            <div id="hostPoint-header-${matchTeamInfo_index}" class="card-header"
                                                 data-toggle="collapse"
                                                 data-target="#hostPoint-body-${matchTeamInfo_index}">
                                                <span id="hostPoint-title-${matchTeamInfo_index}"></span>&nbsp;<i
                                                    class="fa fa-angle-down"></i>
                                            </div>
                                            <div id="hostPoint-body-${matchTeamInfo_index}"
                                                 aria-labelledby="#hostPoint-header-${matchTeamInfo_index}"
                                                 class="collapse show">
                                                <div class="card-header p-0 text-center bg-white"
                                                     style="font-size: 10px;">
                                                    <div class="row m-0">
                                                        <span class="col p-0">排名</span>
                                                        <span class="col-2 p-0">球队</span>
                                                        <span class="col p-0">已赛</span>
                                                        <span class="col p-0">胜</span>
                                                        <span class="col p-0">平</span>
                                                        <span class="col p-0">负</span>
                                                        <span class="col p-0">进</span>
                                                        <span class="col p-0">失</span>
                                                        <span class="col p-0">净</span>
                                                        <span class="col p-0">积分</span>
                                                    </div>
                                                </div>
                                                <div id="hostPoint-cardbody-${matchTeamInfo_index}"
                                                     class="card-body p-0 text-center bg-white"
                                                     style="font-size: 8px;">
                                                <#--<div class="row m-0">-->
                                                <#--<span class="col p-0">1</span>-->
                                                <#--<span class="col-2 p-0">巴伦西亚</span>-->
                                                <#--<span class="col p-0">37</span>-->
                                                <#--<span class="col p-0">21</span>-->
                                                <#--<span class="col p-0">7</span>-->
                                                <#--<span class="col p-0">9</span>-->
                                                <#--<span class="col p-0">63</span>-->
                                                <#--<span class="col p-0">37</span>-->
                                                <#--<span class="col p-0">26</span>-->
                                                <#--<span class="col p-0">70</span>-->
                                                <#--</div>-->
                                                </div>
                                            </div>
                                        </div>
                                        <div id="guestPoint-${matchTeamInfo_index}" class="tab-pane guestPoint">
                                            <div id="guestPoint-header-${matchTeamInfo_index}" class="card-header"
                                                 data-toggle="collapse"
                                                 data-target="#guestPoint-body-${matchTeamInfo_index}">
                                                <span id="guestPoint-title-${matchTeamInfo_index}"></span>&nbsp;<i
                                                    class="fa fa-angle-down"></i>
                                            </div>
                                            <div id="guestPoint-body-${matchTeamInfo_index}"
                                                 aria-labelledby="#guestPoint-header-${matchTeamInfo_index}"
                                                 class="collapse show">
                                                <div class="card-header p-0 text-center bg-white"
                                                     style="font-size: 10px;">
                                                    <div class="row m-0">
                                                        <span class="col p-0">排名</span>
                                                        <span class="col-2 p-0">球队</span>
                                                        <span class="col p-0">已赛</span>
                                                        <span class="col p-0">胜</span>
                                                        <span class="col p-0">平</span>
                                                        <span class="col p-0">负</span>
                                                        <span class="col p-0">进</span>
                                                        <span class="col p-0">失</span>
                                                        <span class="col p-0">净</span>
                                                        <span class="col p-0">积分</span>
                                                    </div>
                                                </div>
                                                <div id="guestPoint-cardbody-${matchTeamInfo_index}"
                                                     class="card-body p-0 text-center bg-white"
                                                     style="font-size: 8px;">
                                                <#--<div class="row m-0">-->
                                                <#--<span class="col p-0">3</span>-->
                                                <#--<span class="col-2 p-0">皇家马德里</span>-->
                                                <#--<span class="col p-0">37</span>-->
                                                <#--<span class="col p-0">22</span>-->
                                                <#--<span class="col p-0">9</span>-->
                                                <#--<span class="col p-0">6</span>-->
                                                <#--<span class="col p-0">92</span>-->
                                                <#--<span class="col p-0">42</span>-->
                                                <#--<span class="col p-0">50</span>-->
                                                <#--<span class="col p-0">75</span>-->
                                                <#--</div>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="odds-${matchTeamInfo_index}" class="tab-pane odds">
                                    <div class="btn-group nav nav-tabs col justify-content-center" role="group"
                                         style="padding: .5rem .5rem;">
                                        <a href="#europeOdds-${matchTeamInfo_index}" class="btn btn-sm btn-light">欧赔</a>
                                        <a href="#asiaOdds-${matchTeamInfo_index}" class="btn btn-sm btn-light active">亚盘</a>
                                        <a href="#sizeOdds-${matchTeamInfo_index}" class="btn btn-sm btn-light">大小盘</a>
                                    </div>
                                    <div class="tab-content">
                                        <div id="europeOdds-${matchTeamInfo_index}" class="tab-pane europeOdds">
                                            <div id="europeOdds-body-${matchTeamInfo_index}">
                                                <div class="card-header p-0 text-center bg-white"
                                                     style="font-size: 10px;">
                                                    <div class="row m-0">
                                                        <span class="col-3 p-0">公司</span>
                                                        <span class="col p-0">初始盘口</span>
                                                        <span class="col p-0">即时盘口</span>
                                                    </div>
                                                </div>
                                                <div id="europeOdds-cardbody-${matchTeamInfo_index}"
                                                     class="card-body p-0 text-center bg-white"
                                                     style="font-size: 8px;">
                                                <#--<div class="row m-0">-->
                                                <#--<div class="col-3 p-0">99家平均</div>-->
                                                <#--<div class="col-4 p-0">-->
                                                <#--<span class="col p-1">1.48</span>-->
                                                <#--<span class="col p-1">4.90</span>-->
                                                <#--<span class="col p-1">6.85</span>-->
                                                <#--</div>-->
                                                <#--<div class="col-5 p-0">-->
                                                <#--<span class="col p-1">1.48</span>-->
                                                <#--<span class="col p-1">4.90</span>-->
                                                <#--<span class="col p-1">6.85</span>-->
                                                <#--<a class="col p-0"><i class="fa fa-angle-right"></i></a>-->
                                                <#--</div>-->
                                                <#--</div>-->
                                                </div>
                                            </div>
                                        </div>
                                        <div id="asiaOdds-${matchTeamInfo_index}" class="tab-pane active asiaOdds">
                                            <div id="asiaOdds-body-${matchTeamInfo_index}">
                                                <div class="card-header p-0 text-center bg-white"
                                                     style="font-size: 10px;">
                                                    <div class="row m-0">
                                                        <span class="col-2 p-0">公司</span>
                                                        <span class="col p-0">初始赔率</span>
                                                        <span class="col p-0">即时赔率</span>
                                                    </div>
                                                </div>
                                                <div id="asiaOdds-cardbody-${matchTeamInfo_index}"
                                                     class="card-body p-0 text-center bg-white"
                                                     style="font-size: 8px;">
                                                <#--<div class="row m-0">-->
                                                <#--<div class="col-3 p-0">澳门彩票</div>-->
                                                <#--<div class="col-4 p-0">-->
                                                <#--<span class="col-1 p-1">2.06</span>-->
                                                <#--<span class="col-2 p-1">半球</span>-->
                                                <#--<span class="col-1 p-1">1.64</span>-->
                                                <#--</div>-->
                                                <#--<div class="col-5 p-0">-->
                                                <#--<span class="col-1 p-1">1.72</span>-->
                                                <#--<span class="col-2 p-1">平手/半球</span>-->
                                                <#--<span class="col-1 p-1">2.16</span>-->
                                                <#--<span class="col-1 p-1">-->
                                                <#--&nbsp;<i class="fa fa-angle-right"></i>-->
                                                <#--</span>-->
                                                <#--</div>-->
                                                <#--</div>-->
                                                </div>
                                            </div>
                                        </div>
                                        <div id="sizeOdds-${matchTeamInfo_index}" class="tab-pane sizeOdds">
                                            <div id="sizeOdds-body-${matchTeamInfo_index}">
                                                <div class="card-header p-0 text-center bg-white"
                                                     style="font-size: 10px;">
                                                    <div class="row m-0">
                                                        <span class="col-3 p-0">公司</span>
                                                        <span class="col p-0">初始盘口</span>
                                                        <span class="col p-0">即时盘口</span>
                                                    </div>
                                                </div>
                                                <div id="sizeOdds-cardbody-${matchTeamInfo_index}"
                                                     class="card-body p-0 text-center bg-white"
                                                     style="font-size: 8px;">
                                                <#--<div class="row m-0">-->
                                                <#--<div class="col-3 p-0">立博</div>-->
                                                <#--<div class="col-4 p-0">-->
                                                <#--<span class="col p-1">1.70</span>-->
                                                <#--<span class="col p-1">2.5/3</span>-->
                                                <#--<span class="col p-1">1.92</span>-->
                                                <#--</div>-->
                                                <#--<div class="col-5 p-0">-->
                                                <#--<span class="col p-1">1.70</span>-->
                                                <#--<span class="col p-1">2.5/3</span>-->
                                                <#--<span class="col p-1">1.92</span>-->
                                                <#--<a class="col p-0"><i class="fa fa-angle-right"></i></a>-->
                                                <#--</div>-->
                                                <#--</div>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="bfindex-${matchTeamInfo_index}" class="tab-pane h-100 bfindex">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </#items>
        </#list>
    </div>
</main>
</body>

<script src="/production/bootstrap/js/popper.min.js"></script>
<script src="/production/bootstrap/js/bootstrap.min.js"></script>
<script src="/custom/js/analysis.js"></script>
</html>