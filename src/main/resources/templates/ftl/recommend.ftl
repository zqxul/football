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
    <a class="navbar-brand" href="#"><i class="fa fa-futbol-o">&nbsp;玩个球</i></a>
    <div class="collapse navbar-collapse justify-content-between">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/"><i class="fa fa-home">&nbsp;首页</i></a>
            </li>
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
                <a class="nav-link" href="/recommend/">足彩推荐</a>
            </li>
        <#--<li class="nav-item">-->
        <#--<a class="nav-link" href="#">博彩心得</a>-->
        <#--</li>-->
            <li class="nav-item">
                <a class="nav-link" href="/account/">我的账户</a>
            </li>
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
    <div class="p-2">
        <div class="row m-0">
            <div class="col-12 p-0">
                <div id="hotmanRow" class="row m-0 p-2 d-inline-block">
                    <#list hotmans>
                    <#items as hotman>
                    <div class="my-auto mx-1 py-2 border d-inline-block text-center hotman"
                         style="width: 150px;border-radius: 20px;background-color: #f3f3f3">
                        <div class="row m-0 mb-1 h-50">
                            <span class="w-100">
                            <img style="border-radius: 50%"
                                 src="http://pimg1.126.net/caipiao_info/images/team/25/2201.png?201806301521">
                            </span>
                        </div>
                        <div class="row m-0 h-25"><span class="w-100">${hotman.username}</span></div>
                        <div class="row m-0 h-25">
                            <span class="w-100">总勝率:${hotman.totalRate}&nbsp;近10中${hotman.top10WinCount}</span>
                        </div>
                    </div>
                    </#items>
                    </#list>
                </div>
            </div>
        </div>
        <div class="row m-0 border">
            <div class="col-8 p-0 border">
                <div class="m-auto p-2 text-right" style="height: 60px;background-color: rgba(0, 0, 0, .03);">
                    <div class="row m-0 w-100 justify-content-between">
                        <div class="col-2 pl-3 text-left m-auto">
                            <span class="font-weight-bold"><i class="fa fa-user-secret">&nbsp;高手推荐</i></span>
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
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal"
                                    data-target="#recommendModal">
                                我要推荐
                            </button>
                        </div>
                    </div>
                </div>
                <div id="recommendDiv" class="px-3 pt-3" style="height: 600px;overflow: auto">
                    <#list recommends>
                        <#items as recommend>
                    <div class="row mx-2 mb-3 border recommendRow" leaguename="${recommend.leagueName}"
                         authorname="${recommend.createBy!""}"
                         style="border-radius: 15px;<#if recommend_index%2==0>background-color:#f3f3f3</#if>">
                        <div class="col-6 p-2 my-auto">
                            <div class="row m-0 text-center" style="font-size: .6vw">
                                <div class="col p-1">
                                    <#if recommend.matchResult == 1>
                                        <div class="m-auto text-danger"
                                             style="width: 50px;height: 50px;border-radius: 50%;font-size: 1.8vw;border: 1px solid;">
                                            <span style="line-height: 45px">输</span>
                                        </div>
                                    <#elseif recommend.matchResult == 2>
                                    <div class="m-auto text-success"
                                         style="width: 50px;height: 50px;border-radius: 50%;font-size: 1.8vw;border: 1px solid;">
                                        <span style="line-height: 45px">赢</span>
                                    </div>
                                    <#elseif  recommend.matchResult == 3>
                                    <div class="m-auto text-primary"
                                         style="width: 50px;height: 50px;border-radius: 50%;font-size: 1.8vw;border: 1px solid;">
                                        <span style="line-height: 45px">走</span>
                                    </div>
                                    <#else>
                                    <div class="m-auto text-secondary"
                                         style="width: 50px;height: 50px;border-radius: 50%;font-size: 1.8vw;border: 1px solid;">
                                        <span style="line-height: 45px">?</span>
                                    </div>
                                    </#if>
                                </div>
                                <div class="col p-1">
                                    <div class="row m-0 h-100">
                                        <div class="p-0 m-auto">${recommend.host}</div>
                                    </div>
                                </div>
                                <div class="col-5 p-1 m-auto">
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
                        <div class="col-2 p-0 border-left" style="font-size: 1.1vw">
                            <div class="row m-0 h-100 text-center">
                                <div class="p-2 my-auto w-100">
                                    <#if recommend.price gt 0>

                                            <#if recommend.payed>
                                                <span class="px-2 text-success">已支付&nbsp;<i
                                                        class="fa fa-check"></i></span>
                                            <#else>
                                            <span class="px-2">
                                                ${recommend.price}&nbsp;<i class="fa fa-stop-circle-o text-warning"></i>
                                            </span>
                                            </#if>
                                    <#else>
                                    <span class="px-2 text-success">免费</span>
                                    </#if>
                                </div>
                            </div>
                        </div>
                        <div class="col-3 p-1 border-left">
                            <div class="col p-0 h-100 text-center" style="font-size: 1vw">
                                <div class="p-0 my-2">
                                    作者：<span class="author text-center">${recommend.createBy!""}</span>
                                </div>
                                <div class="p-0 my-2">
                                    总胜率：<span>?</span>&nbsp;近10中<span>?</span>
                                </div>
                            </div>
                        </div>
                        <div id="payViewDiv-${recommend_index}" class="col-1 p-0 my-auto">
                            <#if recommend.payed || recommend.matchResult!=0>
                                <button id="viewBtn" type="button" class="btn btn-info btn-sm viewBtn"
                                        recommendid="${recommend.id}"
                                        data-toggle="modal" data-target="#viewModal"
                                        onclick="initViewModal(${recommend.id})" style="font-size: 1vw">查看
                                </button>
                            <#else>
                            <button type="button" class="btn btn-primary btn-sm payBtn" recommendid="${recommend.id}"
                                    confirmMoney="${recommend.price}"
                                    data-toggle="modal"
                                    data-target="#payModal" style="font-size: 1vw">支付
                            </button>
                            </#if>
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
                                <a class="p-1 nav-link active" href="#totalRanking" onclick="switchRanking(this)">总榜</a>
                            </li>
                            <li class="col p-0 nav-item">
                                <a class="p-1 nav-link" href="#monthRanking" onclick="switchRanking(this)">月榜</a>
                            </li>
                            <li class="col p-0 nav-item">
                                <a class="p-1 nav-link" href="#weekRanking" onclick="switchRanking(this)">周榜</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="tab-content">
                    <div id="totalRanking" class="p-2 tab-pane active text-center" style="font-size: 1.2vw">
                        <#list totalRankings>
                            <#items as hotman>
                        <div class="row mx-0 my-2 p-2 border" style="border-radius: 20px">
                            <div class="col-2 px-0">
                                <div class="p-0 m-auto"
                                     style="color: <#if hotman_index == 0>#f0c231<#elseif  hotman_index == 1>#cfceca<#elseif  hotman_index == 2>#b4a683<#else>#6c757d</#if>;width: 20px;height: 20px;line-height: 18px;border: 1px solid;border-radius: 50%;font-size: 1vw">${hotman_index+1}</div>
                            </div>
                            <span class="col-4 px-0">${hotman.username}</span>
                            <span class="col-3 px-0">胜率:<span class="mx-0">${hotman.totalRate}</span></span>
                            <span class="col-2 px-0">
                                <#if hotman_index == 0>
                                    <i class="fa fa-ship" style="color: #f0c231;"></i>
                                <#elseif hotman_index ==1 >
                                    <i class="fa fa-ship" style="color: #cfceca"></i>
                                <#elseif hotman_index ==2 >
                                    <i class="fa fa-ship" style="color: #b4a683"></i>
                                <#else>
                                    <i class="fa fa-ship" style="color: #f3f3f3"></i>
                                </#if>
                            </span>
                            <span class="col-1"></span>
                        </div>
                            </#items>
                        </#list>
                    </div>
                    <div id="monthRanking" class="p-2 tab-pane text-center" style="font-size: 1.2vw">
                        <#list monthRankings>
                            <#items as hotman>
                        <div class="row mx-0 my-2 p-2 border" style="border-radius: 20px">
                            <div class="col-2 px-0">
                                <div class="p-0 m-auto"
                                     style="color: <#if hotman_index == 0>#f0c231<#elseif  hotman_index == 1>#cfceca<#elseif  hotman_index == 2>#b4a683<#else>#6c757d</#if>;width: 20px;height: 20px;line-height: 18px;border: 1px solid;border-radius: 50%;font-size: 1vw">${hotman_index+1}</div>
                            </div>
                            <span class="col-4 px-0">${hotman.username}</span>
                            <span class="col-3 px-0">胜率:<span class="mx-0">${hotman.monthRate}</span></span>
                            <span class="col-2 px-0">
                                <#if hotman_index == 0>
                                    <i class="fa fa-ship" style="color: #f0c231;"></i>
                                <#elseif hotman_index ==1 >
                                    <i class="fa fa-ship" style="color: #cfceca"></i>
                                <#elseif hotman_index ==2 >
                                    <i class="fa fa-ship" style="color: #b4a683"></i>
                                <#else>
                                    <i class="fa fa-ship" style="color: #f3f3f3"></i>
                                </#if>
                            </span>
                            <span class="col-1"></span>
                        </div>
                            </#items>
                        </#list>
                    </div>
                    <div id="weekRanking" class="p-2 tab-pane text-center" style="font-size: 1.2vw">
                        <#list weekRankings>
                            <#items as hotman>
                        <div class="row mx-0 my-2 p-2 border" style="border-radius: 20px">
                            <div class="col-2 px-0">
                                <div class="p-0 m-auto"
                                     style="color: <#if hotman_index == 0>#f0c231<#elseif  hotman_index == 1>#cfceca<#elseif  hotman_index == 2>#b4a683<#else>#6c757d</#if>;width: 20px;height: 20px;line-height: 18px;border: 1px solid;border-radius: 50%;font-size: 1vw">${hotman_index+1}</div>
                            </div>
                            <span class="col-4 px-0">${hotman.username}</span>
                            <span class="col-3 px-0">胜率:<span class="mx-0">${hotman.weekRate}</span></span>
                            <span class="col-2 px-0">
                                <#if hotman_index == 0>
                                    <i class="fa fa-ship" style="color: #f0c231;"></i>
                                <#elseif hotman_index ==1 >
                                    <i class="fa fa-ship" style="color: #cfceca"></i>
                                <#elseif hotman_index ==2 >
                                    <i class="fa fa-ship" style="color: #b4a683"></i>
                                <#else>
                                    <i class="fa fa-ship" style="color: #f3f3f3"></i>
                                </#if>
                            </span>
                            <span class="col-1"></span>
                        </div>
                            </#items>
                        </#list>
                    </div>
                </div>
            </div>
        </div>
    </div>

</main>
<div class="modal" id="payModal" tabindex="-1" role="dialog" aria-labelledby="payModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="payModalTitle">确认支付信息</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="recommendId" name="recommendId"/>
                <div class="row h-70 m-0 pb-3">
                    <div class="col p-0"></div>
                    <div class="col-5 p-0 input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text px-1" style="font-size: 1vw;">您将支付</span>
                        </div>
                        <input id="confirmMoney" type="text" class="form-control text-center" readonly>
                        <div class="input-group-append">
                                <span class="input-group-text px-1">
                                    <i class="fa fa-stop-circle-o text-warning"></i>
                                </span>
                        </div>
                    </div>
                    <div class="col p-0"></div>
                    <div class="col-3 p-0 m-auto">
                        <button id="payBtn" type="button" class="btn btn-warning btn-sm w-100" onclick="payRecommend()">
                            确认支付
                        </button>
                    </div>
                    <div class="col p-0"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="viewModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header p-0">
                <div class="col p-0"></div>
                <div class="col-9 p-0 my-auto">
                    <div class="row m-0 text-center text-muted" style="font-size: 1.2vw">
                        <div class="col p-1">
                            <div class="row m-0 h-100">
                                <div id="viewHostName" class="p-0 m-auto">沼津青蓝</div>
                            </div>
                        </div>
                        <div class="col-6 p-1 m-auto">
                            <div id="viewLeagueName" class="col p-0 my-1">J3</div>
                            <div id="viewMatchTime" class="col p-0 my-1">07-01 14:00</div>
                        </div>
                        <div class="col p-1">
                            <div class="row m-0 h-100">
                                <div id="viewVisitName" class="p-0 m-auto">大阪樱花U23</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col p-0"></div>
                <button type="button" class="close p-1 m-1" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body p-2" style="font-size: 1.2vw">
                <div class="row m-0">
                    <div class="col p-0"></div>
                    <div class="col-10 p-0">
                        <div class="row m-0">
                            <div class="col-6 p-2"><span class="font-weight-bold">推荐类型：</span><span id="recommendTypeName">亚盘</span></div>
                            <div class="col-6 p-2"><span class="font-weight-bold">推荐选项：</span><span><span id="recommendValueName">俄罗斯-0.5</span></div>
                        </div>
                        <div class="p-2"><span class="font-weight-bold">推荐理由:</span><p id="recommendReason">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这位高手有点懒，不写理由还是可以原谅的。</p></div>
                    </div>
                    <div class="col p-0"></div>
                </div>
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
                                  style="width: 100%;height: 80px" placeholder="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;亲，就写点吧，充分的理由可以提高内容被查看的可能性哦"></textarea>
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
                                <button id="deployBtn" type="button" onclick="deployRecommend()"
                                        class="btn btn-primary w-100">发布
                                </button>
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
<div id="payMsgDiv" class="row text-center w-100" style="top: 50%;position: absolute;display: none">
    <div id="payCard" class="card p-3 m-auto text-center" style="width: 150px;font-size: 1.2vw"></div>
</div>
</body>
<script src="/production/bootstrap/js/popper.min.js"></script>
<script src="../production/bootstrap/js/bootstrap.min.js"></script>
<script src="../custom/js/recommend.js"></script>
</html>