//推荐分布
var recommendChart = echarts.init(document.getElementById('recommendChart'));
var recommendOption = {
    tooltip: {
        trigger: 'item',
        formatter: "{a} <br/>{b}: {c} ({d}%)"
    },
    legend: {
        orient: 'vertical',
        x: 'right',
        data: ['英超', '西甲', '德甲', '意甲', '法甲', '欧冠', '欧联', '荷甲', '葡超', '英冠', '葡甲', '英甲', '德乙', '法乙', '荷乙', '其他']
    },
    series: [
        {
            name: '联赛分布',
            type: 'pie',
            selectedMode: 'single',
            radius: [0, '30%'],
            center: ['35%', '50%'],

            label: {
                normal: {
                    position: 'inner'
                }
            },
            labelLine: {
                normal: {
                    show: false
                }
            },
            data: [
                {value: 335, name: '输', selected: true},
                {value: 679, name: '赢'},
                {value: 1548, name: '走'}
            ]
        },
        {
            name: '输赢分布',
            type: 'pie',
            radius: ['40%', '55%'],
            center: ['35%', '50%'],
            data: [
                {value: 335, name: '英超'},
                {value: 310, name: '西甲'},
                {value: 234, name: '德甲'},
                {value: 135, name: '意甲'},
                {value: 1048, name: '法甲'},
                {value: 251, name: '欧冠'},
                {value: 147, name: '欧联'},
                {value: 13, name: '葡超'},
                {value: 230, name: '英冠'},
                {value: 110, name: '德乙'},
                {value: 500, name: '葡甲'},
                {value: 76, name: '英甲'},
                {value: 89, name: '法乙'},
                {value: 10, name: '荷乙'},
                {value: 3, name: '其他'}
            ]
        }
    ]
};
recommendChart.setOption(recommendOption);

//个人评估
var qualityChart = echarts.init(document.getElementById('qualityChart'));
var qualityOption = {
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        x: 'center',
        data: ['欧赔', '亚盘', '大小球']
    },
    radar: [
        {
            indicator: [
                {text: '状态', max: 100},
                {text: '稳定', max: 100},
                {text: '实力', max: 100},
                {text: '声望', max: 100},
                {text: '经验', max: 100}
            ],
            radius: 80,
            center: ['50%', '60%']
        }
    ],
    series: [
        {
            type: 'radar',
            radarIndex: 0,
            data: [
                {
                    value: [85, 90, 90, 95, 95],
                    name: '欧赔'
                },
                {
                    value: [95, 80, 95, 90, 93],
                    name: '亚盘'
                },
                {
                    value: [75, 50, 35, 60, 83],
                    name: '大小球'
                }
            ]
        }
    ]
};
qualityChart.setOption(qualityOption);