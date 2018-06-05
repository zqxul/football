$('.leagueCheckbox').change(function () {
    var checked = $(this).prop("checked");
    var val = $(this).parent(".league-item").text().trim();
    // alert(checked+"--"+val+'---'+$('.league-hidden-input[value='+val+']').parent('.row-league').attr("class"));
    if (checked) {
        $('.league-hidden-input[value="' + val + '"]').parent('.row-optional').show();
    } else {
        $('.league-hidden-input[value="' + val + '"]').parent('.row-optional').hide();
    }
});
$('.timeCheckbox').change(function () {
    var checked = $(this).prop("checked");
    var val = $(this).parent(".time-item").text().trim();
    if (checked) {
        $('.time-hidden-input[value="' + val + '"]').parent('.row-optional').show();
    } else {
        $('.time-hidden-input[value="' + val + '"]').parent('.row-optional').hide();
    }
});
$('.statusCheckbox').change(function () {
    var checked = $(this).prop("checked");
    var val = $(this).parent(".status-item").text().trim();
    if (checked) {
        if (val == '进行中') {
            $('.matchstatus-hidden-input[value="1"]').parent('.row-optional').show();
        } else {
            $('.status-hidden-input[value="' + val + '"]').parent('.row-optional').show();
        }
    } else {
        if (val == '进行中') {
            $('.matchstatus-hidden-input[value="1"]').parent('.row-optional').hide();
        } else {
            $('.status-hidden-input[value="' + val + '"]').parent('.row-optional').hide();
        }
    }
});
$(function () {
    initPeriods();
});

//初始化选择日期
function initPeriods() {
    $.ajax({
        url: '/live/getPeriods',
        method: 'get',
        success: function (data) {
            if (data != undefined && data != null && data.length > 0) {
                var dateMenus = $('#dateMenus');
                dateMenus.html('');
                for (var i = 0; i < data.length; i++) {
                    var dateMenu = $("<a class=\"dropdown-item\" href=\"/live/matchs?date=" + data[i] + "\">" + data[i] + "</a>");
                    dateMenus.append(dateMenu);
                }
            }
        }
    });
}