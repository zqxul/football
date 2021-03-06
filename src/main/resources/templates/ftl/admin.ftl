<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>全站一览</title>

    <!-- Bootstrap core CSS -->
    <link href="../production/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../production/font-awesome/css/font-awesome.min.css">
</head>

<body>
<nav class="navbar navbar-dark bg-dark sticky-top">
    <div class="col-2 p-0 text-center">
        <a class="navbar-brand" href="#">后台管理</a>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 position-fixed h-100 d-none d-md-block navbar-expand-md navbar-dark bg-dark">
            <ul class="navbar-nav flex-column p-1 pt-4">
                <li class="nav-item active my-1">
                    <a class="nav-link p-2" href="#">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-home"></i>
                            </span>
                            <span class="col-8 p-0">全站一览</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="#">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-calendar"></i>
                            </span>
                            <span class="col-8 p-0">待办事项</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="/admin/list/recharge">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-cny"></i>
                            </span>
                            <span class="col-8 p-0">充值管理</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="/admin/list/withdraw">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-money"></i>
                            </span>
                            <span class="col-8 p-0">提现管理</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="/admin/review/recommend">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-money"></i>
                            </span>
                            <span class="col-8 p-0">推荐审核</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="#">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-users"></i>
                            </span>
                            <span class="col-8 p-0">用户分析</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="#">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-smile-o"></i>
                            </span>
                            <span class="col-8 p-0">行为分析</span>
                        </div>
                    </a>
                </li>
            </ul>
        </nav>
        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
            <div class="row m-0">
                <div class="col p-0">
                    <div class="row m-0 justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
                        <h5 class="h5">全站一览</h5>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <div class="btn-group mr-2">
                                <button class="btn btn-sm btn-outline-secondary">今日</button>
                                <button class="btn btn-sm btn-outline-secondary">近一周</button>
                                <button class="btn btn-sm btn-outline-secondary">近两周</button>
                                <button class="btn btn-sm btn-outline-secondary">一个月</button>
                                <button class="btn btn-sm btn-outline-secondary">三个月</button>
                                <button class="btn btn-sm btn-outline-secondary">半年</button>
                                <button class="btn btn-sm btn-outline-secondary">一年</button>
                            </div>
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle">
                                <span data-feather="calendar"></span>
                                This week
                            </button>
                        </div>
                    </div>
                    <div class="row m-0">
                        <div class="col-4 p-2">
                            <div class="card">
                                <div class="row m-0 h-25 text-center" style="font-size: 1.5vw;">
                                    <div class="col p-2 border-bottom">
                                        <span class="col-1 p-0 text-right"><i class="fa fa-eye">&nbsp;</i></span>
                                        <span class="col-4 p-0">访问量</span>
                                    </div>
                                </div>
                                <div class="row m-0 h-75 text-center" style="font-size: 1.2vw">
                                    <div class="col p-3">
                                        <div class="col-12 m-0 p-1">
                                            <a href="/football/news/list">每日球报</a>&nbsp;被访问了&nbsp;<span>${footballNewsVisitCount}</span>&nbsp;次
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/analysis/info">赛事分析</a>&nbsp;被访问了&nbsp;<span>${matchAnalysisVisitCount}</span>&nbsp;次
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/live/matchs/lastest">比分直播</a>&nbsp;被访问了&nbsp;<span>${scoreLiveVisitCount}</span>&nbsp;次
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/data">大数据</a>&nbsp;被访问了&nbsp;<span>${bigDataVisitCount}</span>&nbsp;次
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 p-2">
                            <div class="card h-100">
                                <div class="row m-0 h-25 text-center" style="font-size: 1.5vw;">
                                    <div class="col p-2 border-bottom">
                                        <span class="col-1 p-0 text-right"><i class="fa fa-user-plus">&nbsp;</i></span>
                                        <span class="col-4 p-0">新增用户</span>
                                    </div>
                                </div>
                                <div class="row m-0 h-75 text-center" style="font-size: 1.2vw">
                                    <div class="col p-3">
                                        <div class="col-12 m-0 p-1">
                                            <a href="/football/news/list">普通用户</a>&nbsp;新增&nbsp;<span>8</span>&nbsp;位
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/football/news/list">高级用户</a>&nbsp;新增&nbsp;<span>2</span>&nbsp;位
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/analysis/info">理财用户</a>&nbsp;新增&nbsp;<span>3</span>&nbsp;位
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 p-2">
                            <div class="card h-100">
                                <div class="row m-0 h-25 text-center" style="font-size: 1.5vw;">
                                    <div class="col p-2 border-bottom">
                                        <span class="col-1 p-0 text-right"><i class="fa fa-cny">&nbsp;</i></span>
                                        <span class="col-4 p-0">充值统计</span>
                                    </div>
                                </div>
                                <div class="row m-0 h-75 text-center" style="font-size: 1.2vw">
                                    <div class="col p-3">
                                        <div class="col-12 m-0 p-1">
                                            <a href="/football/news/list">普通用户</a>&nbsp;充值了&nbsp;<span>880</span>&nbsp;元
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/analysis/info">高级用户</a>&nbsp;充值了&nbsp;<span>383</span>&nbsp;元
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/live/matchs/lastest">理财用户</a>&nbsp;充值了&nbsp;<span>569</span>&nbsp;元
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 p-2">
                            <div class="card h-100">
                                <div class="row m-0 h-25 text-center" style="font-size: 1.5vw;">
                                    <div class="col p-2 border-bottom">
                                        <span class="col-1 p-0 text-right"><i class="fa fa-money">&nbsp;</i></span>
                                        <span class="col-4 p-0">提现统计</span>
                                    </div>
                                </div>
                                <div class="row m-0 h-75 text-center" style="font-size: 1.2vw">
                                    <div class="col p-3">
                                        <div class="col-12 m-0 p-1">
                                            <a href="/football/news/list">普通用户</a>&nbsp;提现了&nbsp;<span>81</span>&nbsp;元
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/analysis/info">高级用户</a>&nbsp;提现了&nbsp;<span>235</span>&nbsp;元
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/live/matchs/lastest">理财用户</a>&nbsp;提现了&nbsp;<span>189</span>&nbsp;元
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 p-2">
                            <div class="card h-100">
                                <div class="row m-0 h-25 text-center" style="font-size: 1.5vw;">
                                    <div class="col p-2 border-bottom">
                                        <span class="col-1 p-0 text-right"><i class="fa fa-credit-card">&nbsp;</i></span>
                                        <span class="col-4 p-0">收入统计</span>
                                    </div>
                                </div>
                                <div class="row m-0 h-75 text-center" style="font-size: 1.2vw">
                                    <div class="col p-3">
                                        <div class="col-12 m-0 p-1">
                                            <a href="/football/news/list">用户购买推荐</a>&nbsp;提成收入&nbsp;<span>21</span>&nbsp;元
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/analysis/info">用户查看心得</a>&nbsp;收入&nbsp;<span>235</span>&nbsp;元
                                        </div>
                                        <div class="col-12 m-0 p-1">
                                            <a href="/live/matchs/lastest">用户开通会员</a>&nbsp;收入&nbsp;<span>189</span>&nbsp;元
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
<script src="../production/jquery/jquery.min.js"></script>
<script src="../production/bootstrap/js/bootstrap.min.js"></script>
</html>
