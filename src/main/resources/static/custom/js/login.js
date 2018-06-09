$('#submitBtn').on('click', function () {
    var options = {
        type: 'POST',
        url: '/user/login',
        data: $('#loginForm').serialize(),
        success: function (data, status) {
            if (status == "success") {
                if (data.code == 3006) {
                    $('.help-tip').text(data.msg);
                } else if (data.code == 2001) {
                    location.href = "/admin?"+$('#loginForm').serialize();
                } else {
                    location.href = "/";
                }
            }
        }
    };
    $.ajax(options);
});


//重置密码模态框
var countdown = 60;
$("#resetBtn").click(function () {
    var email = $('#bindEmail').val();
    if (checkEmail(email)) {
        settime($(this));
    }
});

//ajax请求发送邮件
function sendEmail() {
    $.ajax({
        url: '/user/reset/send/email',
        method: 'get',
        data: "email=" + $('#bindEmail').val(),
        success: function (data) {
            if (data.code == 200) {
                $('#tip').text("邮件已发送，请注意查收");
                $('#tip').removeClass("text-danger");
                $('#tip').addClass("text-success");
            } else {
                $('#tip').text(data.msg);
                $('#tip').removeClass("text-success");
                $('#tip').addClass("text-danger");
            }
        }
    });
}

//检查邮箱地址
function checkEmail(email) {
    if (email.trim().length < 1) {
        $('#tip').text("邮箱不能为空");
        $('#tip').removeClass("text-success");
        $('#tip').addClass("text-danger");
        return false;
    } else {
        var regex = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
        if (!regex.test(email)) {
            $('#tip').text("邮箱格式不正确");
            $('#tip').removeClass("text-success");
            $('#tip').addClass("text-danger");
            return false;
        } else {
            sendEmail();
        }
    }
    return true;
}

//发送邮件倒计时
function settime(obj) {
    if (countdown == 0) {
        obj.attr('disabled', false);
        obj.text("发送邮件");
        countdown = 60;
        return;
    } else {
        obj.attr('disabled', true);
        obj.text("重新发送(" + countdown + ")");
        countdown--;
    }
    setTimeout(function () {
            settime(obj)
        }
        , 1000)
};