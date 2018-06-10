<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <#--<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">-->
    <link rel='stylesheet' href='/production/bootstrap/css/bootstrap.min.css'>
    <link rel='stylesheet' href='/production/font-awesome/css/font-awesome.min.css'>
    <script src="/production/jquery/jquery.min.js"></script>
    <title>首页</title>
    <style>
        .w-80{
            width: 80%;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand navbar-dark bg-dark">
    <a class="navbar-brand" href="#">玩个球</a>
    <div class="collapse navbar-collapse justify-content-between">
        <ul class="navbar-nav">
            <li class="nav-item active">
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
            <#--<li class="nav-item">-->
                <#--<a class="nav-link" href="/recommend/">足彩推荐</a>-->
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
                    <div class="dropdown-menu dropdown-menu-right text-center"
                         style="min-width: 100px;width: 165px;font-size: 1.2vw">
                        <a class="dropdown-item px-2 py-1" href="#">我的账户</a>
                        <a class="dropdown-item px-2 py-1" href="#">修改密码</a>
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
<main class="container pt-4">
    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleControls" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleControls" data-slide-to="1"></li>
            <li data-target="#carouselExampleControls" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img class="d-block w-100" src="/img/first.jpg" alt="First slide" style="height: 540px">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" src="/img/third.jpg" alt="Second slide" style="height: 540px">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" src="/img/second.jpg" alt="Second slide" style="height: 540px">
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</main>
</body>
<script src="/production/bootstrap/js/bootstrap.min.js"></script>
</html>