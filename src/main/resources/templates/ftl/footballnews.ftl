<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>News</title>
    <link href="/production/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/production/font-awesome/css/font-awesome.min.css">
    <style>
        #detailBody img {
            max-width: 100%;
            max-height: 280px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="#">足球计划</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link active" href="/football/news/list">每日球报</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/analysis/info">赛事分析</a>
            </li>
            <!--<li class="nav-item">-->
            <!--<a class="nav-link" href="#">冷热指数</a>-->
            <!--</li>-->
            <li class="nav-item">
                <a class="nav-link" href="/live/matchs/lastest">比分直播</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">大数据</a>
            </li>
            <#--<li class="nav-item">-->
                <#--<a class="nav-link" href="#">足彩推荐</a>-->
            <#--</li>-->
            <li class="nav-item">
                <a class="nav-link" href="#">博彩心得</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">会员理财</a>
            </li>
        </ul>
    </div>
</nav>
<main class="p-2">
    <#list footballNews>
        <#items as footballNew>
        <div class="p-2 col-4" style="float: left">
            <div class="media p-2" style="border: 1px solid #e0e0e0;" index="${footballNew_index}" data-toggle="modal" data-target="#newsDetailModal">
                <img class="mr-1 p-2"
                     src="${footballNew.thumb}"
                     alt="Image" style="width: 120px;height: 120px">
                <div class="media-body p-2" style="height: 120px;">
                    <div class="description" style="font-size: 14px;height: 80%">
                        <h6 id="title-${footballNew_index}" class="mt-0">${footballNew.title}</h6>
                    </div>
                    <div class="row publish text-center" style="font-size: 10px;height: 20%">
                        <div id="publishTime-${footballNew_index}" class="col-8 p-0">${footballNew.published_at}</div>
                        <div class="author col-4 p-0">
                            <a id="shareLink-${footballNew_index}" class="btn-link" href="${footballNew.share}"
                               data-toggle="modal" data-target="#newsDetailModal" index="${footballNew_index}">详情</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </#items>
    </#list>
</main>
<div class="modal fade p-0" id="newsDetailModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document" style="max-width: 1000px">
        <div class="modal-content" style="width: 100%;margin: 0 auto;">
            <div class="modal-header">
                <div class="p-2">
                    <h5 class="modal-title" id="detailTitle"></h5>
                    <div class="p-0" style="font-size: 1vw;"><span id="publishTime"></span></div>
                </div>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div id="detailBody" class="modal-body"></div>
            <div class="modal-footer p-1">
                <button type="button" class="btn btn-light" data-dismiss="modal"><i class="fa fa-close"></i></button>
            </div>
        </div>
    </div>
</div>

</body>
<script src="/production/jquery/jquery.min.js"></script>
<script src="/production/bootstrap/js/bootstrap.min.js"></script>
<script>
    function initNewsDetailModel(index) {
        var title = $('#title-' + index).text();
        $('#detailTitle').text(title);
        var publishTime = $('#publishTime-'+index).text();
        $('#publishTime').text(publishTime);
        var url = $('#shareLink-' + index).attr("href");

        $.ajax({
            url: '/football/news/detail?url=' + url,
            type: 'get',
            success: function (response) {
                var html = response;
                $('#detailBody').html(html);
            }
        });


    }

    $('#newsDetailModal').on('show.bs.modal', function (event) {
        var index = $(event.relatedTarget).attr("index");
        initNewsDetailModel(index);
    });
</script>
</html>