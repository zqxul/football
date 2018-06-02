<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel='stylesheet' href='/production/bootstrap/css/bootstrap.min.css'>
    <link rel='stylesheet' href='/production/font-awesome/css/font-awesome.min.css'>
    <link rel='stylesheet' href='/custom/css/login.css'>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div id="loginDiv" class="col-8 col-md-5">
            <form id="loginForm" class="form-horizontal">
                <span class="heading">用户登录</span>
                <div class="text-center" style="height: 2rem;font-size: 14px">
                    <label class="col-form-label help-block">
                        <span class="text-danger help-tip"></span>
                    </label>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" id="username" name="username" placeholder="用户名">
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group help" style="margin-bottom: 5px">
                    <input type="password" class="form-control" id="password" name="password" placeholder="密　码">
                    <i class="fa fa-lock"></i>
                </div>
                <div class="col-12 login-help" style="padding: 0 40px 40px 40px;font-size: .6vw">
                    <span class="pull-left ml-3">
                        <a href="#" data-toggle="modal" data-target="#resetPassword">忘记密码</a>
                    </span>
                    <span class="pull-right mr-3">
                        还没有账号？<a href="/register">去注册</a>
                    </span>
                </div>
                <div class="form-group" style="padding: 0 40px 20px 0;">
                    <div style="padding: 0px 40px;float: left;">
                        <div class="main-checkbox">
                            <input type="checkbox" value="None" id="rememberMe-checkbox" name="check"/>
                            <label for="rememberMe-checkbox"></label>
                        </div>
                        <span class="text">记住我</span>
                    </div>
                    <button id="submitBtn" type="button" class="btn btn-default"
                            style="padding: 5px 65px;font-size: 1.2vw;">登录
                    </button>
                </div>
            </form>
        </div>
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
<script src="/custom/js/login.js"></script>

</html>