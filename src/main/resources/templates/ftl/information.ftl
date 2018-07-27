<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Register</title>
    <link rel="stylesheet" href="/production/bootstrap/css/bootstrap.min.css">
    <link rel='stylesheet' href='/production/font-awesome/css/font-awesome.min.css'>
    <link rel="stylesheet" href="/custom/css/register.css">
</head>
<body>

<div class="container">
    <div class="row p-3 ml-3 h1" style="font-size: 3vw">
        完善信息
    </div>
    <div class="col-12 pt-5 pb-3" style="border: 1px solid #e0e0e0;border-radius: 8px;font-size: 1.4vw">
        <form id="registerForm" action="/user/register" method="post">
            <div class="form-group row">
                <label for="realName" class="col-3 p-1 col-md-2 col-form-label text-right">真实姓名</label>
                <div class="col-12 col-md-4">
                    <input type="text" class="form-control" id="realName" name="realName" placeholder="选填">
                </div>
                <label class="col-12 col-md-6 help-block help-default col-form-label" style="font-size: 1.2vw">
                    <i class="fa fa-info-circle">&nbsp;&nbsp;</i>
                    <span class="help-content">真实姓名必须与身份证上面一致，否则将影响提现</span>
                </label>
            </div>
            <div class="form-group row">
                <label for="mobile" class="col-3 p-1 col-md-2 col-form-label text-right">手机号</label>
                <div class="col-12 col-md-4">
                    <input type="text" class="form-control" id="mobile" name="mobile" placeholder="选填">
                </div>
                <div class="col-12 col-md-6 help-mobile" style="display:inline;font-size: 1.2vw">
                    <label class="help-block help-default col-form-label">
                        <i class="fa fa-info-circle">&nbsp;&nbsp;</i>
                        <span class="help-content">手机号为11位数字</span>
                    </label>
                    <label class="help-block help-warning col-form-label" style="display:none">
                    <span class="text-warning">
                        <i class="fa fa-close">&nbsp;</i>手机号不合法，请重新输入
                    </span>
                    </label>
                    <label class="help-block help-success col-form-label" style="display:none;font-size: 15px">
                        <span class="text-success"><i class="fa fa-check">&nbsp;</i>手机号正确</span>
                    </label>
                </div>
            </div>
            <div class="form-group row">
                <label for="email" class="col-3 p-1 col-md-2 col-form-label text-right">邮箱</label>
                <div class="col-12 col-md-4">
                    <input type="text" class="form-control" id="email" name="email" placeholder="选填">
                </div>
                <div class="col-12 col-md-6 help-email" style="display:inline;font-size: 1.2vw">
                    <label class="help-block help-default col-form-label">
                        <span class="help-content"><i class="fa fa-info-circle">&nbsp;&nbsp;</i>邮箱用于找回修改密码，请填写正确</span>
                    </label>
                    <label class="help-block help-warning col-form-label" style="display:none">
                        <span class="text-warning"><i class="fa fa-close">&nbsp;</i>邮箱格式不正确，请重新输入</span>
                    </label>
                    <label class="help-block help-success col-form-label" style="display:none">
                        <span class="text-success"><i class="fa fa-check">&nbsp;</i>邮箱正确</span>
                    </label>
                </div>
            </div>
            <div class="form-group row">
                <div class="offset-md-2 col-12 col-md-4">
                    <button type="submit" id="submitBtn" disabled class="btn btn-warning"
                            style="width: 100%;font-size: 1.3vw">保存修改
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