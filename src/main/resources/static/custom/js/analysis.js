//collapse的时候切换按钮的icon class
function toggleCardContent(element) {
    var targetId = $(element).parent('a').attr('data-target');
    var target = $(targetId);
    if (target.hasClass('show')) {
        $(element).removeClass('fa-angle-double-up');
        $(element).addClass('fa-angle-double-down');
    } else {
        $(element).removeClass('fa-angle-double-down');
        $(element).addClass('fa-angle-double-up');
        initData(element);
    }
};

//初始化各个tab的数据
function initData(element) {
    var index = $(element).attr('data-index');
    var param = $('#item-form-' + index).serialize();
    initMatchInfo(index, param);
    initMatchHistory(index, param);
    initMatchPoint(index, param);
    initMatchOdd(index, param);
    initInformation(index, param);
    initBFIndex(index, param);
};

//初始化必发指数
function initBFIndex(index, param) {
    var bfIndexBody = $('#bfindex-' + index);
    $.ajax({
        url: '/analysis/bfindex',
        method: 'get',
        data: param,
        success: function (data) {
            if (data != undefined && data != null && data.length > 0) {
                bfIndexBody.html("");
                for (var i = 0; i < data.length; i++) {
                    var dataRow = $('<div class="m-0"></div>');
                    dataRow.html(data[i]);
                    bfIndexBody.append(dataRow);
                }
            }else {
                var emptyBody = $('<div class="m-0 h-100 text-center" style="background: #333;color: #fff;">暂无数据</div>');
                bfIndexBody.html("");
                bfIndexBody.append(emptyBody);
            }
        }
    });
}

//初始化情报数据
function initInformation(index, param) {
    var informationBody = $('#information-' + index);
    $.ajax({
        url: '/analysis/information',
        method: 'get',
        data: param,
        success: function (data) {
            if (data != undefined && data != null && data.length > 0) {
                informationBody.html("");
                informationBody.html(data);
            } else {
                informationBody.html("<div class='h-100 w-100 text-center' style='display: block;background: -webkit-gradient(linear, 0 0, 100% 0, from(#904442), to(#3d4d74));'>暂无情报数据</div>");
            }
        }
    });
}

//初始化赛事tab数据
function initMatchInfo(index, param) {
    //比赛事件
    var timelineBody = $('#timeline-event-body-' + index + ' .card-body');
    //伤停信息
    var hostInjureBody = $('#timeline-injure-body-' + index + ' .hostInjuries .card-body');
    var visitInjureBody = $('#timeline-injure-body-' + index + ' .visitInjuries .card-body');
    //双方阵容
    var hostLineupBody = $('#timeline-lineup-body-' + index + ' .host-lineup-detail');
    var visitLineupBody = $('#timeline-lineup-body-' + index + ' .visit-lineup-detail');
    //技术统计
    var techBody = $('#timeline-tech-body-' + index + ' .card-body');
    $.ajax({
        url: '/analysis/event',
        method: 'get',
        data: param,
        success: function (data) {
            var timelines = data.timelines; //比赛事件数据
            var hostLineup = data.hostLineup;   //主队阵容数据
            var visitLineup = data.visitLineup; //客队阵容数据
            var hostInjuries = data.hostInjuries;   //主队伤停数据
            var visitInjuries = data.visitInjuries; //客队伤停数据
            var techs = data.techs; //技术统计数据

            //比赛事件
            if (timelines != undefined && timelines != null && timelines.length > 0) {
                timelineBody.text('');
                for (var i = 0; i < timelines.length; i++) {
                    var eventRowDiv = $('<div class="row m-0"></div>');

                    var hostDiv = $('<div class="col-5 p-0 text-right"></div>');
                    var eventTimeDiv = $('<div class="col-2 p-0 text-center"></div>');
                    var visitDiv = $('<div class="col-5 p-0 text-left"></div>');

                    var playerSpan = $('<span class="p-0"></span>');
                    var icon = $('<i></i>');
                    var isHost = timelines[i].isHost;
                    var playerName = timelines[i].playerName;
                    var eventTime = timelines[i].eventTime;
                    var eventType = timelines[i].eventType;

                    if (eventType == 1) {   //进球
                        icon.addClass('fa fa-soccer-ball-o text-dark');
                    } else if (eventType == 2) {  //黄牌
                        icon.addClass('fa fa-square text-warning');
                    } else if (eventType == 5) {   //换下
                        icon.addClass('fa fa-arrow-down text-warning');
                    } else if (eventType == 6) {   //换上
                        icon.addClass('fa fa-arrow-up text-success');
                    } else if (eventType == 7) {   //红牌
                        icon.addClass('fa fa-square text-danger');
                    } else if (eventType == 12) {  //乌龙
                        icon.addClass('fa fa-soccer-ball-o text-danger');
                    } else if (eventType == 23) {  //点球
                        icon.addClass('fa fa-soccer-ball-o text-success');
                    }
                    if (isHost == 1) {
                        playerSpan.text(playerName + ' ');
                        hostDiv.append(playerSpan);
                        hostDiv.append(icon);
                    } else {
                        playerSpan.text(' ' + playerName);
                        visitDiv.append(icon);
                        visitDiv.append(playerSpan);
                    }
                    eventTimeDiv.text(eventTime);
                    eventRowDiv.append(hostDiv);
                    eventRowDiv.append(eventTimeDiv);
                    eventRowDiv.append(visitDiv);
                    timelineBody.append(eventRowDiv);
                }
            } else {
                timelineBody.text('暂无数据');
            }

            //伤停情况
            if (hostInjuries != undefined && hostInjuries != null && hostInjuries.length > 0) {
                hostInjureBody.text('');
                for (var i = 0; i < hostInjuries.length; i++) {
                    var shirtNumber = hostInjuries[i].shirtNumber;
                    var playerNmeCn = hostInjuries[i].playerNameCn;
                    var position = hostInjuries[i].position;
                    var injureStatus = hostInjuries[i].injuryStatus;
                    var injureRowDiv = $('<div class="row m-0"></div>');
                    var shirtNumberDiv = $('<div class="col-1 p-0"></div>')
                    shirtNumberDiv.text(shirtNumber);
                    var playerNameDiv = $('<div class="col-5 p-0"></div>');
                    playerNameDiv.text(playerNmeCn);
                    var positionDiv = $('<div class="col-2 p-0"></div>');
                    positionDiv.text(position);
                    var injureStatusDiv = $('<div class="col-2 p-0"></div>');
                    injureStatusDiv.text(injureStatus);
                    injureRowDiv.append(shirtNumberDiv);
                    injureRowDiv.append(playerNameDiv);
                    injureRowDiv.append(positionDiv);
                    injureRowDiv.append(injureStatusDiv);
                    hostInjureBody.append(injureRowDiv);
                }
            } else {
                hostInjureBody.text('暂无数据');
            }
            if (visitInjuries != undefined && visitInjuries != null & visitInjuries.length > 0) {
                visitInjureBody.text('');
                for (var i = 0; i < visitInjuries.length; i++) {
                    var shirtNumber = visitInjuries[i].shirtNumber;
                    var playerNmeCn = visitInjuries[i].playerNameCn;
                    var position = visitInjuries[i].position;
                    var injureStatus = visitInjuries[i].injuryStatus;
                    var injureRowDiv = $('<div class="row m-0"></div>');
                    var shirtNumberDiv = $('<div class="col-1 p-0"></div>')
                    shirtNumberDiv.text(shirtNumber);
                    var playerNameDiv = $('<div class="col-5 p-0"></div>');
                    playerNameDiv.text(playerNmeCn);
                    var positionDiv = $('<div class="col-2 p-0"></div>');
                    positionDiv.text(position);
                    var injureStatusDiv = $('<div class="col-2 p-0"></div>');
                    injureStatusDiv.text(injureStatus);
                    injureRowDiv.append(shirtNumberDiv);
                    injureRowDiv.append(playerNameDiv);
                    injureRowDiv.append(positionDiv);
                    injureRowDiv.append(injureStatusDiv);
                    visitInjureBody.append(injureRowDiv);
                }
            } else {
                visitInjureBody.text('暂无数据');
            }

            //双方阵容
            if (hostLineup != undefined && hostLineup != null && hostLineup.length > 0) {
                hostLineupBody.text('');
                for (var i = 0; i < hostLineup.length; i++) {
                    var name = hostLineup[i].name;
                    var position = hostLineup[i].position;

                    var lineupRowDiv = $('<div class="row m-0"></div>');
                    var positionDiv = $('<div class="col-4 p-0"></div>');
                    positionDiv.text(position);
                    var nameDiv = $('<div class="col-8 p-0"></div>');
                    nameDiv.text(name);
                    lineupRowDiv.append(nameDiv);
                    lineupRowDiv.append(positionDiv);
                    hostLineupBody.append(lineupRowDiv);
                }
            } else {
                hostLineupBody.text('暂无数据');
            }
            if (visitLineup != undefined && visitLineup != null && visitLineup.length > 0) {
                visitLineupBody.text('');
                for (var i = 0; i < visitLineup.length; i++) {
                    var name = visitLineup[i].name;
                    var position = visitLineup[i].position;

                    var lineupRowDiv = $('<div class="row m-0"></div>');
                    var positionDiv = $('<div class="col-4 p-0"></div>');
                    positionDiv.text(position);
                    var nameDiv = $('<div class="col-8 p-0"></div>');
                    nameDiv.text(name);
                    lineupRowDiv.append(nameDiv);
                    lineupRowDiv.append(positionDiv);
                    visitLineupBody.append(lineupRowDiv);
                }
            } else {
                visitLineupBody.text('暂无数据');
            }

            //技术统计
            if (techs != undefined && techs != null && techs.hostPossession != '') {
                var techBodyId = '#timeline-tech-body-' + index;

                //控球率
                $(techBodyId + ' .hostPossession').text(techs.hostPossession);
                $(techBodyId + ' .visitPossession').text(techs.visitPossession);
                $(techBodyId + ' .hostPossessionPercent').css("width", techs.hostPossession);
                $(techBodyId + ' .visitPossessionPercent').css("width", techs.visitPossession);

                //射门
                var totalShoot = Number(techs.hostShoot) + Number(techs.visitShoot);
                if (totalShoot != 0) {
                    $(techBodyId + ' .hostShoot').text(techs.hostShoot);
                    $(techBodyId + ' .visitShoot').text(techs.visitShoot);
                    var hostShootPercent = (1 - Number(techs.visitShoot) / Number(totalShoot)) * 100 + '%';
                    var visitShootPercent = Number(techs.visitShoot) / Number(totalShoot) * 100 + '%';
                    $(techBodyId + ' .hostShootPercent').css("width", hostShootPercent);
                    $(techBodyId + ' .visitShootPercent').css("width", visitShootPercent);
                } else {
                    // $(techBodyId + ' .hostShootPercent').css("width", '100%');
                    // $(techBodyId + ' .visitShootPercent').css("width", '100%');
                    $(techBodyId + ' .hostShoot').css("width", '0%');
                    $(techBodyId + ' .visitShoot').css("width", '0%');
                }

                //射正
                var totalShotsOnTarget = Number(techs.hostShotsOnTarget) + Number(techs.visitShotsOnTarget);
                if (totalShotsOnTarget != 0) {
                    $(techBodyId + ' .hostShotsOnTarget').text(techs.hostShotsOnTarget);
                    $(techBodyId + ' .visitShotsOnTarget').text(techs.visitShotsOnTarget);
                    var hostShotsOnTargetPercent = (1 - Number(techs.visitShotsOnTarget) / Number(totalShotsOnTarget)) * 100 + '%';
                    var visitShotsOnTargetPercent = Number(techs.visitShotsOnTarget) / Number(totalShotsOnTarget) * 100 + '%';
                    $(techBodyId + ' .hostShotsOnTargetPercent').css("width", hostShotsOnTargetPercent);
                    $(techBodyId + ' .visitShotsOnTargetPercent').css("width", visitShotsOnTargetPercent);
                } else {
                    // $(techBodyId + ' .hostShotsOnTargetPercent').css("width", '100%');
                    // $(techBodyId + ' .visitShotsOnTargetPercent').css("width", '100%');
                    $(techBodyId + ' .hostShotsOnTarget').css("width", '0%');
                    $(techBodyId + ' .visitShotsOnTarget').css("width", '0%');
                }

                //危险进攻
                var totalDangerousAttack = Number(techs.hostDangerousAttack) + Number(techs.visitDangerousAttack);
                if (totalDangerousAttack != 0) {
                    $(techBodyId + ' .hostDangerousAttack').text(techs.hostDangerousAttack);
                    $(techBodyId + ' .visitDangerousAttack').text(techs.visitDangerousAttack);
                    var hostDangerousAttackPercent = (1 - Number(techs.visitDangerousAttack) / Number(totalDangerousAttack)) * 100 + '%';
                    var visitDangerousAttackPercent = Number(techs.visitDangerousAttack) / Number(totalDangerousAttack) * 100 + '%';
                    $(techBodyId + ' .hostDangerousAttackPercent').css("width", hostDangerousAttackPercent);
                    $(techBodyId + ' .visitDangerousAttackPercent').css("width", visitDangerousAttackPercent);
                } else {
                    // $(techBodyId + ' .hostDangerousAttackPercent').css("width", '100%');
                    // $(techBodyId + ' .visitDangerousAttackPercent').css("width", '100%');
                    $(techBodyId + ' .hostDangerousAttack').css("width", '0%');
                    $(techBodyId + ' .visitDangerousAttack').css("width", '0%');
                }

                //进攻
                var totalAttack = Number(techs.hostAttack) + Number(techs.visitAttack);
                if (totalAttack != 0) {
                    $(techBodyId + ' .hostAttack').text(techs.hostAttack);
                    $(techBodyId + ' .visitAttack').text(techs.visitAttack);
                    var hostAttackPercent = (1 - Number(techs.visitAttack) / Number(totalAttack)) * 100 + '%';
                    var visitAttackPercent = Number(techs.visitAttack) / Number(totalAttack) * 100 + '%';
                    $(techBodyId + ' .hostAttackPercent').css("width", hostAttackPercent);
                    $(techBodyId + ' .visitAttackPercent').css("width", visitAttackPercent);
                } else {
                    // $(techBodyId + ' .hostAttackPercent').css("width", '100%');
                    // $(techBodyId + ' .visitAttackPercent').css("width", '100%');
                    $(techBodyId + ' .hostAttack').css("width", '0%');
                    $(techBodyId + ' .visitAttack').css("width", '0%');
                }

                //角球
                var totalCorner = Number(techs.hostCorner) + Number(techs.visitCorner);
                if (totalCorner != 0) {
                    $(techBodyId + ' .hostCorner').text(techs.hostCorner);
                    $(techBodyId + ' .visitCorner').text(techs.visitCorner);
                    var hostCornerPercent = (1 - Number(techs.visitCorner) / Number(totalCorner)) * 100 + '%';
                    var visitCornerPercent = Number(techs.visitCorner) / Number(totalCorner) * 100 + '%';
                    $(techBodyId + ' .hostCornerPercent').css("width", hostCornerPercent);
                    $(techBodyId + ' .visitCornerPercent').css("width", visitCornerPercent);
                } else {
                    // $(techBodyId + ' .hostCornerPercent').css("width", '100%');
                    // $(techBodyId + ' .visitCornerPercent').css("width", '100%');
                    $(techBodyId + ' .hostCorner').css("width", '0%');
                    $(techBodyId + ' .visitCorner').css("width", '0%');
                }

                //犯规
                var totalFoul = Number(techs.hostFoul) + Number(techs.visitFoul);
                if (totalFoul != 0) {
                    $(techBodyId + ' .hostFoul').text(techs.hostFoul);
                    $(techBodyId + ' .visitFoul').text(techs.visitFoul);
                    var hostFoulPercent = (1 - Number(techs.visitFoul) / Number(totalFoul)) * 100 + '%';
                    var visitFoulPercent = Number(techs.visitFoul) / Number(totalFoul) * 100 + '%';
                    $(techBodyId + ' .hostFoulPercent').css("width", hostFoulPercent);
                    $(techBodyId + ' .visitFoulPercent').css("width", visitFoulPercent);
                } else {
                    // $(techBodyId + ' .hostFoulPercent').css("width", '100%');
                    // $(techBodyId + ' .visitFoulPercent').css("width", '100%');
                    $(techBodyId + ' .hostFoul').css("width", '0%');
                    $(techBodyId + ' .visitFoul').css("width", '0%');
                }

                //黄牌
                var totalYellowCard = Number(techs.hostYellowCard) + Number(techs.visitYellowCard);
                if (totalYellowCard != 0) {
                    $(techBodyId + ' .hostYellowCard').text(techs.hostYellowCard);
                    $(techBodyId + ' .visitYellowCard').text(techs.visitYellowCard);
                    var hostYellowCardPercent = (1 - Number(techs.visitYellowCard) / Number(totalYellowCard)) * 100 + '%';
                    var visitYellowCardPercent = Number(techs.visitYellowCard) / Number(totalYellowCard) * 100 + '%';
                    $(techBodyId + ' .hostYellowCardPercent').css("width", hostYellowCardPercent);
                    $(techBodyId + ' .visitYellowCardPercent').css("width", visitYellowCardPercent);
                } else {
                    // $(techBodyId + ' .hostYellowCardPercent').css("width", '100%');
                    // $(techBodyId + ' .visitYellowCardPercent').css("width", '100%');
                    $(techBodyId + ' .hostYellowCard').css("width", '0%');
                    $(techBodyId + ' .visitYellowCard').css("width", '0%');
                }

                //红牌
                var totalRedCard = Number(techs.hostRedCard) + Number(techs.visitRedCard);
                if (totalRedCard != 0) {
                    $(techBodyId + ' .hostRedCard').text(techs.hostRedCard);
                    $(techBodyId + ' .visitRedCard').text(techs.visitRedCard);
                    var hostRedCardPercent = (1 - Number(techs.visitRedCard) / Number(totalRedCard)) * 100 + '%';
                    var visitRedCardPercent = Number(techs.visitRedCard) / Number(totalRedCard) * 100 + '%';
                    $(techBodyId + ' .hostRedCardPercent').css("width", hostRedCardPercent);
                    $(techBodyId + ' .visitRedCardPercent').css("width", visitRedCardPercent);
                } else {
                    // $(techBodyId + ' .hostRedCardPercent').css("width", '100%');
                    // $(techBodyId + ' .visitRedCardPercent').css("width", '100%');
                    $(techBodyId + ' .hostRedCardPercent').css("width", '0%');
                    $(techBodyId + ' .visitRedCardPercent').css("width", '0%');
                }
            }
        }
    });
};

//初始化战绩tab数据
function initMatchHistory(index, param) {
    var historyVsBody = $('#matchEvent-vs-cardbody-' + index);
    var historyHostNearlyBody = $('#matchEvent-nearly-host-cardbody-' + index);
    var historyvisitNearlyBody = $('#matchEvent-nearly-visit-cardbody-' + index);
    var historyHostFutureBody = $('#matchEvent-future-host-cardbody-' + index);
    var historyvisitFutureBody = $('#matchEvent-future-visit-cardbody-' + index);
    $.ajax({
        url: '/analysis/history',
        method: 'get',
        data: param,
        success: function (data) {
            var matchHistoryVS = data.matchHistoryVS;
            var matchHistoryHostRecents = data.matchHistoryHostRecents;
            var matchHistoryVisitRecents = data.matchHistoryVisitRecents;
            var matchHistoryHostFutures = data.matchHistoryHostFutures;
            var matchHistoryVisitFutures = data.matchHistoryVisitFutures;

            //客队未来赛事
            if (matchHistoryVisitFutures != undefined && matchHistoryVisitFutures != null && matchHistoryVisitFutures.length > 0) {
                historyvisitFutureBody.text('');
                for (var i = 0; i < matchHistoryVisitFutures.length; i++) {
                    var vsRowDiv = $('<div class="row m-0"></div>');
                    var vsLeagueSpan = $('<span class="col-2 p-0"></span>');
                    vsLeagueSpan.text(matchHistoryVisitFutures[i].leagueName);
                    var vsDateSpan = $('<span class="col-3 p-0"></span>');
                    vsDateSpan.text(matchHistoryVisitFutures[i].beginTime);
                    var vsHostSpan = $('<span class="col p-0"></span>');
                    vsHostSpan.text(matchHistoryVisitFutures[i].hostName);
                    var vsScoreSpan = $('<span class="col-1 p-0">vs</span>');
                    var vsVisitSpan = $('<span class="col p-0"></span>');
                    vsVisitSpan.text(matchHistoryVisitFutures[i].visitName);
                    var vsResult = $('<span class="col-1 p-0"></span>');
                    vsResult.text(matchHistoryVisitFutures[i].gap + "天");
                    vsRowDiv.append(vsLeagueSpan);
                    vsRowDiv.append(vsDateSpan);
                    vsRowDiv.append(vsHostSpan);
                    vsRowDiv.append(vsScoreSpan);
                    vsRowDiv.append(vsVisitSpan);
                    vsRowDiv.append(vsResult);
                    historyvisitFutureBody.append(vsRowDiv);
                }
            } else {
                historyvisitFutureBody.text('暂无数据');
            }

            //主队未来赛事
            if (matchHistoryHostFutures != undefined && matchHistoryHostFutures != null && matchHistoryHostFutures.length > 0) {
                historyHostFutureBody.text('');
                for (var i = 0; i < matchHistoryHostFutures.length; i++) {
                    var vsRowDiv = $('<div class="row m-0"></div>');
                    var vsLeagueSpan = $('<span class="col-2 p-0"></span>');
                    vsLeagueSpan.text(matchHistoryHostFutures[i].leagueName);
                    var vsDateSpan = $('<span class="col-3 p-0"></span>');
                    vsDateSpan.text(matchHistoryHostFutures[i].beginTime);
                    var vsHostSpan = $('<span class="col p-0"></span>');
                    vsHostSpan.text(matchHistoryHostFutures[i].hostName);
                    var vsScoreSpan = $('<span class="col-1 p-0">vs</span>');
                    var vsVisitSpan = $('<span class="col p-0"></span>');
                    vsVisitSpan.text(matchHistoryHostFutures[i].visitName);
                    var vsResult = $('<span class="col-1 p-0"></span>');
                    vsResult.text(matchHistoryHostFutures[i].gap + "天");
                    vsRowDiv.append(vsLeagueSpan);
                    vsRowDiv.append(vsDateSpan);
                    vsRowDiv.append(vsHostSpan);
                    vsRowDiv.append(vsScoreSpan);
                    vsRowDiv.append(vsVisitSpan);
                    vsRowDiv.append(vsResult);
                    historyHostFutureBody.append(vsRowDiv);
                }
            } else {
                historyHostFutureBody.text('暂无数据');
            }

            //客队近10场
            if (matchHistoryVisitRecents != undefined && matchHistoryVisitRecents != null && matchHistoryVisitRecents.length > 0) {
                $("#visit-totalWin-nearly-" + index).text(data.visitRecentWinCount);
                $("#visit-totalDraw-nearly-" + index).text(data.visitRecentDrawCount);
                $("#visit-totalLose-nearly-" + index).text(data.visitRecentLoseCount);
                $("#visit-visitWin-nearly-" + index).text(data.visitRecentVisitWinCount);
                $("#visit-visitDraw-nearly-" + index).text(data.visitRecentVisitDrawCount);
                $("#visit-visitLose-nearly-" + index).text(data.visitRecentVisitLoseCount);
                historyvisitNearlyBody.text('');
                for (var i = 0; i < matchHistoryVisitRecents.length; i++) {
                    var vsRowDiv = $('<div class="row m-0"></div>');
                    var vsLeagueSpan = $('<span class="col-2 p-0"></span>');
                    vsLeagueSpan.text(matchHistoryVisitRecents[i].leagueName);
                    var vsDateSpan = $('<span class="col-3 p-0"></span>');
                    vsDateSpan.text(matchHistoryVisitRecents[i].beginTime);
                    var vsHostSpan = $('<span class="col p-0"></span>');
                    vsHostSpan.text(matchHistoryVisitRecents[i].hostName);
                    var vsScoreSpan = $('<span class="col-1 p-0"></span>');
                    vsScoreSpan.text(matchHistoryVisitRecents[i].score);
                    var vsVisitSpan = $('<span class="col p-0"></span>');
                    vsVisitSpan.text(matchHistoryVisitRecents[i].visitName);
                    var vsResult = $('<span class="col-1 p-0"></span>');
                    var result = matchHistoryVisitRecents[i].result;
                    vsResult.text(result);
                    if (result == "胜") {
                        vsResult.addClass("text-danger");
                    } else if (result == "平") {
                        vsResult.addClass("text-info");
                    } else {
                        vsResult.addClass("text-success");
                    }
                    vsRowDiv.append(vsLeagueSpan);
                    vsRowDiv.append(vsDateSpan);
                    vsRowDiv.append(vsHostSpan);
                    vsRowDiv.append(vsScoreSpan);
                    vsRowDiv.append(vsVisitSpan);
                    vsRowDiv.append(vsResult);
                    historyvisitNearlyBody.append(vsRowDiv);
                }
            } else {
                historyvisitNearlyBody.text('暂无数据');
            }

            //主队近10场
            if (matchHistoryHostRecents != undefined && matchHistoryHostRecents != null && matchHistoryHostRecents.length > 0) {
                $("#host-totalWin-nearly-" + index).text(data.hostRecentWinCount);
                $("#host-totalDraw-nearly-" + index).text(data.hostRecentDrawCount);
                $("#host-totalLose-nearly-" + index).text(data.hostRecentLoseCount);
                $("#host-hostWin-nearly-" + index).text(data.hostRecentHostWinCount);
                $("#host-hostDraw-nearly-" + index).text(data.hostRecentHostDrawCount);
                $("#host-hostLose-nearly-" + index).text(data.hostRecentHostLoseCount);
                historyHostNearlyBody.text('');
                for (var i = 0; i < matchHistoryHostRecents.length; i++) {
                    var vsRowDiv = $('<div class="row m-0"></div>');
                    var vsLeagueSpan = $('<span class="col-2 p-0"></span>');
                    vsLeagueSpan.text(matchHistoryHostRecents[i].leagueName);
                    var vsDateSpan = $('<span class="col-3 p-0"></span>');
                    vsDateSpan.text(matchHistoryHostRecents[i].beginTime);
                    var vsHostSpan = $('<span class="col p-0"></span>');
                    vsHostSpan.text(matchHistoryHostRecents[i].hostName);
                    var vsScoreSpan = $('<span class="col-1 p-0"></span>');
                    vsScoreSpan.text(matchHistoryHostRecents[i].score);
                    var vsVisitSpan = $('<span class="col p-0"></span>');
                    vsVisitSpan.text(matchHistoryHostRecents[i].visitName);
                    var vsResult = $('<span class="col-1 p-0"></span>');
                    var result = matchHistoryHostRecents[i].result;
                    vsResult.text(result);
                    if (result == "胜") {
                        vsResult.addClass("text-danger");
                    } else if (result == "平") {
                        vsResult.addClass("text-info");
                    } else {
                        vsResult.addClass("text-success");
                    }
                    vsRowDiv.append(vsLeagueSpan);
                    vsRowDiv.append(vsDateSpan);
                    vsRowDiv.append(vsHostSpan);
                    vsRowDiv.append(vsScoreSpan);
                    vsRowDiv.append(vsVisitSpan);
                    vsRowDiv.append(vsResult);
                    historyHostNearlyBody.append(vsRowDiv);
                }
            } else {
                historyHostNearlyBody.text('暂无数据');
            }

            //历史战绩
            if (matchHistoryVS != undefined && matchHistoryVS != null && matchHistoryVS.length > 0) {
                $("#totalWin-history-" + index).text(data.vsWinCount);
                $("#totalDraw-history-" + index).text(data.vsDrawCount);
                $("#totalLose-history-" + index).text(data.vsLoseCount);
                $("#hostWin-history-" + index).text(data.vsHostWinCount);
                $("#hostDraw-history-" + index).text(data.vsHostDrawCount);
                $("#hostLose-history-" + index).text(data.vsHostLoseCount);
                historyVsBody.text('');
                for (var i = 0; i < matchHistoryVS.length; i++) {
                    var vsRowDiv = $('<div class="row m-0"></div>');
                    var vsLeagueSpan = $('<span class="col-2 p-0"></span>');
                    vsLeagueSpan.text(matchHistoryVS[i].leagueName);
                    var vsDateSpan = $('<span class="col-3 p-0"></span>');
                    vsDateSpan.text(matchHistoryVS[i].beginTime);
                    var vsHostSpan = $('<span class="col p-0"></span>');
                    vsHostSpan.text(matchHistoryVS[i].hostName);
                    var vsScoreSpan = $('<span class="col-1 p-0"></span>');
                    vsScoreSpan.text(matchHistoryVS[i].score);
                    var vsVisitSpan = $('<span class="col p-0"></span>');
                    vsVisitSpan.text(matchHistoryVS[i].visitName);
                    var vsResult = $('<span class="col-1 p-0"></span>');
                    var result = matchHistoryVS[i].result;
                    vsResult.text(result);
                    if (result == "胜") {
                        vsResult.addClass("text-danger");
                    } else if (result == "平") {
                        vsResult.addClass("text-info");
                    } else {
                        vsResult.addClass("text-success");
                    }
                    vsRowDiv.append(vsLeagueSpan);
                    vsRowDiv.append(vsDateSpan);
                    vsRowDiv.append(vsHostSpan);
                    vsRowDiv.append(vsScoreSpan);
                    vsRowDiv.append(vsVisitSpan);
                    vsRowDiv.append(vsResult);
                    historyVsBody.append(vsRowDiv);
                }
            } else {
                historyVsBody.text('暂无数据');
            }

        }
    });
};

//初始化积分tab数据
function initMatchPoint(index, param) {
    var totalPointBody = $('#totalPoint-cardbody-' + index);
    var hostPointBody = $('#hostPoint-cardbody-' + index);
    var guestPointBody = $('#guestPoint-cardbody-' + index);
    var totalPointTitleSpan = $('#totalPoint-title-' + index);
    var hostPointTitleSpan = $('#hostPoint-title-' + index);
    var guestPointTitleSpan = $('#guestPoint-title-' + index);
    $.ajax({
        url: '/analysis/point',
        method: 'get',
        data: param,
        success: function (data) {
            var matchTotalRanking = data.matchTotalRanking;
            var matchHostRanking = data.matchHostRanking;
            var matchVisitRanking = data.matchVisitRanking;
            if (matchTotalRanking == null || matchTotalRanking == undefined || matchHostRanking == null || matchHostRanking == undefined || matchVisitRanking == null || matchVisitRanking == undefined) {
                hostPointBody.text('暂无数据');
                guestPointBody.text('暂无数据');
                totalPointBody.text('暂无数据');
                return;
            }

            var matchTotalRankings = data.matchTotalRanking.rankings;
            var matchHostRankings = data.matchHostRanking.rankings;
            var matchVisitRankings = data.matchVisitRanking.rankings;

            var matchTotalTitle = data.matchTotalRanking.title;
            var matchHostTitle = data.matchVisitRanking.title;
            var matchVisitTitle = data.matchTotalRanking.title;
            totalPointTitleSpan.text(matchTotalTitle);
            hostPointTitleSpan.text(matchHostTitle);
            guestPointTitleSpan.text(matchVisitTitle);

            //客场积分
            if (matchVisitRankings != undefined && matchVisitRankings != null && matchVisitRankings.length > 0) {
                for (var i = 0; i < matchVisitRankings.length; i++) {
                    var pointRowDiv = $('<div class="row m-0"></div>');

                    var rankingSpan = $('<span class="col p-0"></span>');
                    rankingSpan.text(matchVisitRankings[i].ranking);
                    var teamNameSpan = $('<span class="col-2 p-0"></span>');
                    teamNameSpan.text(matchVisitRankings[i].teamName);
                    var totalSpan = $('<span class="col p-0"></span>');
                    totalSpan.text(matchVisitRankings[i].total);
                    var winSpan = $('<span class="col p-0"></span>');
                    winSpan.text(matchVisitRankings[i].win);
                    var drawSpan = $('<span class="col p-0"></span>');
                    drawSpan.text(matchVisitRankings[i].draw);
                    var loseSpan = $('<span class="col p-0"></span>');
                    loseSpan.text(matchVisitRankings[i].lose);
                    var gsSpan = $('<span class="col p-0"></span>');
                    gsSpan.text(matchVisitRankings[i].gs);
                    var gaSpan = $('<span class="col p-0"></span>');
                    gaSpan.text(matchVisitRankings[i].ga);
                    var gdSpan = $('<span class="col p-0"></span>');
                    gdSpan.text(matchVisitRankings[i].gd);
                    var pointsSpan = $('<span class="col p-0"></span>');
                    pointsSpan.text(matchVisitRankings[i].points);

                    pointRowDiv.append(rankingSpan);
                    pointRowDiv.append(teamNameSpan);
                    pointRowDiv.append(totalSpan);
                    pointRowDiv.append(winSpan);
                    pointRowDiv.append(drawSpan);
                    pointRowDiv.append(loseSpan);
                    pointRowDiv.append(gsSpan);
                    pointRowDiv.append(gaSpan);
                    pointRowDiv.append(gdSpan);
                    pointRowDiv.append(pointsSpan);
                    guestPointBody.append(pointRowDiv);
                }
            } else {
                guestPointBody.text('暂无数据');
            }

            //主场积分
            if (matchHostRankings != undefined && matchHostRankings != null && matchHostRankings.length > 0) {
                for (var i = 0; i < matchHostRankings.length; i++) {
                    var pointRowDiv = $('<div class="row m-0"></div>');

                    var rankingSpan = $('<span class="col p-0"></span>');
                    rankingSpan.text(matchHostRankings[i].ranking);
                    var teamNameSpan = $('<span class="col-2 p-0"></span>');
                    teamNameSpan.text(matchHostRankings[i].teamName);
                    var totalSpan = $('<span class="col p-0"></span>');
                    totalSpan.text(matchHostRankings[i].total);
                    var winSpan = $('<span class="col p-0"></span>');
                    winSpan.text(matchHostRankings[i].win);
                    var drawSpan = $('<span class="col p-0"></span>');
                    drawSpan.text(matchHostRankings[i].draw);
                    var loseSpan = $('<span class="col p-0"></span>');
                    loseSpan.text(matchHostRankings[i].lose);
                    var gsSpan = $('<span class="col p-0"></span>');
                    gsSpan.text(matchHostRankings[i].gs);
                    var gaSpan = $('<span class="col p-0"></span>');
                    gaSpan.text(matchHostRankings[i].ga);
                    var gdSpan = $('<span class="col p-0"></span>');
                    gdSpan.text(matchHostRankings[i].gd);
                    var pointsSpan = $('<span class="col p-0"></span>');
                    pointsSpan.text(matchHostRankings[i].points);

                    pointRowDiv.append(rankingSpan);
                    pointRowDiv.append(teamNameSpan);
                    pointRowDiv.append(totalSpan);
                    pointRowDiv.append(winSpan);
                    pointRowDiv.append(drawSpan);
                    pointRowDiv.append(loseSpan);
                    pointRowDiv.append(gsSpan);
                    pointRowDiv.append(gaSpan);
                    pointRowDiv.append(gdSpan);
                    pointRowDiv.append(pointsSpan);
                    hostPointBody.append(pointRowDiv);
                }
            } else {
                hostPointBody.text('暂无数据');
            }

            //总积分
            if (matchTotalRankings != undefined && matchTotalRankings != null && matchVisitRankings.length > 0) {
                for (var i = 0; i < matchTotalRankings.length; i++) {
                    var pointRowDiv = $('<div class="row m-0"></div>');

                    var rankingSpan = $('<span class="col p-0"></span>');
                    rankingSpan.text(matchTotalRankings[i].ranking);
                    var teamNameSpan = $('<span class="col-2 p-0"></span>');
                    teamNameSpan.text(matchTotalRankings[i].teamName);
                    var totalSpan = $('<span class="col p-0"></span>');
                    totalSpan.text(matchTotalRankings[i].total);
                    var winSpan = $('<span class="col p-0"></span>');
                    winSpan.text(matchTotalRankings[i].win);
                    var drawSpan = $('<span class="col p-0"></span>');
                    drawSpan.text(matchTotalRankings[i].draw);
                    var loseSpan = $('<span class="col p-0"></span>');
                    loseSpan.text(matchTotalRankings[i].lose);
                    var gsSpan = $('<span class="col p-0"></span>');
                    gsSpan.text(matchTotalRankings[i].gs);
                    var gaSpan = $('<span class="col p-0"></span>');
                    gaSpan.text(matchTotalRankings[i].ga);
                    var gdSpan = $('<span class="col p-0"></span>');
                    gdSpan.text(matchTotalRankings[i].gd);
                    var pointsSpan = $('<span class="col p-0"></span>');
                    pointsSpan.text(matchTotalRankings[i].points);

                    pointRowDiv.append(rankingSpan);
                    pointRowDiv.append(teamNameSpan);
                    pointRowDiv.append(totalSpan);
                    pointRowDiv.append(winSpan);
                    pointRowDiv.append(drawSpan);
                    pointRowDiv.append(loseSpan);
                    pointRowDiv.append(gsSpan);
                    pointRowDiv.append(gaSpan);
                    pointRowDiv.append(gdSpan);
                    pointRowDiv.append(pointsSpan);
                    totalPointBody.append(pointRowDiv);
                }
            } else {
                totalPointBody.text('暂无数据');
            }
        }
    });
};

//初始化赔率tab数据
function initMatchOdd(index, param) {
    var europeOddsBody = $('#europeOdds-cardbody-' + index);
    var asiaOddsOddsBody = $('#asiaOdds-cardbody-' + index);
    var sizeOddsBody = $('#sizeOdds-cardbody-' + index);
    $.ajax({
        url: '/analysis/odd',
        method: 'get',
        data: param,
        success: function (data) {
            var ouOdds = data.ouOdds;
            var asiaOdds = data.asiaOdds;
            var dxpOdds = data.dxpOdds;

            //大小球数据
            if (dxpOdds != undefined && dxpOdds != null && dxpOdds.length > 0) {
                for (var i = 0; i < dxpOdds.length; i++) {
                    var oddRowDiv = $('<div class="row m-0"></div>');
                    var companyDiv = $('<div class="col-3 p-0" style="border: 1px solid #e0e0e0;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;"></div>');
                    companyDiv.text(dxpOdds[i].companyCnName);

                    var firstOddDiv = $('<div class="col p-0" style="border: 1px solid #e0e0e0;"></div>');
                    var firstBigLevelSpan = $('<span class="col p-1"></span>');
                    firstBigLevelSpan.text(dxpOdds[i].firstBigLevel);
                    var firstHandicapSpan = $('<span class="col p-1"></span>');
                    firstHandicapSpan.text(dxpOdds[i].firstHandicap);
                    var firstSmallLevelSpan = $('<span class="col p-1"></span>');
                    firstSmallLevelSpan.text(dxpOdds[i].firstSmallLevel);
                    firstOddDiv.append(firstBigLevelSpan);
                    firstOddDiv.append(firstHandicapSpan);
                    firstOddDiv.append(firstSmallLevelSpan);

                    var nowOddDiv = $('<div class="col p-0" style="border: 1px solid #e0e0e0;"></div>');
                    var nowBigLevelSpan = $('<span class="col p-1"></span>');
                    nowBigLevelSpan.text(dxpOdds[i].nowBigLevel);
                    var nowHandicapSpan = $('<span class="col p-1"></span>');
                    nowHandicapSpan.text(dxpOdds[i].nowHandicap);
                    var nowSmallLevelSpan = $('<span class="col p-1"></span>');
                    nowSmallLevelSpan.text(dxpOdds[i].nowSmallLevel);
                    nowOddDiv.append(nowBigLevelSpan);
                    nowOddDiv.append(nowHandicapSpan);
                    nowOddDiv.append(nowSmallLevelSpan);

                    oddRowDiv.append(companyDiv);
                    oddRowDiv.append(firstOddDiv);
                    oddRowDiv.append(nowOddDiv);

                    sizeOddsBody.append(oddRowDiv);
                }
            } else {
                sizeOddsBody.text('暂无数据');
            }

            //亚盘数据
            if (asiaOdds != undefined && asiaOdds != null && asiaOdds.length > 0) {
                for (var i = 0; i < asiaOdds.length; i++) {
                    var oddRowDiv = $('<div class="row m-0"></div>');
                    var companyDiv = $('<div class="col-2 p-0" style="border: 1px solid #e0e0e0;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;"></div>');
                    companyDiv.text(asiaOdds[i].companyCnName);

                    var firstOddDiv = $('<div class="col p-0" style="border: 1px solid #e0e0e0;"></div>');
                    var firstHostLevelSpan = $('<span class="col p-1"></span>');
                    firstHostLevelSpan.text(asiaOdds[i].firstHostLevel);
                    var firstConcedeSpan = $('<span class="col-2 p-1"></span>');
                    firstConcedeSpan.text(asiaOdds[i].firstConcede);
                    var firstVisitLevelSpan = $('<span class="col p-1"></span>');
                    firstVisitLevelSpan.text(asiaOdds[i].firstVisitLevel);
                    firstOddDiv.append(firstHostLevelSpan);
                    firstOddDiv.append(firstConcedeSpan);
                    firstOddDiv.append(firstVisitLevelSpan);

                    var nowOddDiv = $('<div class="col p-0" style="border: 1px solid #e0e0e0;"></div>');
                    var nowHostLevelSpan = $('<span class="col p-1"></span>');
                    nowHostLevelSpan.text(asiaOdds[i].nowHostLevel);
                    var nowConcedeSpan = $('<span class="col-2 p-1"></span>');
                    nowConcedeSpan.text(asiaOdds[i].nowConcede);
                    var nowVisitLevelSpan = $('<span class="col p-1"></span>');
                    nowVisitLevelSpan.text(asiaOdds[i].nowVisitLevel);
                    nowOddDiv.append(nowHostLevelSpan);
                    nowOddDiv.append(nowConcedeSpan);
                    nowOddDiv.append(nowVisitLevelSpan);

                    oddRowDiv.append(companyDiv);
                    oddRowDiv.append(firstOddDiv);
                    oddRowDiv.append(nowOddDiv);

                    asiaOddsOddsBody.append(oddRowDiv);
                }
            } else {
                asiaOddsOddsBody.text('暂无数据');
            }

            //欧赔数据
            if (ouOdds != undefined && ouOdds != null && ouOdds.length > 0) {
                for (var i = 0; i < ouOdds.length; i++) {
                    var oddRowDiv = $('<div class="row m-0"></div>');
                    var companyDiv = $('<div class="col-3 p-0" style="border: 1px solid #e0e0e0;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;"></div>');
                    companyDiv.text(ouOdds[i].companyCnName);

                    var firstOddDiv = $('<div class="col p-0" style="border: 1px solid #e0e0e0;"></div>');
                    var firstHostOddSpan = $('<span class="col p-1"></span>');
                    firstHostOddSpan.text(ouOdds[i].firstHostOdds);
                    var firstDrawOddSpan = $('<span class="col p-1"></span>');
                    firstDrawOddSpan.text(ouOdds[i].firstDrawOdds);
                    var firstVisitOddSpan = $('<span class="col p-1"></span>');
                    firstVisitOddSpan.text(ouOdds[i].firstVisitOdds);
                    firstOddDiv.append(firstHostOddSpan);
                    firstOddDiv.append(firstDrawOddSpan);
                    firstOddDiv.append(firstVisitOddSpan);

                    var nowOddDiv = $('<div class="col p-0" style="border: 1px solid #e0e0e0;"></div>');
                    var nowHostOddSpan = $('<span class="col p-1"></span>');
                    nowHostOddSpan.text(ouOdds[i].nowHostOdds);
                    var nowDrawOddSpan = $('<span class="col p-1"></span>');
                    nowDrawOddSpan.text(ouOdds[i].nowDrawOdds);
                    var nowVisitOddSpan = $('<span class="col p-1"></span>');
                    nowVisitOddSpan.text(ouOdds[i].nowVisitOdds);
                    nowOddDiv.append(nowHostOddSpan);
                    nowOddDiv.append(nowDrawOddSpan);
                    nowOddDiv.append(nowVisitOddSpan);

                    oddRowDiv.append(companyDiv);
                    oddRowDiv.append(firstOddDiv);
                    oddRowDiv.append(nowOddDiv);

                    europeOddsBody.append(oddRowDiv);
                }
            } else {
                europeOddsBody.text('暂无数据');
            }
        }
    });

};

//tab切换控制
$(function () {
    // $('.information-content a:first').tab('show');
    $('.information-content a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
});

//箭头图标事件绑定
$(function () {
    $('.icon-updown').click(function () {
        toggleCardContent(this);
    });
});



