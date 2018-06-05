<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>News</title>
    <link rel="stylesheet" href="/custom/css/bigdata.css">
    <link href="/production/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/production/font-awesome/css/font-awesome.min.css">

    <style>
        table td{
            font-size: .8vw;
        }
        table th{
            text-align: center;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand navbar-dark bg-dark" style="font-weight: 500">
    <a class="navbar-brand" href="#">足球计划</a>
        <ul class="navbar-nav mr-auto">
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
</nav>
<div id="main" class="cf">
            ${statList}
            ${statDetail}
</div>
</body>
<script src="/production/jquery/jquery.min.js"></script>
<script src="/production/bootstrap/js/bootstrap.min.js"></script>
<script src="/custom/js/bigdata.js"></script>

</html>