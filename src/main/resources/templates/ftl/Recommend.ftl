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
    <div class="collapse navbar-collapse">
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
                    <button type="button" class="btn btn-primary btn-sm" data-toggle="modal"
                            data-target="#recommendModal">
                        我要推荐
                    </button>
                </div>
                <div class="p-3">
                    <div class="row mx-0 my-2 border">
                        <div class="col-6 p-2 my-auto">
                            <div class="row m-0 text-center" style="font-size: .6vw">
                                <div class="col p-1">
                                    <div class="row m-0 h-100">
                                        <div class="col-6 p-0 m-auto">白禮頓白禮頓白禮頓</div>
                                        <div class="col-6 p-0 m-auto">
                                            <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-4 p-1 m-auto">
                                    <div class="col p-0">周五 001</div>
                                    <div class="col p-0">06-14 00:12</div>
                                </div>
                                <div class="col p-1">
                                    <div class="row m-0 h-100">
                                        <div class="col-6 p-0 m-auto">
                                            <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139"/>
                                        </div>
                                        <div class="col-6 p-0 m-auto">阿仙媽</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 p-0 border-left">
                            <div class="row m-0 h-100">
                                <div class="col-12 p-2 my-auto">
                                    <span class="px-2">
                                        50&nbsp;<i class="fa fa-stop-circle-o text-warning"></i>
                                    </span>
                                    <span class="px-2 fade">免费</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-2 p-2 my-auto">
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal"
                                    data-target="#viewModal">查看
                            </button>
                        </div>
                    </div>
                    <div class="row mx-0 my-2 border">
                        <div class="col-6 p-2 my-auto">
                            <div class="row m-0 text-center" style="font-size: .6vw">
                                <div class="col p-1">
                                    <div class="row m-0 h-100">
                                        <div class="col-6 p-0 m-auto">白禮頓白禮頓白禮頓</div>
                                        <div class="col-6 p-0 m-auto">
                                            <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-4 p-1 m-auto">
                                    <div class="col p-0">周五 001</div>
                                    <div class="col p-0">06-14 00:12</div>
                                </div>
                                <div class="col p-1">
                                    <div class="row m-0 h-100">
                                        <div class="col-6 p-0 m-auto">
                                            <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139"/>
                                        </div>
                                        <div class="col-6 p-0 m-auto">阿仙媽</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 p-0 border-left">
                            <div class="row m-0 h-100">
                                <div class="col-12 p-2 my-auto">
                                    <span class="px-2">
                                        50&nbsp;<i class="fa fa-stop-circle-o text-warning"></i>
                                    </span>
                                    <span class="px-2 fade">免费</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-2 p-2 my-auto">
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal"
                                    data-target="#viewModal">查看
                            </button>
                        </div>
                    </div>
                    <div class="row mx-0 my-2 border">
                        <div class="col-6 p-2 my-auto">
                            <div class="row m-0 text-center" style="font-size: .6vw">
                                <div class="col p-1">
                                    <div class="row m-0 h-100">
                                        <div class="col-6 p-0 m-auto">白禮頓白禮頓白禮頓</div>
                                        <div class="col-6 p-0 m-auto">
                                            <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-4 p-1 m-auto">
                                    <div class="col p-0">周五 001</div>
                                    <div class="col p-0">06-14 00:12</div>
                                </div>
                                <div class="col p-1">
                                    <div class="row m-0 h-100">
                                        <div class="col-6 p-0 m-auto">
                                            <img src="http://pimg1.126.net/caipiao_info/images/team/25/2280.png?201806122139"/>
                                        </div>
                                        <div class="col-6 p-0 m-auto">阿仙媽</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 p-0 border-left">
                            <div class="row m-0 h-100">
                                <div class="col-12 p-2 my-auto">
                                    <span class="px-2">
                                        50&nbsp;<i class="fa fa-stop-circle-o text-warning"></i>
                                    </span>
                                    <span class="px-2 fade">免费</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-2 p-2 my-auto">
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal"
                                    data-target="#viewModal">查看
                            </button>
                        </div>
                    </div>
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
            <div class="modal-body p-0">
                <div class="p-0">
                    <div id="odds-1" class="tab-pane recommend-panel">
                        <div class="btn-group nav nav-tabs col justify-content-center border-0" role="group"
                             style="padding: .5rem .5rem;">
                            <a href="#europeOdds" class="btn btn-sm btn-light">欧赔</a>
                            <a href="#asiaOdds" class="btn btn-sm btn-light active">亚盘</a>
                            <a href="#sizeOdds" class="btn btn-sm btn-light">大小盘</a>
                        </div>
                        <div class="tab-content p-0">
                            <div id="europeOdds" class="tab-pane">
                                <div class="card-header py-1 text-center"
                                     style="font-size: 1.2vw">
                                    欧赔选项
                                </div>
                                <div id="europeOddsRows" class="card-body p-2 text-center bg-white"
                                     style="font-size: 10px;"></div>
                            </div>
                            <div id="asiaOdds" class="tab-pane active">
                                <div class="card-header py-1 text-center"
                                     style="font-size: 1.2vw">亚盘选项
                                </div>
                                <div id="asiaOddsRows" class="card-body p-2 text-center bg-white"
                                     style="font-size: 10px;"></div>
                            </div>
                            <div id="sizeOdds" class="tab-pane">
                                <div class="card-header py-1 text-center"
                                     style="font-size: 1.2vw">大小球选项
                                </div>
                                <div id="sizeOddsRows" class="card-body p-2 text-center bg-white"
                                     style="font-size: 10px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="p-0">
                    <div class="card-header py-1 text-center" style="font-size: 1.2vw">推荐理由</div>
                    <div class="card-body p-2 text-center bg-white border-bottom" style="font-size: 10px;">
                        <textarea name="reason" style="width: 100%;height: 80px"></textarea>
                    </div>
                </div>
                <div class="p-0">
                    <div class="card-body px-3 py-2 text-center">
                        <div class="row">
                            <div class="input-group col-7 px-4">
                                <div class="input-group-prepend">
                                    <span class="input-group-text px-2" style="font-size: 1vw;">发布价格</span>
                                </div>
                                <input type="text" class="form-control">
                                <div class="input-group-append">
                                    <span class="input-group-text px-2">
                                        <i class="fa fa-stop-circle-o text-warning"></i>
                                    </span>
                                </div>
                            </div>
                            <div class="col-5">
                                <button type="button" class="btn btn-primary w-100">发布</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="/production/bootstrap/js/popper.min.js"></script>
<script src="../production/bootstrap/js/bootstrap.min.js"></script>
<script src="../custom/js/recommend.js"></script>
</html>