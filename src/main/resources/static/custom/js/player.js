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
    $('.match_tab a').click(function () {
        var index = $(this).index('.match_tab a');
        $(this).attr('class', "tab_active").siblings('.match_tab a').attr('class', '');
        $('.match_list').eq(index).show().siblings('.match_list').hide();
    });
    //查看更多能力值浮出层
    $('.more_info_button').mouseenter(function (e) {
        var topH = e.clientY - 100;
        console.log(topH);
        if (topH > 220) {
            console.log("ok");
            $('.download_dialog').removeClass("showdown").addClass("showup");
        } else {
            $('.download_dialog').removeClass("showup").addClass("showdown");
        }
        $('.download_dialog').fadeIn(200);
    })
    $('.more_info_button').mouseleave(function () {
        $('.download_dialog').fadeOut(200);
    })
    //相关新闻滚动
    var scroll_locked = false;
    var scroll_times = 0;
    //获取url参数
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
    //下拉加载更多新闻
    function loadPage(id, next) {
        $('.loading').css({visibility: 'visible'});
        $.ajax({
            type: 'GET',
            url: '/data/person/archive?person=' + "50234171" + "&page=" + next,
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
// 能力值六芒星图
var RadarChart = {
    draw: function (id, d, options) {
        var cfg = {
            radius: 5,
            w: 172,
            h: 172,
            factor: .95,
            factorLegend: 0,
            levels: 5,
            maxValue: 100,
            radians: 2 * Math.PI,
            opacityArea: 0.5,
            fontSize: 0
        };
        if ('undefined' !== typeof options) {
            for (var i in options) {
                if ('undefined' !== typeof options[i]) {
                    cfg[i] = options[i];
                }
            }
        }
        cfg.maxValue = Math.max(cfg.maxValue, d3.max(d, function (i) {
            return d3.max(i.map(function (o) {
                return o.value;
            }))
        }));
        var allAxis = (d[0].map(function (i, j) {
            return i.axis
        }));
        var total = allAxis.length;
        var radius = cfg.factor * Math.min(cfg.w / 2, cfg.h / 2);
        d3.select(id).select("svg").remove();
        var g = d3.select(id).append("svg").attr("width", cfg.w).attr("height", cfg.h).append("g");

        var tooltip;

        function getPosition(i, range, factor, func) {
            factor = typeof factor !== 'undefined' ? factor : 1;
            return range * (1 - factor * func(i * cfg.radians / total));
        }

        function getHorizontalPosition(i, range, factor) {
            return getPosition(i, range, factor, Math.sin);
        }

        function getVerticalPosition(i, range, factor) {
            return getPosition(i, range, factor, Math.cos);
        }

        // 网格
        for (var j = 0; j < cfg.levels; j++) {
            var levelFactor = radius * ((j + 1) / cfg.levels);
            g.selectAll(".levels").data(allAxis).enter().append("svg:line")
                .attr("x1", function (d, i) {
                    return getHorizontalPosition(i, levelFactor);
                })
                .attr("y1", function (d, i) {
                    return getVerticalPosition(i, levelFactor);
                })
                .attr("x2", function (d, i) {
                    return getHorizontalPosition(i + 1, levelFactor);
                })
                .attr("y2", function (d, i) {
                    return getVerticalPosition(i + 1, levelFactor);
                })
                .attr("class", "line").style("stroke", "#d6d6d6").style("stroke-width", "0.5px").attr("transform", "translate(" + (cfg.w / 2 - levelFactor) + ", " + (cfg.h / 2 - levelFactor) + ")");
        }
        series = 0;
        var axis = g.selectAll(".axis").data(allAxis).enter().append("g").attr("class", "axis");
        //中心射线
        axis.append("line")
            .attr("x1", cfg.w / 2)
            .attr("y1", cfg.h / 2)
            .attr("x2", function (j, i) {
                return getHorizontalPosition(i, cfg.w / 2, cfg.factor);
            })
            .attr("y2", function (j, i) {
                return getVerticalPosition(i, cfg.h / 2, cfg.factor);
            })
            .attr("class", "line").style("stroke", '#d6d6d6').style("stroke-width", "1px");

        axis.append("text").attr("class", "legend")
            .text(function (d) {
                return d
            })
            .style("font-family", "sans-serif").style("font-size", cfg.fontSize + "px")
            .style("text-anchor", function (d, i) {
                var p = getHorizontalPosition(i, 0.5);
                return (p < 0.4) ? "start" : ((p > 0.6) ? "end" : "middle");
            })
            .attr("transform", function (d, i) {
                var p = getVerticalPosition(i, cfg.h / 2);
                return p < cfg.fontSize ? "translate(0, " + (cfg.fontSize - p) + ")" : "";
            })
            .attr("x", function (d, i) {
                return getHorizontalPosition(i, cfg.w / 2, cfg.factorLegend);
            })
            .attr("y", function (d, i) {
                return getVerticalPosition(i, cfg.h / 2, cfg.factorLegend);
            });

        var item_num = 0
        d[0].forEach(function (item, index) {
            if (item.value == 0) {
                item_num++;
            }
            return item_num;
        });
        if (item_num !== 6) {
            d.forEach(function (y, x) {
                dataValues = [];
                g.selectAll(".nodes")
                    .data(y, function (j, i) {
                        dataValues.push([
                            getHorizontalPosition(i, cfg.w / 2, (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor),
                            getVerticalPosition(i, cfg.h / 2, (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor)
                        ]);
                    });
                dataValues.push(dataValues[0]);
                g.selectAll(".area")
                    .data([dataValues])
                    .enter()
                    .append("polygon")
                    .attr("class", "radar-chart-serie" + series)
                    .style("stroke-width", "1px")
                    .style("stroke", '#66ceff')
                    .attr("points", function (d) {
                        var str = "";
                        for (var pti = 0; pti < d.length; pti++) {
                            str = str + d[pti][0] + "," + d[pti][1] + " ";
                        }
                        return str;
                    })
                    .style("fill", function (j, i) {
                        return '#5fccff'
                    })
                    .style("fill-opacity", cfg.opacityArea)
                    .on('mouseover', function (d) {
                        z = "polygon." + d3.select(this).attr("class");
                        g.selectAll("polygon").transition(200).style("fill-opacity", 0.1);
                        g.selectAll(z).transition(200).style("fill-opacity", .7);
                    })
                    .on('mouseout', function () {
                        g.selectAll("polygon").transition(200).style("fill-opacity", cfg.opacityArea);
                    });
                series++;
            });
            series = 0;
            d.forEach(function (y, x) {

                g.selectAll(".nodes")
                    .data(y).enter()
                    .append("svg:circle").attr("class", "radar-chart-serie" + series)
                    .attr('r', cfg.radius)
                    .attr("alt", function (j) {
                        return Math.max(j.value, 0)
                    })
                    .attr("cx", function (j, i) {
                        dataValues.push([
                            getHorizontalPosition(i, cfg.w / 2, (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor),
                            getVerticalPosition(i, cfg.h / 2, (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor)
                        ]);
                        return getHorizontalPosition(i, cfg.w / 2, (Math.max(j.value, 0) / cfg.maxValue) * cfg.factor);
                    })
                    .attr("cy", function (j, i) {
                        return getVerticalPosition(i, cfg.h / 2, (Math.max(j.value, 0) / cfg.maxValue) * cfg.factor);
                    })
                    .attr("data-id", function (j) {
                        return j.axis
                    })
                    .style("fill", '#5fccff').style("fill-opacity", .9)
                    .text(function (j) {
                        return Math.max(j.value, 0)
                    });

                series++;
            });

        }

        //Tooltip
        tooltip = g.append('text').style('opacity', 0).style('font-family', 'sans-serif').style('font-size', '13px');
    }
};

var data = [];

data[0] = [];
data[0].push({
    axis: "速度 ",
    value: "0"
});
data[0].push({
    axis: "力量",
    value: "0"
});
data[0].push({
    axis: "防守",
    value: "0"
});
data[0].push({
    axis: "盘带 ",
    value: "0"
});
data[0].push({
    axis: "传球",
    value: "0"
});
data[0].push({
    axis: "射门",
    value: "0"
});
RadarChart.draw("#chart", data);
