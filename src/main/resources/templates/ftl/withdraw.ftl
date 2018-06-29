<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>提现</title>

    <!-- Bootstrap core CSS -->
    <link href="../production/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../production/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="../custom/css/extent.css">
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
                    <a class="nav-link p-2" href="./admin.html">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-home"></i>
                            </span>
                            <span class="col-8 p-0">全站一览</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="./todo.html">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-calendar"></i>
                            </span>
                            <span class="col-8 p-0">待办事项</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="/recharge/">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-cny"></i>
                            </span>
                            <span class="col-8 p-0">充值管理</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item active my-1">
                    <a class="nav-link p-2" href="/withdraw/">
                        <div class="row m-0">
                            <span class="col-4 p-0 text-center" style="width: 50px;">
                                <i class="fa fa-money"></i>
                            </span>
                            <span class="col-8 p-0">提现管理</span>
                        </div>
                    </a>
                </li>
                <li class="nav-item my-1">
                    <a class="nav-link p-2" href="./user.html">
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
                        <h5 class="h5">提现记录</h5>
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
                        <div class="col m-0 p-0 card-body withdraw-card">
                            <ul class="card-header m-0 p-0 nav nav-tabs text-center" style="font-size: 1.2vw">
                                <li class="col-1 p-0 nav-item active">
                                    <a class="nav-link active" href="#waiting" data-toggle="tab">待处理</a>
                                </li>
                                <li class="col-1 p-0 nav-item">
                                    <a class="nav-link" href="#processed" data-toggle="tab">已处理</a>
                                </li>
                                <li class="col-1 p-0 nav-item">
                                    <a class="nav-link" href="#invalid" data-toggle="tab">已失效</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div id="waiting" class="tab-pane active">
                                    <div class="card-body p-0 px-2">
                                        <div class="row m-0 my-2" style="height: 100px;border: 1px solid #e0e0e0;">
                                            <div class="col-9 py-2 px-0">
                                                <div class="row m-0 h-100 text-center" style="font-size: 1.3vw">
                                                    <div class="col">
                                                        <div class="row h-10"></div>
                                                        <div class="row h-50">
                                                            <div class="col"><i class="fa fa-user">&nbsp;</i>用户：<span style="font-size: 1.2vw">张三</span></div>
                                                        </div>
                                                        <div class="row h-50">
                                                            <div class="col"><i class="fa fa-level-up">&nbsp;</i>等级：<span style="font-size: 1.2vw">普通会员</span></div>
                                                        </div>
                                                    </div>
                                                    <div class="col">
                                                        <div class="row h-10"></div>
                                                        <div class="row h-45">
                                                            <div class="col"><i class="fa fa-cny text-danger">&nbsp;</i>提现金额：<span>100</span></div>
                                                        </div>
                                                        <div class="row h-45">
                                                            <div class="col"><i class="fa fa-stop-circle-o text-warning">&nbsp;</i>球币数量：<span>1000</span></div>
                                                        </div>
                                                    </div>
                                                    <div class="col-5 px-4 text-center">
                                                        <div class="row h-70 m-0 pb-3">
                                                            <div class="col p-0"></div>
                                                            <div class="col-9 p-0 input-group">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text px-1" style="font-size: 1vw;">确认金额</span>
                                                                </div>
                                                                <input type="text" class="form-control">
                                                                <div class="input-group-append">
                                                                    <span class="input-group-text px-1">￥</span>
                                                                </div>
                                                            </div>
                                                            <div class="col p-0"></div>
                                                        </div>
                                                        <div class="row h-30 m-0" style="font-size: 1vw">
                                                            <div class="col p-0">创建时间:&nbsp;<span>2018-06-02 16:34:27</span></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--<div class="col p-0"></div>-->
                                            <div class="col-3">
                                                <div class="row m-0 px-2 text-center"
                                                     style="height: 100px;line-height: 85px">
                                                    <div class="col p-1"><a class="btn btn-light">确认提现</a></div>
                                                    <div class="col p-1"><a class="btn btn-light">作废</a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="processed" class="tab-pane">
                                    <div class="card-body p-0 px-2">
                                        <div class="row m-0 my-2" style="height: 100px;border: 1px solid #e0e0e0;">
                                            <div class="col-12 py-2 px-0">
                                                <div class="row m-0 h-100 text-center" style="font-size: 1.3vw">
                                                    <div class="col">
                                                        <div class="row h-10"></div>
                                                        <div class="row h-45">
                                                            <div class="col"><i class="fa fa-user">&nbsp;</i>用户：<span style="font-size: 1.2vw">张三</span></div>
                                                        </div>
                                                        <div class="row h-45">
                                                            <div class="col"><i class="fa fa-level-up">&nbsp;</i>等级：<span style="font-size: 1.2vw">普通会员</span></div>
                                                        </div>
                                                    </div>
                                                    <div class="col">
                                                        <div class="row h-10"></div>
                                                        <div class="row h-45">
                                                            <div class="col"><i class="fa fa-cny text-danger">&nbsp;</i>提现金额：<span>100</span></div>
                                                        </div>
                                                        <div class="row h-45">
                                                            <div class="col"><i class="fa fa-stop-circle-o text-warning">&nbsp;</i>球币数量：<span>1000</span></div>
                                                        </div>
                                                    </div>
                                                    <div class="col-3"></div>
                                                    <div class="col-4 px-4 text-center">
                                                        <div class="row h-70 m-0 pb-3">
                                                            <div class="col p-0"></div>
                                                            <div class="col-9 p-0 input-group">
                                                                <div class="col p-2" style="font-size: 1.2vw">
                                                                    <span class="p-2 text-success">提现成功</span>
                                                                    <!--<span class="p-2 text-danger">提现失败</span>-->
                                                                    <!--<span class="p-2 text-invalid">已失效</span>-->
                                                                </div>
                                                            </div>
                                                            <div class="col p-0"></div>
                                                        </div>
                                                        <div class="row h-30 m-0" style="font-size: 1vw">
                                                            <div class="col p-0">创建时间:&nbsp;<span>2018-06-02 16:34:27</span></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="invalid" class="tab-pane">
                                    <div class="card-body p-0 px-2">
                                        <div class="row m-0 my-2" style="height: 100px;border: 1px solid #e0e0e0;">
                                            <div class="col-12 py-2 px-0">
                                                <div class="row m-0 h-100 text-center" style="font-size: 1.3vw">
                                                    <div class="col">
                                                        <div class="row h-10"></div>
                                                        <div class="row h-45">
                                                            <div class="col"><i class="fa fa-user">&nbsp;</i>用户：<span style="font-size: 1.2vw">张三</span></div>
                                                        </div>
                                                        <div class="row h-45">
                                                            <div class="col"><i class="fa fa-level-up">&nbsp;</i>等级：<span style="font-size: 1.2vw">普通会员</span></div>
                                                        </div>
                                                    </div>
                                                    <div class="col">
                                                        <div class="row h-10"></div>
                                                        <div class="row h-45">
                                                            <div class="col"><i class="fa fa-cny text-danger">&nbsp;</i>提现金额：<span>100</span></div>
                                                        </div>
                                                        <div class="row h-45">
                                                            <div class="col"><i class="fa fa-stop-circle-o text-warning">&nbsp;</i>球币数量：<span>1000</span></div>
                                                        </div>
                                                    </div>
                                                    <div class="col-3"></div>
                                                    <div class="col-4 px-4 text-center">
                                                        <div class="row h-70 m-0 pb-3">
                                                            <div class="col p-0"></div>
                                                            <div class="col-9 p-0 input-group">
                                                                <div class="col p-2" style="font-size: 1.2vw">
                                                                    <!--<span class="p-2 text-success">提现成功</span>-->
                                                                    <!--<span class="p-2 text-danger">提现失败</span>-->
                                                                    <span class="p-2 text-invalid">已失效</span>
                                                                </div>
                                                            </div>
                                                            <div class="col p-0"></div>
                                                        </div>
                                                        <div class="row h-30 m-0" style="font-size: 1vw">
                                                            <div class="col p-0">创建时间:&nbsp;<span>2018-06-02 16:34:27</span></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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
<script src="../production/bootstrap/js/popper.min.js"></script>
<script src="../production/jquery/jquery.min.js"></script>
<script src="../production/bootstrap/js/bootstrap.min.js"></script>
<script>
    $('.card-header a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
</script>
</html>
