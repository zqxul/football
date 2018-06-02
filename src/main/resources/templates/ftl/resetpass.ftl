<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Reset</title>
    <link rel="stylesheet" href="/production/bootstrap/css/bootstrap.min.css">
    <link rel='stylesheet' href='/production/font-awesome/css/font-awesome.min.css'>
    <link rel="stylesheet" href="/custom/css/register.css">
</head>
<body>

<div class="container">
    <div class="row p-3 ml-3 h1" style="font-size: 3vw">
        密码重置
    </div>
    <div class="col-12 pt-5 pb-3" style="border: 1px solid #e0e0e0;border-radius: 8px;font-size: 1.4vw">
        <form id="registerForm" action="/user/reset/pass" method="post">
            <div class="form-group row">
                <label for="username" class="col-3 p-1 col-md-2 col-form-label text-right">用户名</label>
                <div class="col-12 col-md-4">
                    <input type="text" class="form-control" id="username" name="username" value="${username}" readonly>
                    <input type="hidden" class="form-control" name="token" value="${token}">
                </div>
            </div>
            <div class="form-group row">
                <label for="password" class="col-3 p-1 col-md-2 col-form-label text-right">密码</label>
                <div class="col-12 col-md-4">
                    <input type="password" class="form-control required" id="password" name="password" placeholder="必填">
                </div>
                <div class="col-12 col-md-6 help-password" style="display:inline;font-size: 1.2vw">
                    <!--<label class="help-block help-default col-form-label" style="display: none">-->
                    <!--<i class="fa fa-info-circle">&nbsp;&nbsp;</i>-->
                    <!--<span class="help-content">密码由6位以上字母、数字、下划线、符号组成，区分大小写</span>-->
                    <!--</label>-->
                    <label class="help-block help-danger col-form-label" style="display: none">
                        <span class="text-danger"><i class="fa fa-close">&nbsp;</i>密码不能为空</span>
                    </label>
                    <!--<label class="help-block help-success col-form-label">-->
                    <!--<span class="text-success"><i class="fa fa-check">&nbsp;</i>密码可以使用</span>-->
                    <!--</label>-->
                    <label id="level" class="help-block help-success" style="margin-top: .2rem">
                        <div class="pw-bar"></div>
                        <div class="pw-bar-on"></div>
                        <div class="row pw-txt m-0 text-center">
                            <span class="col level-color weak-color">弱</span>
                            <span class="col level-color medium-color">中</span>
                            <span class="col level-color strong-color">强</span>
                        </div>
                    </label>
                </div>
            </div>
            <div class="form-group row">
                <label for="repassword" class="col-3 p-1 col-md-2 col-form-label text-right" style="font-size: 1.4vw">确认密码</label>
                <div class="col-12 col-md-4">
                    <input type="password" class="form-control required" id="repassword" name="repassword"
                           placeholder="必填">
                </div>
                <div class="col-12 col-md-6 help-repassword" style="display:inline;font-size: 1.2vw">
                    <label class="help-block help-default col-form-label">
                        <i class="fa fa-info-circle">&nbsp;&nbsp;</i>
                        <span class="help-content">再次输入密码</span>
                    </label>
                    <label class="help-block help-warning col-form-label" style="display:none">
                        <span class="help-repassword text-warning">
                            <i class="fa fa-close">&nbsp;</i>两次输入的密码不一致
                        </span>
                    </label>
                    <label class="help-block help-success col-form-label" style="display:none">
                    <span class="help-repassword text-success">
                        <i class="fa fa-check">&nbsp;</i>密码正确
                    </span>
                    </label>
                </div>
            </div>
            <div class="form-group row">
                <div class="offset-md-2 col-12 col-md-4">
                    <button type="submit" id="submitBtn" disabled class="btn btn-warning"
                            style="width: 100%;font-size: 1.3vw">提交
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
<script src="/production/jquery/jquery.min.js"></script>
<script src="/production/bootstrap/js/bootstrap.min.js"></script>
<script src="/custom/js/register.js"></script>
</html>