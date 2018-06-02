//tab切换控制
$(function () {
    $('.information-content a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
});



// 路径配置
require.config({
    paths: {
        echarts: '/production/echart'
    }
});

// 使用
require(
    [
        'echarts',
        'echarts/chart/bar', // 使用柱状图就加载bar模块，按需加载
        'echarts/chart/line'
    ],
    function (ec) {
        // 基于准备好的dom，初始化echarts图表
        var myChart = ec.init(document.getElementById('analysis-chart'));

        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross',
                    crossStyle: {
                        color: '#999'
                    }
                }
            },
            toolbox: {
                feature: {
                    dataView: {show: true, readOnly: false},
                    magicType: {show: true, type: ['line', 'bar']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            legend: {
                data:['资产','收益','收益率']
            },
            xAxis: [
                {
                    type: 'category',
                    data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
                    axisPointer: {
                        type: 'shadow'
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    name: '资产/收益(万)',
                    min: 0,
                    max: 25,
                    interval: 5,
                    axisLabel: {
                        formatter: '{value}'
                    }
                },
                {
                    type: 'value',
                    name: '收益率(％)',
                    min: 0,
                    // max: 300,
                    interval: 10,
                    axisLabel: {
                        formatter: '{value}'
                    }
                }
            ],
            series: [
                {
                    name:'资产',
                    type:'bar',
                    data:[0.2, 0.49, 0.7, 2.32, 2.56, 7.67, 13.56, 16.22, 3.26, 2.00, 0.64, 0.33]
                },
                {
                    name:'收益',
                    type:'bar',
                    data:[2.6, 5.9, 9.0, 2.64, 2.87, 7.07, 17.56, 18.22, 4.87, 1.88, 0.60, 0.23]
                },
                {
                    name:'收益率',
                    type:'line',
                    yAxisIndex: 1,
                    data:[20, 22, 63, 45, 63, 102, 20.3, 23.4, 23.0, 16.5, 52.0, 62]
                }
            ]
        };

        // 为echarts对象加载数据
        myChart.setOption(option);
    }
);