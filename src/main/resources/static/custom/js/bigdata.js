$(function () {
    setLocalTime();

    $('.list').delegate('span.more', 'mouseenter', function () {
        $(this).closest('td').find('.more_list').show();
    });
    $('.list').delegate('td.link', 'mouseleave', function () {
        $(this).find('.more_list').hide();
    });
    var comp = getUrlParam('competition');
    $('#stat_list a').each(function () {
        if ($(this).attr('rel') === comp) {
            $(this).addClass('sel')
        }
    });
    $('#other_list').click(function () {
        if ($('#stat_list .other').is(':visible')) {
            $('#stat_list .other').hide();
            $('#other_list span').html("展开");
            $('#other_list img').attr('src', "/custom/img/data_spread.png");
        } else {
            $('#stat_list .other').toggle(true);
            $('#other_list span').html("收起");
            $('#other_list img').attr('src', "/custom/img/data_retract.png");
        }
    });
});

function setLocalTime() {
    $("td.time").each(function () {
        var str = $(this).attr('utc');
        var utc = new Date(Date.parse(str.replace(/-/g,"/")));
        var time = utc.getTime()+(3600*8*1000);
        var date = new Date(time);
        var display = date.format('yyyy-MM-dd hh:mm');
        $(this).text(display);
    });
}


Date.prototype.format = function (format) {
    var o = {
        "M+": this.getMonth() + 1, //month
        "d+": this.getDate(), //day
        "h+": this.getHours(), //hour
        "m+": this.getMinutes(), //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
        "S": this.getMilliseconds() //millisecond
    }
    if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
        (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)if (new RegExp("(" + k + ")").test(format))
        format = format.replace(RegExp.$1,
            RegExp.$1.length == 1 ? o[k] :
                ("00" + o[k]).substr(("" + o[k]).length));
    return format;
};

function matchinfo_url(url)
{
    window.location.href=url;
}
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}
