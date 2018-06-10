<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="refresh" content="30">
    <!--<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">-->
    <title>ScoreLive</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="/production/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/custom/css/scorelive.css">
    <link rel="stylesheet" href="/production/font-awesome/css/font-awesome.min.css">
</head>

<body>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="#">玩个球</a>
    <div class="collapse navbar-collapse justify-content-between">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/"><i class="fa fa-home">&nbsp;首页</i></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/football/news/list">每日球报</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/analysis/info">赛事分析</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/live/matchs/lastest">比分直播</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/data">大数据</a>
            </li>
            <#--<li class="nav-item">-->
                <#--<a class="nav-link" href="#">足彩推荐</a>-->
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
                <li class="nav-item dropdown" style="width: 165px">
                    <a class="nav-link dropdown-toggle text-center" data-toggle="dropdown" href="#">${user.username}</a>
                    <div class="dropdown-menu dropdown-menu-right text-center" style="min-width: 100px;width: 165px;font-size: 1.2vw">
                        <a class="dropdown-item px-2 py-1" href="#">我的账户</a>
                        <a class="dropdown-item px-2 py-1" href="#" data-toggle="modal" data-target="#resetPassword">修改密码</a>
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
<main role="main">
    <div class="container-fluid">
        <div class="card matchBox">
            <div class="card-header text-center">
                <form>
                    <div class="dropdown date" style="display: inline-block;">
                        <button class="btn btn-sm dropdown-toggle" style="width: 156px;" type="button"
                                id="dropdownDate" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        ${currentPeriod!'比赛日期'}
                        </button>
                        <div id="dateMenus" class="dropdown-menu" aria-labelledby="dropdownDate">
                        </div>
                    </div>
                    <div id="timeOption" class="dropdown time" style="display: inline-block;">
                        <button class="btn btn-sm dropdown-toggle" style="width: 150px;" type="button"
                                id="dropdownTime" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            比赛时间
                        </button>

                        <div class="dropdown-menu" aria-labelledby="dropdownTime">
                        <#--<div class="dropdown-header p-1 text-center" style="font-size: 8px">-->
                        <#--<label class="row m-0">-->
                        <#--<a class="col p-0">全选</a>-->
                        <#--<a class="col p-0">全不选</a>-->
                        <#--</label>-->
                        <#--</div>-->
                        <#--<div class="dropdown-body">-->
                            <#list times>
                                <#items as time>
                                    <span class="dropdown-item time-item"><input class="timeCheckbox" type="checkbox"
                                                                                 checked> ${time}</span>
                                </#items>
                            </#list>
                        <#--</div>-->
                        </div>
                    </div>
                    <div class="dropdown date" style="display: inline-block;">
                        <button class="btn btn-sm dropdown-toggle" style="width: 150px;" type="button"
                                id="dropdownMatch" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            赛事筛选
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMatch">
                            <#list leagues>
                                <#items as league>
                                    <span class="dropdown-item league-item"><input class="leagueCheckbox"
                                                                                   type="checkbox"
                                                                                   checked> ${league}</span>
                                </#items>
                            </#list>
                        </div>
                    </div>
                    <div class="dropdown date" style="display: inline-block;">
                        <button class="btn btn-sm dropdown-toggle" style="width: 150px;" type="button"
                                id="dropdownStatus" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            比赛状态
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownStatus">
                            <span class="dropdown-item status-item"><input class="statusCheckbox" type="checkbox"
                                                                           checked> <span>已结束</span></span>
                            <span class="dropdown-item status-item"><input class="statusCheckbox" type="checkbox"
                                                                           checked> <span>未开赛</span></span>
                            <span class="dropdown-item status-item"><input class="statusCheckbox" type="checkbox"
                                                                           checked> <span>进行中</span></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="card-header pt-0 pb-0 match-header">
                <div class="row item-header">
                    <div class="col matchDetail">
                        <div class="row align-items-center" style="height: 30px">
                            <div class="period col-3">场次</div>
                            <div class="events col-3">赛事</div>
                            <div class="round col-3">轮次</div>
                            <div class="playTime col-3">比赛时间</div>
                        </div>
                    </div>
                    <div class="col-5 vsDetail">
                        <div class="row align-items-center" style="height: 30px">
                            <div class="host col">(排名)主队</div>
                            <div class="score col-2">比分</div>
                            <div class="guest col">客队(排名)</div>
                        </div>
                    </div>
                    <div class="col analyzeDetail">
                        <div class="row align-items-center" style="height: 30px">
                            <div class="status col">状态</div>
                            <div class="result col">赛果</div>
                            <div class="half col">半场</div>
                            <div class="half col">全场</div>
                            <div class="status col">让球</div>
                            <div class="results col">彩果</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body pt-0 pb-0 match-body">
                <#list matchInfos>
                    <#items as matchInfo>
                        <div class="row item-body row-optional">
                            <input class="league-hidden-input" type="hidden" value="${matchInfo.leagueName}">
                            <input class="time-hidden-input" type="hidden" value="${matchInfo.matchTime}">
                            <input class="status-hidden-input" type="hidden" value="${matchInfo.statusDesc}">
                            <input class="matchstatus-hidden-input" type="hidden" value="${matchInfo.matchStatus}">
                            <div class="col matchDetail">
                                <div class="row align-items-center" style="height: 35px">
                                    <div class="period col-3">${matchInfo.matchOrder}</div>
                                    <div class="events col-3">${matchInfo.leagueName}</div>
                                    <div class="round col-3">${matchInfo.round}</div>
                                    <div class="playTime col-3">${matchInfo.matchTime}</div>
                                </div>
                            </div>
                            <div class="col-5 vsDetail">
                                <div class="row align-items-center" style="height: 35px">
                                    <div class="host col">
                                        <div class="col-8 text-right" style="display: inline-block;">
                                            <#if matchInfo.hostYellowCard != 0 >
                                                <span class="yellowNum badge badge-warning">${matchInfo.hostYellowCard}</span>
                                            </#if>
                                            <#if matchInfo.hostRedCard != 0 >
                                                <span class="redCardNum badge badge-danger">${matchInfo.hostRedCard}</span>
                                            </#if>
                                            <span class="teamName">${matchInfo.teamA}&nbsp;</span>
                                        </div>
                                        <div class="col-2" style="display: inline-block;">
                                            <img src="${matchInfo.teamALogo!'http://pimg1.126.net/caipiao_info/img/library/t24no.png'}">
                                        </div>
                                    </div>
                                    <div class="score col-1">
                                        <span class="score">${matchInfo.score}</span>
                                    </div>
                                    <div class="guest col">
                                        <div class="col-2" style="display: inline-block;">
                                            <img src="${matchInfo.teamBLogo!'http://pimg1.126.net/caipiao_info/img/library/t24no.png'}">
                                        </div>
                                        <div class="col-8 text-left" style="display: inline-block;">
                                            <span class="teamName">&nbsp;${matchInfo.teamB}</span>
                                            <#if matchInfo.visitRedCard != 0 >
                                                <span class="yellowNum badge badge-danger">${matchInfo.visitRedCard}</span>
                                            </#if>
                                            <#if matchInfo.visitYellowCard != 0 >
                                                <span class="redNum badge badge-warning">${matchInfo.visitYellowCard}</span>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col analyzeDetail">
                                <div class="row align-items-center" style="height: 35px">
                                    <div class="status col">${matchInfo.statusDesc}</div>
                                    <div class="result col">
                                        <#if matchInfo.score?length gt 2>

                                                <#if matchInfo.score?split(":")[0]?number gt matchInfo.score?split(":")[1]?number>
                                                   <span class="text-danger">胜</span>
                                                <#elseif matchInfo.score?split(":")[0]?number lt matchInfo.score?split(":")[1]?number>
                                                    <span class="text-success">负</span>
                                                <#else>
                                                    <span class="text-info">平</span>
                                                </#if>

                                        </#if>
                                    </div>
                                    <div class="half col">
                                        <span>${matchInfo.halfScore}</span>
                                    </div>
                                    <div class="full col"><span>
                                        <span>${matchInfo.score}</span>
                                    </div>
                                    <div class="concede col">${matchInfo.concede}</div>
                                    <div class="results col <#if matchInfo.bidScore == '胜'>text-danger<#elseif matchInfo.bidScore == '平'>text-info<#else>text-success</#if>">
                                        ${matchInfo.bidScore}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#items>
                </#list>

            </div>
            <div class="card-footer">
                <ul class="list-unstyled">
                    <li>
                        筛选菜单：选择比赛时间、赛事筛选、状态可对赛事类别进行隐藏/显示切换。
                    </li>
                    <li>
                        比分直播提示：以上比分数据仅供浏览、投注参考之用，并不作为最终派奖赛果依据。
                    </li>
                </ul>
            </div>
        </div>
    </div>
</main>
<div class="modal fade" id="resetPassword" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">重置密码</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="input-group mb-3">
                    <input id="bindEmail" type="text" class="form-control" placeholder="请输入邮箱地址">
                    <div class="input-group-append">
                        <a href="#">
                            <button id="resetBtn" class="btn btn-outline-secondary" type="button">发送邮件</button>
                        </a>
                    </div>
                </div>
                <div id="tip" style="font-size: 1.2vw;text-align: center"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
    </div>
</div>
</body>
<script src="/production/jquery/jquery.min.js"></script>
<script src="/production/bootstrap/js/popper.min.js"></script>
<script src="/production/bootstrap/js/bootstrap.min.js"></script>
<script src="/custom/js/scorelive.js"></script>
<script src="/custom/js/repass.js"></script>
</html>
