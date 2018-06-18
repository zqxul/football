<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel='stylesheet' href='../production/bootstrap/css/bootstrap.min.css'>
    <link rel='stylesheet' href='../production/font-awesome/css/font-awesome.min.css'>
    <link rel="stylesheet" href="../custom/css/recommend.css">
    <script src="../production/jquery/jquery.min.js"></script>
    <title>Recommend</title>
</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="#">玩个球</a>
    <div class="collapse navbar-collapse justify-content-between">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/football/news/list">每日球报</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/analysis/info">赛事分析</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/live/matchs/lastest">比分直播</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/data">大数据</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#">足彩推荐</a>
            </li>
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
                    <div class="dropdown-menu dropdown-menu-right text-center"
                         style="min-width: 100px;width: 165px;font-size: 1.2vw">
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
<main class="container-fluid">
    <div class="p-3">
        <div class="row m-0 border">
            <div class="col-1 p-2 m-auto">
                <div class="row m-0">
                    <span>红人榜<i class="fa fa-bookmark text-danger"></i></span>
                </div>
                <div class="row m-0">
                    <span class="text-warning">Top50</span>
                </div>
            </div>
            <div class="col-11">
                <div id="hotmanRow" class="row m-0 p-2 border d-inline-block">
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                    <div class="my-auto mx-1 py-1 border d-inline-block text-center hotman">
                        <div class="row m-0 mb-1 h-50">
                    <span class="w-100">
                    <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139">
                    </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">快樂的小王子</span></div>
                        <div class="row m-0 h-25"><span class="w-100">总勝率:80％&nbsp;近5中5</span></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row m-0 border">
            <div class="col-8 p-0 border">
                <div class="m-auto p-2 text-right" style="height: 60px;background-color: rgba(0, 0, 0, .03);">
                    <div class="row m-0 w-100 justify-content-between">
                        <div class="col-2 px-4 text-left m-auto">
                            <span class="font-weight-bold">高手推荐</span>
                        </div>
                        <div class="col-2 p-0 mx-1 dropdown w-100" style="display: inline-block;">
                            <button class="btn btn-sm dropdown-toggle w-100" type="button"
                                    id="recommendLeagueDropdown" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false">
                                赛事筛选
                            </button>
                            <div id="recommendLeague" class="dropdown-menu w-100" style="min-width: 100%"
                                 aria-labelledby="recommendLeagueDropdown">
                                <#list leagues>
                                    <#items as league>
                                        <#if league??>
                                    <span class="dropdown-item league-item">
                                        <input class="leagueCheckbox" type="checkbox"
                                               onchange="resetRecommendListDiv(this)"
                                               checked>
                                        <span class="m-0 ml-2 leagueName" style="font-size: 1.2vw">${league}</span>
                                    </span>
                                        </#if>
                                    </#items>
                                </#list>
                            </div>
                        </div>
                        <div class="col-2 p-0 mx-1 dropdown w-100" style="display: inline-block;">
                            <button class="btn btn-sm dropdown-toggle w-100" type="button"
                                    id="recommendAuthorDropdown" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false">
                                作者筛选
                            </button>
                            <div id="recommendAuthor" class="dropdown-menu w-100" style="min-width: 100%"
                                 aria-labelledby="recommendAuthorDropdown">
                                <#list authors>
                                    <#items as author>
                                        <#if author??>
                                        <span class="dropdown-item author-item">
                                            <input class="authorCheckbox" type="checkbox"
                                                   onchange="resetAuthorListDiv(this)"
                                                   checked>
                                            <span class="m-0 ml-2 authorname" style="font-size: 1.2vw">${author}</span>
                                        </span>
                                        </#if>
                                    </#items>
                                </#list>
                            </div>
                        </div>
                        <div class="col p-0"></div>
                        <div class="col-2 p-0 text-center">
                            <button type="button" class="btn btn-primary btn-sm" data-toggle="modal"
                                    data-target="#recommendModal">
                                我要推荐
                            </button>
                        </div>
                    </div>
                </div>
                <div id="recommendDiv" class="p-3" style="height: 600px;overflow: auto">
                    <#list recommends>
                        <#items as recommend>
                    <div class="row m-2 border recommendRow" leaguename="${recommend.leagueName}"
                         authorname="${recommend.createBy!""}">
                        <div class="col-6 p-2 my-auto">
                            <div class="row m-0 text-center" style="font-size: .6vw">
                                <div class="col p-1">
                                    <div class="row m-0 h-100">
                                        <div class="p-0 m-auto">${recommend.host}</div>
                                    </div>
                                </div>
                                <div class="col-6 p-1 m-auto">
                                    <div class="col p-0 my-1">${recommend.leagueName}</div>
                                    <div class="col p-0 my-1">${recommend.matchTime?datetime('yyyy-MM-dd HH:mm:ss')?string('MM-dd HH:mm')}</div>
                                </div>
                                <div class="col p-1">
                                    <div class="row m-0 h-100">
                                        <div class="p-0 m-auto">${recommend.visit}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-2 p-0 border-left">
                            <div class="row m-0 h-100 text-center">
                                <div class="p-2 my-auto w-100">
                                    <span class="px-2">
                                        ${recommend.price}&nbsp;<i class="fa fa-stop-circle-o text-warning"></i>
                                    </span>
                                    <span class="px-2" style="display: none">免费</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-3 p-1 border-left">
                            <div class="row m-0 h-100 text-center" style="font-size: 1vw">
                                <div class="p-0 m-auto">
                                    作者：<span class="author text-center">${recommend.createBy!""}</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 p-0 my-auto">
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal"
                                    data-target="#viewModal">查看
                            </button>
                        </div>
                    </div>
                        </#items>
                    </#list>
                </div>
            </div>
            <div class="col-4 pl-2 py-2 pr-0 border">
                <div class="row m-0 justify-content-between">
                    <div class="col-6 p-0 border-bottom text-center"><span class="m-auto"><i class="fa fa-mortar-board">&nbsp;風雲榜<sub
                            class="p-0 font-weight-bold"
                            style="font-size: .1vw;color: #af8814a1 !important;">Top50</sub></i></span></div>
                    <div class="col-6 p-0 recommend-panel">
                        <ul class="nav nav-tabs text-center" style="font-size: 15px">
                            <li class="col p-0 nav-item active">
                                <a class="p-1 nav-link active" href="#totalRanking">总榜</a>
                            </li>
                            <li class="col p-0 nav-item">
                                <a class="p-1 nav-link" href="#monthRanking">月榜</a>
                            </li>
                            <li class="col p-0 nav-item">
                                <a class="p-1 nav-link" href="#weekRanking">周榜</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="tab-content">
                    <div id="totalRanking" class="p-2 tab-pane active text-center" style="font-size: 1.2vw">
                        <div class="row mx-0 my-2 p-2 border">
                            <span class="col-2 px-0">1</span>
                            <span class="col-4 px-0">追风少年q</span>
                            <span class="col-3 px-0">胜率:<span class="mx-0">90%</span></span>
                            <span class="col-2 px-0"><i class="fa fa-ship" style="color: #f0c231;"></i></span>
                            <span class="col-1"></span>
                        </div>
                        <div class="row mx-0 my-2 p-2 border">
                            <span class="col-2 px-0">2</span>
                            <span class="col-4 px-0">追风少年2</span>
                            <span class="col-3 px-0">胜率:<span class="mx-0">87%</span></span>
                            <span class="col-2 px-0"><i class="fa fa-ship" style="color: #cfceca"></i></span>
                            <span class="col-1"></span>
                        </div>
                        <div class="row mx-0 my-2 p-2 border">
                            <span class="col-2 px-0">3</span>
                            <span class="col-4 px-0">追风少年3</span>
                            <span class="col-3 px-0">胜率:<span class="mx-0">80%</span></span>
                            <span class="col-2 px-0"><i class="fa fa-ship" style="color: #b4a683"></i></span>
                            <span class="col-1"></span>
                        </div>
                        <div class="row mx-0 my-2 p-2 border">
                            <span class="col-2 px-0">4</span>
                            <span class="col-4 px-0">追风少年4</span>
                            <span class="col-3 px-0">胜率:<span class="mx-0">60%</span></span>
                            <span class="col-2 px-0"><i class="fa fa-ship" style="color: #979e97"></i></span>
                            <span class="col-1"></span>
                        </div>
                    </div>
                    <div id="monthRanking" class="tab-pane">月榜</div>
                    <div id="weekRanking" class="tab-pane">周榜</div>
                </div>
            </div>
        </div>
    </div>

</main>
<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="viewModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewModalTitle">推荐信息</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                推荐信息
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="recommendModal" tabindex="-1" role="dialog" aria-labelledby="recommendModalTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header p-2" style="font-size: 1.2vw">
                <div class="row m-0 w-100 justify-content-between">
                    <div class="col-4 p-1">
                        <div class="dropdown w-100" style="display: inline-block;">

                            <button class="btn btn-sm dropdown-toggle w-100" type="button"
                                    id="dropdownMatch" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false">
                                赛事筛选
                            </button>
                            <div id="leagueSelection" class="dropdown-menu w-100" aria-labelledby="dropdownMatch"></div>
                        </div>
                    </div>
                    <div class="col-6 p-1">
                        <div id="matchSelection" class="dropdown w-100" style="display: inline-block;">
                            <button class="btn btn-sm dropdown-toggle pr-4 w-100 dropdownPosition" type="button"
                                    id="teamVS" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                选择比赛
                            </button>
                            <div id="teamsMenus" class="dropdown-menu w-100" aria-labelledby="dropdownDate"></div>
                        </div>
                    </div>
                    <div class="col p-1"></div>
                    <div class="col-1">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>

            </div>
            <form id="recommendForm" style="display: none">
                <input type="hidden" id="userId" name="userId" value="<#if user??>${user.id}</#if>"/>
                <input type="hidden" id="username" name="username" value="<#if user??>${user.username}</#if>"/>
                <input type="hidden" id="matchId" name="matchId"/>
                <input type="hidden" id="leagueName" name="leagueName"/>
                <input type="hidden" id="hostName" name="hostName"/>
                <input type="hidden" id="visitName" name="visitName"/>
                <input type="hidden" id="matchTime" name="matchTime"/>
                <input type="hidden" id="recommendType" name="recommendType" value="1"/>
                <input type="hidden" id="recommendValue" name="recommendValue"/>
                <input type="hidden" id="handicap" name="handicap"/>
                <input type="hidden" id="handicapValue" name="handicapValue"/>
                <input type="hidden" id="recommendReason" name="recommendReason"/>
                <input type="hidden" id="recommendPrice" name="recommendPrice" value="0"/>
            </form>
            <div class="modal-body p-0">
                <div class="p-0">
                    <div id="odds" class="tab-pane recommend-panel">
                        <div class="btn-group nav nav-tabs col justify-content-center border-0" role="group"
                             style="padding: .5rem .5rem;">
                            <a href="#europeOdds" recommendtype="1" class="btn btn-sm btn-light active">欧赔</a>
                            <a href="#asiaOdds" recommendtype="2" class="btn btn-sm btn-light">亚盘</a>
                            <a href="#sizeOdds" recommendtype="3" class="btn btn-sm btn-light">大小盘</a>
                        </div>
                        <div class="tab-content p-0">
                            <div id="europeOdds" class="tab-pane active">
                                <div class="card-header py-1 text-center"
                                     style="font-size: 1.2vw;max-height: 200px;overflow-y: auto">
                                    欧赔选项
                                </div>
                                <div id="europeOddsRows" class="card-body p-2 text-center bg-white"
                                     style="font-size: 10px;"></div>
                            </div>
                            <div id="asiaOdds" class="tab-pane">
                                <div class="card-header py-1 text-center"
                                     style="font-size: 1.2vw">亚盘选项
                                </div>
                                <div id="asiaOddsRows" class="card-body p-2 text-center bg-white"
                                     style="font-size: 10px;max-height: 200px;overflow-y: auto"></div>
                            </div>
                            <div id="sizeOdds" class="tab-pane">
                                <div class="card-header py-1 text-center"
                                     style="font-size: 1.2vw">大小球选项
                                </div>
                                <div id="sizeOddsRows" class="card-body p-2 text-center bg-white"
                                     style="font-size: 10px;max-height: 200px;overflow-y: auto"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="p-0">
                    <div class="card-header py-1 text-center" style="font-size: 1.2vw">推荐理由</div>
                    <div class="card-body p-2 text-center bg-white border-bottom" style="font-size: 10px;">
                        <textarea id="reason" name="reason" onchange="setReasonInfo(this)"
                                  style="width: 100%;height: 80px"></textarea>
                    </div>
                    <div class="p-1 m-auto border-bottom text-center" style="font-size: 1vw">
                        <span id="recommendMsg" class="text-danger"></span>
                    </div>
                </div>
                <div class="p-0">
                    <div class="card-body px-3 py-2 text-center">
                        <div class="row">
                            <div class="input-group col-5 pl-3 pr-2">
                                <div class="input-group-prepend">
                                    <span class="input-group-text px-2" style="font-size: 1vw;">发布价格</span>
                                </div>
                                <input id="deployPrice" type="text" class="form-control" onchange="setPriceInfo(this)"/>
                                <div class="input-group-append">
                                    <span class="input-group-text px-2">
                                        <i class="fa fa-stop-circle-o text-warning"></i>
                                    </span>
                                </div>
                            </div>
                            <div class="col-2 p-0 my-auto text-left" style="font-size: 1.2vw;color: #a06d6d">
                                (0 - 1000)
                            </div>
                            <div class="col-5">
                                <button id="deployBtn" type="button" class="btn btn-primary w-100">发布</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="recommendSuccess" class="row text-center w-100" style="top: 50%;position: absolute;display: none">
    <div class="card p-3 m-auto text-center text-success" style="width: 150px;font-size: 1.2vw">
        <span>推荐成功&nbsp;<i class="fa fa-check"></i></span>
    </div>
</div>
</body>
<script src="/production/bootstrap/js/popper.min.js"></script>
<script src="../production/bootstrap/js/bootstrap.min.js"></script>
<script src="../custom/js/recommend.js"></script>
</html>