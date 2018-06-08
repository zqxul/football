admin.html<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel='stylesheet' href='../production/bootstrap/css/bootstrap.min.css'>
    <link rel='stylesheet' href='../production/font-awesome/css/font-awesome.min.css'>
    <link rel='stylesheet' href='../custom/css/login.css'>
    <meta charset="UTF-8">
    <title>Account</title>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div id="loginDiv" class="col-8 col-md-5">
            个人中心
        </div>
    </div>
</div>

</body>

<script src="../production/jquery/jquery.min.js"></script>
<script>
    $('#loginForm').on('submit', function () {
        var options = {
            type: 'POST',
            url: '/user/login',
            data: $(this).serialize(),
            success: function (data) {
                // alert(data.msg);
                if (data.data == 1) {
                    location.href = "../html/doctor.html";
                } else if (data.data == 2) {
                    location.href = "../html/patient.html";
                }
                $('.help-tip').html(data.msg);

                // $('.help-block').show();
                // alert(data.msg);
            },
            error: function () {
                alert(data.msg);
                $('.help-tip').html(data.msg);
                // $('.help-block').show();
            }
        };
        $.ajax(options);
    });
</script>
</html>