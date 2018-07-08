<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Achievement</title>
    <link href="/production/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/production/font-awesome/css/font-awesome.min.css">

</head>
<body>
<nav class="navbar navbar-expand navbar-dark bg-dark" style="font-weight: 500">
    <a class="navbar-brand" href="#"><i class="fa fa-futbol-o">&nbsp;玩个球</i></a>
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
            <li class="nav-item">
                <a class="nav-link" href="/live/matchs/lastest">比分直播</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/data">大数据</a>
            </li>
            <li class="nav-item">
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
                        <a class="dropdown-item px-2 py-1" href="/account/">我的账户</a>
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
        <div class="row mx-0 my-3" style="height: 240px;">
            <div class="col-5 p-0 m-auto" style="font-size: 1.2vw">
                <div class="row m-0">
                    <div class="col-4 p-3 m-auto">
                        <div class="row"
                             style="width: 150px;height: 150px;border: 1px solid #f3f3f3;border-radius: 50%;">
                            <img class="p-2" style="width: 100%;height: 100%"
                                 src="/img/photo/3fb781293e37a6eb3e89f36aa51fd3fb.png">
                        </div>
                    </div>
                    <div class="col-8 p-3">
                        <div class="row mx-0 my-3">
                            <div class="col p-2">
                                <div>
                                    <span>大名：</span>
                                    <span>姜子牙</span>
                                </div>
                            </div>
                            <div class="col p-2">
                                <span>总胜率：</span>
                                <span>80%</span>
                            </div>
                        </div>
                        <div class="row mx-0 my-3">
                            <div class="col p-2">
                                <span>近10中8</span>
                            </div>
                            <div class="col p-2">
                                <span>近5中4</span>
                            </div>
                        </div>
                        <div class="row mx-0 my-3">
                            <div class="col p-2">
                                <div class="row m-0">
                                    <span class="col p-0">排名：</span>
                                    <span class="col p-0">总榜：<span>3</span></span>
                                    <span class="col p-0">月榜：<span>2</span></span>
                                    <span class="col p-0">周榜：<span>5</span></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-3 p-2">
                <div id="qualityChart" style="height: 100%;"></div>
            </div>
            <div class="col-4 p-3">
                <div id="recommendChart" style="height: 100%;"></div>
            </div>
        </div>
        <div class="row m-0 border">
            <div class="col-8 p-0 border">
                <div class="m-auto p-2 text-right" style="height: 60px;background-color: rgba(0, 0, 0, .03);">
                    <div class="row m-0 w-100 justify-content-between">
                        <div class="col-2 pl-3 text-left m-auto">
                            <span class="font-weight-bold"><i class="fa fa-user-secret">&nbsp;他的推荐</i></span>
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
                                类型筛选
                            </button>
                            <div id="recommendAuthor" class="dropdown-menu w-100" style="min-width: 100%"
                                 aria-labelledby="recommendAuthorDropdown">
                                <span class="dropdown-item author-item">
                                    <input class="authorCheckbox" type="checkbox"
                                           onchange="resetAuthorListDiv(this)"
                                           checked>
                                    <span class="m-0 ml-2 authorname" style="font-size: 1.2vw">欧赔</span>
                                </span>
                                <span class="dropdown-item author-item">
                                    <input class="authorCheckbox" type="checkbox"
                                           onchange="resetAuthorListDiv(this)"
                                           checked>
                                    <span class="m-0 ml-2 authorname" style="font-size: 1.2vw">亚盘</span>
                                </span>
                                <span class="dropdown-item author-item">
                                    <input class="authorCheckbox" type="checkbox"
                                           onchange="resetAuthorListDiv(this)"
                                           checked>
                                    <span class="m-0 ml-2 authorname" style="font-size: 1.2vw">大小球</span>
                                </span>
                            </div>
                        </div>
                        <div class="col p-0"></div>
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
                    <input id="bindEmail" type="text" class="form-control" placeholder="请输入用户名">
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
<script src="/production/echart/echarts.min.js"></script>
<#--<script src="/custom/js/achievement.js"></script>-->
<script src="/custom/js/repass.js"></script>


<script>
    //推荐分布
    var recommendChart = echarts.init(document.getElementById('recommendChart'));
    var recommendOption = {
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b}: {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            x: 'right',
            data: [<#list recommendScatters><#items as recommendScatter>'${recommendScatter.name}'<#sep>, </#items></#list>]
            // data: ['英超', '西甲', '德甲', '意甲', '法甲', '欧冠', '欧联', '荷甲', '葡超', '英冠', '葡甲', '英甲', '德乙', '法乙', '荷乙', '其他']
        },
    series: [
        {
            name: '输赢分布',
            type: 'pie',
            selectedMode: 'single',
            radius: [0, '30%'],
            center: ['35%', '50%'],

            label: {
                normal: {
                    position: 'inner'
                }
            },
            labelLine: {
                normal: {
                    show: false
                }
            },
            data: [
                {value: 335, name: '输', selected: true},
                {value: 679, name: '赢'},
                {value: 1548, name: '走'}
            ]
        },
    {
        name: '联赛分布',
        type: 'pie',
        radius: ['40%', '55%'],
        center: ['35%', '50%'],
    data: [
            <#list recommendScatters><#items as recommendScatter>{value: ${recommendScatter.count}, name: '${recommendScatter.name}'}<#sep>, </#items></#list>
            // {value: 335, name: '英超'},
            // {value: 310, name: '西甲'},
            // {value: 234, name: '德甲'},
            // {value: 135, name: '意甲'},
            // {value: 1048, name: '法甲'},
            // {value: 251, name: '欧冠'},
            // {value: 147, name: '欧联'},
            // {value: 13, name: '葡超'},
            // {value: 230, name: '英冠'},
            // {value: 110, name: '德乙'},
            // {value: 500, name: '葡甲'},
            // {value: 76, name: '英甲'},
            // {value: 89, name: '法乙'},
            // {value: 10, name: '荷乙'},
            // {value: 3, name: '其他'}
    ]
    }
    ]
    }
    ;
    recommendChart.setOption(recommendOption);

    //个人评估
    var qualityChart = echarts.init(document.getElementById('qualityChart'));
    var qualityOption = {
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            x: 'center',
            data: ['欧赔', '亚盘', '大小球']
        },
        radar: [
            {
                indicator: [
                    {text: '状态', max: 100},
                    {text: '稳定', max: 100},
                    {text: '实力', max: 100},
                    {text: '人气', max: 100},
                    {text: '经验', max: 1825}
                ],
                radius: 80,
                center: ['50%', '60%']
            }
        ],
        series: [
            {
                type: 'radar',
                radarIndex: 0,
                data: [
                    {
                        value: [${status[0]}, ${stability[0]}, ${ability[0]}, ${popularity[0]}, ${experience}],
                        name: '欧赔'
                    },
                    {
                        value: [${status[1]}, ${stability[1]}, ${ability[1]}, ${popularity[1]}, ${experience}],
                        name: '亚盘'
                    },
                    {
                        value: [${status[2]}, ${stability[2]}, ${ability[2]}, ${popularity[2]}, ${experience}],
                        name: '大小球'
                    }
                ]
            }
        ]
    };
    qualityChart.setOption(qualityOption);
</script>
</html>