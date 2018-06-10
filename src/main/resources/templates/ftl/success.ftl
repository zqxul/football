<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel='stylesheet' href='/production/bootstrap/css/bootstrap.min.css'>
    <link rel='stylesheet' href='/production/font-awesome/css/font-awesome.min.css'>
    <meta charset="UTF-8">
    <title>Success</title>
</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="#">玩个球</a>
    <div class="collapse navbar-collapse justify-content-between">
        <ul class="navbar-nav">
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
            <li class="nav-item">
                <a class="nav-link" href="#">足彩推荐</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">博彩心得</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">我的账户</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">投资收益</a>
            </li>
        </ul>
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/login">登录</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/register">注册</a>
            </li>
        </ul>
    </div>
</nav>
<main class="container" style="padding: 10%;">
    <div class="row justify-content-center">
        <div class="col-12 text-center">
            <#if response.code == 200>
                <h5><i class="fa fa-check text-success">&nbsp;&nbsp;</i>恭喜&nbsp;${user.username}&nbsp;成为本站第${count}位会员！
                </h5>
                <div class="p-3" style="font-size: 1.2vw">
                    <a class="col-2" href="/login">去登录</a>
                    <a class="col-2" href="/register">继续注册</a>
                </div>
            <#elseif response.code == 3005>
                <h5><i class="fa fa-close text-danger">&nbsp;&nbsp;</i>注册失败，此用户已存在</h5>
                <div class="p-3" style="font-size: 1.2vw">
                    已有账号?&nbsp;<a class="col-2" href="/login">去登录</a>
                    <a class="col-2" href="/register">重新注册</a>
                </div>
            <#else>
                <h5><i class="fa fa-close text-danger">&nbsp;&nbsp;</i>不好意思，服务器已经归天了</h5>
                <div class="p-3" style="font-size: 1.2vw">
                    已有账号?&nbsp;<a class="col-2" href="/login">去登录</a>
                    <a class="col-2" href="/register">重新注册</a>
                </div>
            </#if>
        </div>
    </div>
</main>
</body>

<script src="/production/jquery/jquery.min.js"></script>
<script src="/production/bootstrap/js/popper.min.js"></script>
<script src="/production/bootstrap/js/bootstrap.min.js"></script>
</html>