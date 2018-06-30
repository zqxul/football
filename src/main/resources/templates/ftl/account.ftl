<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel='stylesheet' href='../production/bootstrap/css/bootstrap.min.css'>
    <link rel='stylesheet' href='../production/font-awesome/css/font-awesome.min.css'>
    <link rel="stylesheet" href="../custom/css/account.css">
    <script src="../production/jquery/jquery.min.js"></script>
    <title>Account</title>
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
            <li class="nav-item">
                <a class="nav-link" href="/recommend/">足彩推荐</a>
            </li>
            <#--<li class="nav-item">-->
                <#--<a class="nav-link" href="#">博彩心得</a>-->
            <#--</li>-->
            <li class="nav-item active">
                <a class="nav-link active" href="/account/">我的账户</a>
            </li>
            <#--<li class="nav-item">-->
                <#--<a class="nav-link" href="#">投资收益</a>-->
            <#--</li>-->
        </ul>
        <ul class="navbar-nav">
            <#if user??>
                <li class="nav-item dropdown" style="width: 165px">
                    <a class="nav-link dropdown-toggle text-center" data-toggle="dropdown" href="#">${user.username}</a>
                    <div class="dropdown-menu dropdown-menu-right text-center" style="min-width: 100px;width: 165px;font-size: 1.2vw">
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
<main class="container">
    <div class="row m-3">
        <div class="col-3">
            <div class="p-1">
                <div class="row" style="height: 150px">
                    <div id="personInfo" class="card p-0 col-12">
                        <div class="card-header text-center p-0">个人信息</div>
                        <div class="card-body">
                            <div class="p-1">用户名：
                                <sapn>${user.username}</sapn>
                            </div>
                            <div class="p-1">会员等级：
                                <sapn>普通</sapn>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row p-0">
                    <div id="assetManagement" class="card p-0 col-12 text-center">
                        <div class="card-header text-center p-0">账户管理</div>
                        <div class="card-body" style="font-size: 1.2vw;">
                            <div style="width: 50%;float: left;"><a class="btn-link" href="#" data-toggle="modal" data-target="#resetPassword">密码修改</a></div>
                            <div style="width: 50%;float: left;"><a class="btn-link" href="#">更改手机</a></div>
                            <div style="width: 50%;float: left;"><a class="btn-link" href="#">更改邮箱</a></div>
                            <div style="width: 50%;float: left;"><a class="btn-link" href="#">完善信息</a></div>
                            <div style="width: 50%;float: left;"><a class="btn-link" href="#" data-toggle="modal"  data-target="#rechargeModal">账户充值</a></div>
                            <div style="width: 50%;float: left;"><a class="btn-link" href="#" data-toggle="modal"  data-target="#withdrawModal">提现申请</a></div>
                            <div style="width: 50%;float: left;"><a class="btn-link" href="#">资产明细</a></div>
                            <div style="width: 50%;float: left;"><a class="btn-link" href="#">收益明细</a></div>
                        </div>
                    </div>
                </div>
                <#--<div class="row p-0">-->
                    <#--<div id="accountManagement" class="card p-0 col-12 text-center">-->
                        <#--<div class="card-header text-center p-0">资产管理</div>-->
                        <#--<div class="card-body" style="font-size: 1.2vw;">-->
                            <#--<div style="width: 50%;float: left;"><a class="btn-link" href="#">账户充值</a></div>-->
                            <#--<div style="width: 50%;float: left;"><a class="btn-link" href="#">提现申请</a></div>-->
                            <#--<div style="width: 50%;float: left;"><a class="btn-link" href="#">资产明细</a></div>-->
                            <#--<div style="width: 50%;float: left;"><a class="btn-link" href="#">收益明细</a></div>-->
                        <#--</div>-->
                    <#--</div>-->
                <#--</div>-->
                <#--<div class="row p-0">-->
                    <#--<div id="wealthCenter" class="card p-0 col-12 text-center">-->
                        <#--<div class="card-header p-0">财富中心</div>-->
                        <#--<div class="card-body" style="font-size: 1.2vw;">-->
                            <#--<div style="width: 50%;float: left;"><a class="btn-link" href="#">足彩宝</a></div>-->
                        <#--</div>-->
                    <#--</div>-->
                <#--</div>-->
            </div>
        </div>
        <div class="col-9">
            <div class="row">
                <div class="p-1 col-7">
                    <div id="assetInfo" class="card p-2 h-100">
                        <div class="row ml-2" style="width: 80px;background-color: #a6bbd2">
                            资产概况
                        </div>
                        <div class="px-2 py-4 h-75 text-center" style="font-size: 1.2vw">
                            <div class="p-1" style="width:50%;float: left">球币余额：<span>${account.amount}</span>
                                <i class="fa fa-stop-circle-o text-warning"></i>
                            </div>
                            <div class="p-1" style="width:50%;float: left">足彩宝余额：<span>1500</span>
                                <i class="fa fa-stop-circle-o text-warning"></i>
                            </div>
                            <div class="p-1" style="width:50%;float: left">可提现额：<span>${account.availableAmount}</span>
                                <i class="fa fa-stop-circle-o text-warning"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="p-1 col-5">
                    <div id="profitInfo" class="card p-2 h-100">
                        <div class="row ml-2" style="width: 80px;background-color: #a6bbd2">
                            收益概况
                        </div>
                        <div class="px-2 py-4 h-75 text-center" style="font-size: 1.2vw">
                            <div class="p-1">累计收益(元)：<span>1500</span>
                                <i class="fa fa-stop-circle-o text-warning"></i>
                            </div>
                            <div class="p-1">万份收益(元)：<span>1500</span>
                                <i class="fa fa-stop-circle-o text-warning"></i>
                            </div>
                            <div class="p-1">七日年化收益(%)：<span>4.5</span>
                                <i class="fa fa-stop-circle-o text-warning"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <#--<div class="row">-->
                <#--<div class="p-1 col-12" style="height: 420px;">-->
                    <#--<div id="analysis-chart" class="card p-1 h-100">-->
                        <#--资产/收益分析-->
                    <#--</div>-->
                <#--</div>-->
            <#--</div>-->
            <div class="row">
                <div class="card-body p-1 information-content h-100">
                    <ul class="nav nav-tabs text-center" style="font-size: 1.2vw;height: 10%">
                        <li class="col p-0 nav-item active">
                            <a class="nav-link active" href="#income">收益明细</a>
                        </li>
                        <li class="col p-0 nav-item">
                            <a class="nav-link" href="#withdraw">提现记录</a>
                        </li>
                        <li class="col p-0 nav-item">
                            <a class="nav-link" href="#recharge">充值记录</a>
                        </li>
                        <li class="col p-0 nav-item">
                            <a class="nav-link" href="#consume">消费记录</a>
                        </li>
                    </ul>
                    <div class="tab-content" style="height: 90%">
                        <ul class="nav" style="font-size: 1.0vw">
                            <li class="nav-item">
                                <a class="nav-link active" href="#">三天</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">一周</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">两周</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">三周</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">一个月</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">两个月</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">三个月</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">半年</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">一年</a>
                            </li>
                        </ul>
                        <div id="income" class="tab-pane card p-2 h-100 active">
                            收益明细
                        </div>
                        <div id="withdraw" class="tab-pane card p-2 h-100">
                            提现记录
                        </div>
                        <div id="recharge" class="tab-pane card p-2 h-100">
                            充值记录
                        </div>
                        <div id="consume" class="tab-pane card p-2 h-100">
                            消费记录
                        </div>
                    </div>
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

<div class="modal fade" id="rechargeModal" tabindex="-1" role="dialog" aria-labelledby="rechargeModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title my-auto" id="rechargeModalTitle" style="font-size: 1vw">1.支付宝扫码并支付(<span class="text-danger">备注必须填写用户名</span>)&nbsp;&nbsp;&nbsp;2.填写支付金额并点击确认充值</div>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body p-0">
                <div class="card">
                    <div class="border-bottom text-center p-4">
                    <img class="card-img-top h-50 w-50" src="/img/alipay.jpeg" alt="QR">
                    </div>
                    <div class="card-body">
                        <input type="hidden" id="rechargeUser" name="recommendId" value="${user.id}"/>
                        <div class="row h-70 m-0">
                            <div class="col p-0"></div>
                            <div class="col-5 p-0 input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text px-1" style="font-size: 1vw;">确认支付金额</span>
                                </div>
                                <input id="rechargeAmount" type="text" class="form-control text-center">
                                <div class="input-group-append">
                                <span class="input-group-text px-1">
                                    <i class="fa fa-cny" style="color: #c78e8c;"></i>
                                </span>
                                </div>
                            </div>
                            <div class="col p-0"></div>
                            <div class="col-3 p-0 m-auto">
                                <button id="rechargeBtn" type="button" class="btn btn-warning btn-sm w-100" onclick="recharge()">确认充值</button>
                            </div>
                            <div class="col p-0"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="withdrawModal" tabindex="-1" role="dialog" aria-labelledby="withdrawModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="withdrawModalTitle">确认提现信息</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="withdrawUser" name="userId" value="${user.id}"/>
                <div class="row h-70 m-0 pb-3">
                    <div class="col p-0"></div>
                    <div class="col-5 p-0 input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text px-1" style="font-size: 1vw;">您将提现</span>
                        </div>
                        <input id="withdrawAmount" type="text" class="form-control text-center">
                        <div class="input-group-append">
                                <span class="input-group-text px-1">
                                    <i class="fa fa-stop-circle-o text-warning"></i>
                                </span>
                        </div>
                    </div>
                    <div class="col-2 py-1 px-0 text-center m-auto" style="font-size: 1vw">
                            <span>手续费(5%)</span>
                    </div>
                    <div class="col-3 p-0 m-auto">
                        <button id="withdrawBtn" type="button" class="btn btn-warning btn-sm w-100" onclick="withdraw()">确认提现</button>
                    </div>
                    <div class="col p-0"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="accountTip" class="row text-center w-100" style="top: 50%;position: absolute;display: block">
    <div id="accountMsg" class="card p-3 m-auto text-center text-success" style="width: 280px;font-size: 1.2vw">
        <#--<span>充值申请提交成功，等待确认&nbsp;<i class="fa fa-check"></i></span>-->
    </div>
</div>
</body>
<script src="../production/bootstrap/js/bootstrap.min.js"></script>
<#--<script src="../production/echart/echarts.js"></script>-->
<script src="../custom/js/account.js"></script>
<script src="/custom/js/repass.js"></script>
</html>