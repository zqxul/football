<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>News</title>
    <link rel="stylesheet" href="/custom/css/bigdata.css">
    <link rel="stylesheet" href="/custom/css/team.css">
    <link href="/production/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/production/font-awesome/css/font-awesome.min.css">

    <style>
        table td {
            font-size: .8vw;
        }

        table th {
            text-align: center;
        }
    </style>
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
            <li class="nav-item active">
                <a class="nav-link" href="/data" style="font-weight: 500;">大数据</a>
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
<div id="main" class="cf">
    <div id="con" class="cf" style="padding-top: 0px;margin-top: -10px">
    ${teamDetail}
    </div>
</div>
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
<script src="/production/bootstrap/js/bootstrap.min.js"></script>
<script src="/custom/js/team.js"></script>
<script src="/custom/js/repass.js"></script>
</html>