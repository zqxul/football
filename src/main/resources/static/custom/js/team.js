$(document).ready(function () {
    $(".long").each(function (i) {
        var maxwidth = 28;
        console.log($(this).text().length);
        if ($(this).text().length > maxwidth) {
            $(this).text($(this).text().substring(0, maxwidth));
            $(this).html($(this).html() + '...');
        }
    });

    $('.session_area span:not(:last-child)').append(",");
    var d = new Date()
    var vYear = d.getFullYear();
    var vMon = d.getMonth() + 1;
    var vDay = d.getDate();
    var h = d.getHours();
    var m = d.getMinutes();
    var s = d.getSeconds();
    var nowtimeNum = vYear + (vMon < 10 ? "0" + vMon : vMon) + (vDay < 10 ? "0" + vDay : vDay) + (h < 10 ? "0" + h : h) + (m < 10 ? "0" + m : m) + (s < 10 ? "0" + s : s);
    var matchtimeArr = [];

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
        for (var k in o) if (new RegExp("(" + k + ")").test(format))
            format = format.replace(RegExp.$1,
                RegExp.$1.length == 1 ? o[k] :
                    ("00" + o[k]).substr(("" + o[k]).length));
        return format;
    };

    $(".match_time_hidden").each(function () {
        var str = $(this).text();
        var utc = new Date(Date.parse(str.replace(/-/g, "/")));
        var $time = utc.getTime() + (3600 * 8 * 1000);
        var $date = new Date($time);
        console.log($date);
        var $display = $date.format('MM-dd hh:mm');
        console.log($display);
        $(this).next().text($display);
    });
    $('.match_time_hidden').each(function (i) {
        var matchtimeNum = $(this).text().replace(/[^0-9]/ig, "");
        var poor = Math.abs(nowtimeNum - matchtimeNum);
        matchtimeArr.push(poor);
    })
    var min = Math.min.apply(null, matchtimeArr);

    var showmatchTime = parseInt(nowtimeNum) + parseInt(min);
    var showmatchTime2 = parseInt(nowtimeNum) - parseInt(min);
    var tbodyTotal = $('.schedule_list tbody').length - 1;
    console.log(tbodyTotal);

    $('.match_time_hidden').each(function (i) {
        var matchtimeNum = $(this).text().replace(/[^0-9]/ig, "");
        console.log("比赛时间" + matchtimeNum);
        console.log("显示时间" + showmatchTime);
        console.log("现在时间" + nowtimeNum);
        console.log("最小时间差" + min);
        if (matchtimeNum == showmatchTime || matchtimeNum == showmatchTime2) {
            console.log("find");
            $(this).parents('tbody').show();
            tbodyIdx = $(this).parents('tbody').index('.schedule_list tbody');
            if (tbodyIdx == 0) {
                $('.prepten').addClass("nomore");
                $('.postten').removeClass("nomore");
            } else if (tbodyIdx == tbodyTotal) {
                $('.postten').addClass("nomore");
                $('.prepten').removeClass("nomore");
            } else {
                $('.postten').removeClass("nomore");
                $('.prepten').removeClass("nomore");
            }

        }
    })
    $('.prepten').click(function () {
        tbodyIdx--;

        if (tbodyIdx < 0) {
            tbodyIdx = 0;
        } else if (tbodyIdx == 0) {
            $('.prepten').addClass("nomore");
            $('.schedule_list tbody').eq(tbodyIdx).show().siblings('tbody').hide();
        } else {
            $('.schedule_list tbody').eq(tbodyIdx).show().siblings('tbody').hide();
        }
        if (tbodyIdx == tbodyTotal) {
            $('.postten').addClass("nomore");
        } else {
            $('.postten').removeClass("nomore");
        }
        console.log(tbodyIdx);
    })
    $('.postten').click(function () {
        tbodyIdx++;
        $('.schedule_list tbody').eq(tbodyIdx).show().siblings('tbody').hide();
        if (tbodyIdx >= tbodyTotal) {
            tbodyIdx = tbodyTotal;
            $('.postten').addClass("nomore");
        }
        if (tbodyIdx == 0) {
            $('.prepten').addClass("nomore");
        } else {
            $('.prepten').removeClass("nomore");
        }
        console.log(tbodyIdx);
    })
    var scroll_locked = false;
    var scroll_times = 0;
    (function ($) {
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]);
            return null;
        }
    })(jQuery);
    var page = $.getUrlParam('page');
    var next;
    (page) ? next = page : next = 1;
    var tab = null;
    loadPage(tab, next);
    $(function () {
        next++;
        $(document).scroll(function () {
            window.setTimeout(function () {
                if (scroll_times < 2 && !scroll_locked) {
                    var allHeight = document.body.scrollHeight;
                    var sHeight = document.documentElement.scrollTop || document.body.scrollTop;
                    var winHeight = document.documentElement.clientHeight;
                    var margin = allHeight - sHeight - winHeight;

                    if (margin < 100) {
                        scroll_locked = true;
                        scroll_times = scroll_times + 1;
                        loadPage(tab, next);
                        next++;
                        console.log(next);
                    }
                }
            }, 100)
        });
    });

    function loadPage(id, next) {
        $('.loading').css({visibility: 'visible'});
        $.ajax({
            type: 'GET',
            url: '/data/team/archive?team=' + "50000335" + "&page=" + next,
            success: function (data) {
                var $data = data;
                var newsNum = $data.total;
                var newsNumisTen = newsNum % 10;
                if (newsNumisTen == 0) {
                    var newsPage = newsNum / 10;
                }
                if (!$data) {
                    $('.none_news').show();
                    scroll_locked = true;
                    $('.loading').css({visibility: 'hidden'});
                } else {
                    $.each($data.data, function (index, item) {
                        console.log(item.id);
                        if (item.type != 'video' && !item.is_video) {
                            if (item.description === null) {
                                item.description = "";
                            }
                            var item_video = "";
                            var item_news = "<li>" + item_video +
                                "<a href=" + item.web_url + "target='_blank'>\
                                            <img src=" + item.thumb + " alt=" + item.title + ">\
                                        </a>\
                                        <h2>\
                                            <a href=" + item.web_url + " target='_blank'>" + item.title + "</a>\
                                        </h2>\
                                        <p>" + item.description + "</p>\
                                        <div class='info'>\
                                            <span class='time'>" + item.display_time + item.official_account + "</span>\
                                            <a class='comment' href=" + item.web_url + " target='_blank'>" + item.comments_total + "</a>\
                                        </div>\
                                    </li>"
                            console.log(item_news);
                            if ($data.data.type == 'video') {
                                item_video = "<a href=" + item.web_url + " target='_blank' class='tag_video'></a>"
                            }
                            $("ol").append(item_news);
                        }

                    })
                    $('.pagination_wrapper').empty().append($data.render);
                    $('.loading').css({visibility: 'hidden'});
                    if (next == 1 && $data.data.length == 0) {
                        $('.none_news').show();
                        scroll_locked = true;
                    } else if (next == newsPage && $data.data.length == 10) {
                        console.log('Nten')
                        scroll_locked = true;
                        $('.pagination').css('visibility', 'visible')
                    } else if ($data.data.length < 10 && $data.data.length > 0) {
                        console.log('low')
                        scroll_locked = true;
                        $('.pagination').css('visibility', 'visible')
                    } else {
                        scroll_locked = false;
                        console.log(scroll_times);
                        if (scroll_times === 2) {
                            $('.pagination').css('visibility', 'visible')
                        }
                    }
                }


            },
            error: function () {
                $('.none_news').show();
                scroll_locked = true;
                $('.loading').css({visibility: 'hidden'});
            },
        });
    }
})