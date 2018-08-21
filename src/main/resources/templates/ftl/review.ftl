<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>推荐审核</title>

    <!-- Bootstrap core CSS -->
    <link href="/production/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/production/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="/custom/css/extent.css">
    <link rel="stylesheet" href="/production/buttons/css/buttons.min.css">
    <link rel="stylesheet" href="/custom/css/review.css">
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
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="../admin.html">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-home"></i>
                            </span>
                            <span class="col-8 p-0">全站一览</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="/todo.html">
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
                <li class="nav-item active my-1">
                    <a class="nav-link p-2" href="/admin/review/recommend">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-eye"></i>
                            </span>
                            <span class="col-8 p-0">推荐审核</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="/user.html">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-users"></i>
                            </span>
                            <span class="col-8 p-0">用户分析</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="./action.html">
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
                    <div class="row m-0 p-2 justify-content-between flex-wrap flex-md-nowrap align-items-center border-bottom">
                        <h5 class="h5">推荐审核</h5>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <div class="btn-group mr-2">
                                <button class="btn btn-sm btn-outline-secondary">今日</button>
                                <button class="btn btn-sm btn-outline-secondary">本周</button>
                                <button class="btn btn-sm btn-outline-secondary">近两周</button>
                                <button class="btn btn-sm btn-outline-secondary">一个月</button>
                                <button class="btn btn-sm btn-outline-secondary">三个月</button>
                                <button class="btn btn-sm btn-outline-secondary">半年</button>
                                <button class="btn btn-sm btn-outline-secondary">一年</button>
                            </div>
                        </div>
                    </div>
                    <div class="row card">
                        <div class="col m-0 p-0 card-body recharge-card">
                            <ul class="card-header m-0 p-0 nav nav-tabs text-center" style="font-size: 1.2vw">
                                <li class="col-1 p-0 nav-item active">
                                    <a class="nav-link active" href="#waiting" data-toggle="tab">待审核</a>
                                </li>
                                <li class="col-1 p-0 nav-item">
                                    <a class="nav-link" href="#processed" data-toggle="tab">已审核</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div id="waiting" class="tab-pane active">
                                    <div class="card-body p-0 px-2">
                                        <#list waitingRecommends>
                                        <#items as recommend>
                                        <div class="row mx-2 my-2 border recommendRow" leaguename="${recommend.leagueName!''}"
                                             authorname="user4" style="border-radius: 15px;background-color:#f3f3f3">
                                            <div class="col-4 p-1 border-right">
                                                <div class="col p-0 h-100 text-center" style="font-size: 1vw">
                                                    <div class="p-0 my-2">
                                                        作者：<span class="author text-center">${recommend.author!''}</span>
                                                    </div>
                                                    <div class="p-0 my-2">
                                                        推荐时间：<span>&nbsp;${recommend.createTime?string("yyyy-MM-dd HH:ss:mm")}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-4 p-2 my-auto">
                                                <div class="row m-0 text-center" style="font-size: .6vw">
                                                    <div class="col p-1">
                                                        <div class="row m-0 h-100">
                                                            <div class="p-0 m-auto">${recommend.host!''}</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-5 p-1 m-auto">
                                                        <div class="col p-0 my-1">${recommend.leagueName!''}</div>
                                                        <div class="col p-0 my-1">${recommend.matchTime?date?string("yyyy-MM-dd HH:ss")}</div>
                                                    </div>
                                                    <div class="col p-1">
                                                        <div class="row m-0 h-100">
                                                            <div class="p-0 m-auto">${recommend.visit!''}</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col p-0 border-left border-right" style="font-size: 1.1vw">
                                                <div class="row m-0 h-100 text-center">
                                                    <div class="p-2 my-auto w-100">
                                                        <i class="fa fa-balance-scale"></i>&nbsp;
                                                        <#if recommend.type==1>
                                                            <#if recommend.value==1>
                                                                <span class="px-2"><span>${recommend.host}&nbsp;</span><span class="text-danger">胜</span></span>
                                                            <#elseif recommend.value==2>
                                                                <span class="px-2 text-primary">平</span>
                                                            <#elseif recommend.value==3>
                                                                <span class="px-2"><span>${recommend.visit}&nbsp;</span><span class="text-danger">胜</span></span>
                                                            <#else>
                                                                <span class="px-2">-</span>
                                                            </#if>
                                                        <#elseif recommend.type==2>
                                                            <span class="px-2">
                                                                <#if recommend.handicap?contains("受")>
                                                                    <#if recommend.value==4>
                                                                        ${recommend.host}(${recommend.handicap})&nbsp;<span class="text-success">负</span>
                                                                    <#elseif recommend.value==5>
                                                                    ${recommend.host}(${recommend.handicap})&nbsp;<span class="text-danger">胜</span>
                                                                    <#else>
                                                                    -
                                                                    </#if>
                                                                <#else>
                                                                    <#if recommend.value==4>
                                                                        ${recommend.host}(让${recommend.handicap})&nbsp;<span class="text-danger">胜</span>
                                                                    <#elseif recommend.value==5>
                                                                        ${recommend.host}(让${recommend.handicap})&nbsp;<span class="text-success">负</span>
                                                                    <#else>
                                                                    -
                                                                    </#if>
                                                                </#if>
                                                            </span>
                                                        <#elseif recommend.type==3>
                                                            <span class="px-2">
                                                                <span><#if recommend.value==6><span class="text-danger">大</span><#elseif recommend.value==7><span class="text-success">小</span><#else>-</#if>&nbsp;</span>
                                                                <span>${recommend.handicap}</span>
                                                            </span>
                                                        <#else>
                                                            <span>-</span>
                                                        </#if>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-1 m-auto">
                                                <span class="button-dropdown button-dropdown-plain"
                                                      data-buttons="dropdown">
                                                    <button id="matchResultStatusBtn"
                                                            class="button button-glow button-raised button-circle button-large">
                                                        <i class="fa fa-eye"></i>
                                                    </button>
                                                    <ul class="button-dropdown-list text-center">
                                                      <li class="button-dropdown-divider">
                                                          <a recommendId="${recommend.id}"  onclick="changeMatchResultStatus(this)"  status="1"  class="text-danger"  style="font-size: 1.5vw">输</a>
                                                      </li>
                                                      <li class="button-dropdown-divider">
                                                          <a recommendId="${recommend.id}" onclick="changeMatchResultStatus(this)" status="2" class="text-success" style="font-size: 1.5vw">赢</a>
                                                      </li>
                                                      <li class="button-dropdown-divider">
                                                          <a recommendId="${recommend.id}" onclick="changeMatchResultStatus(this)" status="3" class="text-info" style="font-size: 1.5vw">走</a>
                                                      </li>
                                                    </ul>
                                                </span>
                                            </div>
                                        </div>
                                        </#items>
                                        </#list>
                                    </div>
                                </div>
                                <div id="processed" class="tab-pane">
                                    <div class="card-body p-0 px-2">
                                        <#list reviewedRecommends>
                                        <#items as recommend>
                                        <div class="row mx-2 my-2 border recommendRow" leaguename="${recommend.leagueName!''}"
                                             authorname="user4" style="border-radius: 15px;background-color:#f3f3f3">
                                            <div class="col-4 p-1 border-right">
                                                <div class="col p-0 h-100 text-center" style="font-size: 1vw">
                                                    <div class="p-0 my-2">
                                                        作者：<span class="author text-center">${recommend.author!''}</span>
                                                    </div>
                                                    <div class="p-0 my-2">
                                                        推荐时间：<span>&nbsp;${recommend.createTime?string("yyyy-MM-dd HH:ss:mm")}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-4 p-2 my-auto">
                                                <div class="row m-0 text-center" style="font-size: .6vw">
                                                    <div class="col p-1">
                                                        <div class="row m-0 h-100">
                                                            <div class="p-0 m-auto">${recommend.host!''}</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-5 p-1 m-auto">
                                                        <div class="col p-0 my-1">${recommend.leagueName!''}</div>
                                                        <div class="col p-0 my-1">${recommend.matchTime?date?string("yyyy-MM-dd HH:ss")}</div>
                                                    </div>
                                                    <div class="col p-1">
                                                        <div class="row m-0 h-100">
                                                            <div class="p-0 m-auto">${recommend.visit!''}</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col p-0 border-left border-right" style="font-size: 1.1vw">
                                                <div class="row m-0 h-100 text-center">
                                                    <div class="p-2 my-auto w-100">
                                                        <i class="fa fa-balance-scale"></i>&nbsp;
                                                        <#if recommend.type==1>
                                                            <#if recommend.value==1>
                                                                <span class="px-2"><span>${recommend.host}&nbsp;</span><span class="text-danger">胜</span></span>
                                                            <#elseif recommend.value==2>
                                                                <span class="px-2 text-primary">平</span>
                                                            <#elseif recommend.value==3>
                                                                <span class="px-2"><span>${recommend.visit}&nbsp;</span><span class="text-danger">胜</span></span>
                                                            <#else>
                                                                <span class="px-2">-</span>
                                                            </#if>
                                                        <#elseif recommend.type==2>
                                                            <span class="px-2">
                                                                <#if recommend.handicap?contains("受")>
                                                                    <#if recommend.value==4>
                                                                        ${recommend.host}(${recommend.handicap})&nbsp;<span class="text-success">负</span>
                                                                    <#elseif recommend.value==5>
                                                                        ${recommend.host}(${recommend.handicap})&nbsp;<span class="text-danger">胜</span>
                                                                    <#else>
                                                                    -
                                                                    </#if>
                                                                <#else>
                                                                    <#if recommend.value==4>
                                                                        ${recommend.host}(让${recommend.handicap})&nbsp;<span class="text-danger">胜</span>
                                                                    <#elseif recommend.value==5>
                                                                        ${recommend.host}(让${recommend.handicap})&nbsp;<span class="text-success">负</span>
                                                                    <#else>
                                                                    -
                                                                    </#if>
                                                                </#if>
                                                            </span>
                                                        <#elseif recommend.type==3>
                                                            <span class="px-2">
                                                                <span><#if recommend.value==6><span class="text-danger">大</span><#elseif recommend.value==7><span class="text-success">小</span><#else>-</#if>&nbsp;</span>
                                                                <span>${recommend.handicap}</span>
                                                            </span>
                                                        <#else>
                                                            <span>-</span>
                                                        </#if>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-1 m-auto">
                                                <span class="button-dropdown button-dropdown-plain"
                                                      data-buttons="dropdown">
                                                    <button id="matchResultStatusBtn"
                                                            class="button button-glow button-raised button-circle button-large">
                                                        <#if recommend.matchResult==1>
                                                            <span class="font-weight-bold text-danger">输</span>
                                                        <#elseif recommend.matchResult==2>
                                                            <span class="font-weight-bold text-success">赢</span>
                                                        <#elseif recommend.matchResult==3>
                                                            <span class="font-weight-bold text-info">走</span>
                                                        <#else>
                                                            <i class="fa fa-eye"></i>
                                                        </#if>
                                                    </button>
                                                    <ul class="button-dropdown-list text-center">
                                                      <li class="button-dropdown-divider">
                                                          <a recommendId="${recommend.id}"  onclick="changeMatchResultStatus(this)"  status="1"  class="text-danger"  style="font-size: 1.5vw">输</a>
                                                      </li>
                                                      <li class="button-dropdown-divider">
                                                          <a recommendId="${recommend.id}" onclick="changeMatchResultStatus(this)" status="2" class="text-success" style="font-size: 1.5vw">赢</a>
                                                      </li>
                                                      <li class="button-dropdown-divider">
                                                          <a recommendId="${recommend.id}" onclick="changeMatchResultStatus(this)" status="3" class="text-info" style="font-size: 1.5vw">走</a>
                                                      </li>
                                                    </ul>
                                                </span>
                                            </div>
                                        </div>
                                        </#items>
                                        </#list>
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
<script src="/production/bootstrap/js/popper.min.js"></script>
<script src="/production/jquery/jquery.min.js"></script>
<script src="/production/bootstrap/js/bootstrap.min.js"></script>
<script src="/production/buttons/js/buttons.js"/>
<script>
    $('.card-header a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
</script>
<script>
    function changeMatchResultStatus(element) {
        var statusBtn = $(element).parents('ul').siblings('button')[0];
        var recommendId = $(element).attr("recommendId");
        var status = $(element).attr("status");
        var statusClass = "";
        if(status==1){
            statusClass="text-danger";
        }else if (status==2){
            statusClass="text-success";
        }else if (status==3){
            statusClass="text-info";
        }else{

        }
        $.ajax({
            url: '/admin/modify/recommend/status',
            method: 'get',
            data: 'recommendId=' + recommendId + '&status=' + status,
            success: function (response) {
                if (response.code == 200) {
                    var text = $(element).text();
                    var statusSpan = '<span class="font-weight-bold '+statusClass+'">' + text + '</span>';
                    $(statusBtn).html(statusSpan);
                } else {
                    $(statusBtn).html('<i class="fa fa-eye"></i>');
                }
            }
        })
    }
</script>
</html>
