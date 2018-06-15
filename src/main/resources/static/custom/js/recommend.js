function initRecommendPanel() {
    $('.recommend-panel a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
}

function initRecommendContent(element) {
    initTeamVS(element);
    initOdds(element);
}

function initOdds(element) {
    var matchId = $(element).attr("matchid");
    var europeOddsRows = $('#europeOddsRows');
    europeOddsRows.html('');
    var asiaOddsRows = $('#asiaOddsRows');
    var sizeOddsRows = $('#sizeOddsRows');
    $.ajax({
        url: '/recommend/detail',
        method: 'get',
        data: 'matchId=' + matchId,
        success: function (data) {
            if (data != undefined && data != null) {
                var yps = data.yp;
                var dxqs = data.dxq;
                var jc = data.jc;

                if (dxqs != undefined && dxqs != null && dxqs.length > 0) {
                    for (var i = 0; i < dxqs.length; i++) {
                        var dxq = dxqs[i];
                        var sizeOddsRow = $('<div class="row m-0 p-1"></div>');
                        var companySpan = $('<span class="company col p-1"></span>');
                        companySpan.text(dxq.bname);
                        var bigSpan = $('<span class="big col p-1 mx-1 border sizeOdd"></span>');
                        bigSpan.text(dxq.o1);
                        var handicapSpan = $('<span class="handicap col p-1 mx-1 border"></span>');
                        handicapSpan.text(dxq.o3);
                        var handicapSpanHide = $('<span class="handicap col p-1 mx-1 border" style="display: none"></span>');
                        handicapSpanHide.text(dxq.o4);
                        var smallSpan = $('<span class="small col p-1 mx-1 border sizeOdd""></span>');
                        smallSpan.text(dxq.o2);
                        sizeOddsRow.append(companySpan);
                        sizeOddsRow.append(bigSpan);
                        sizeOddsRow.append(handicapSpan);
                        sizeOddsRow.append(handicapSpanHide);
                        sizeOddsRow.append(smallSpan);
                        sizeOddsRows.append(sizeOddsRow);
                    }
                }else{

                }

                if (yps != undefined && yps != null && yps.length > 0) {
                    for (var i = 0; i < yps.length; i++) {
                        var yp = yps[i];
                        var asiaOddsRow = $('<div class="row m-0 p-1"></div>');
                        var companySpan = $('<span class="company col p-1"></span>');
                        companySpan.text(yp.bname);
                        var upSpan = $('<span class="up col p-1 mx-1 border asiaOdd"></span>');
                        upSpan.text(yp.o1);
                        var handicapSpan = $('<span class="handicap col p-1 mx-1 border"></span>');
                        handicapSpan.text(yp.o3);
                        var handicapSpanHide = $('<span class="handicap col p-1 mx-1 border" style="display: none"></span>');
                        handicapSpanHide.text(yp.o4);
                        var downSpan = $('<span class="down col p-1 mx-1 border asiaOdd"></span>');
                        downSpan.text(yp.o2);
                        asiaOddsRow.append(companySpan);
                        asiaOddsRow.append(upSpan);
                        asiaOddsRow.append(handicapSpan);
                        asiaOddsRow.append(handicapSpanHide);
                        asiaOddsRow.append(downSpan);
                        asiaOddsRows.append(asiaOddsRow);
                    }
                }

                if (jc != undefined && jc != null) {
                    var europeOddsRow = $('<div class="row m-0 p-1"></div>');
                    var companySpan = $('<span class="company col p-1"></span>');
                    companySpan.text(jc.title);
                    var winSpan = $('<span class="win col p-1 mx-1 border europeOdd"></span>');
                    winSpan.text(jc.o1);
                    var drawSpan = $('<span class="draw col p-1 mx-1 border europeOdd"></span>');
                    drawSpan.text(jc.o2);
                    var lostSpan = $('<span class="lost col p-1 mx-1 border europeOdd"></span>');
                    lostSpan.text(jc.o3);
                    europeOddsRow.append(companySpan);
                    europeOddsRow.append(winSpan);
                    europeOddsRow.append(drawSpan);
                    europeOddsRow.append(lostSpan);
                    europeOddsRows.append(europeOddsRow);
                }

            }
        }
    });
}

function initTeamVS(element) {
    // $('#teamsMenus a').click(function () {
    $('#matchSelection').addClass("dropdownPosition");
    var teamA = $(element).find('.teamA').text();
    var teamB = $(element).find('.teamB').text();
    var teamVS = $('#teamVS');

    var hostTeam = $('<div class="teamA col-5 p-0 text-right d-inline-block" style="text-overflow:ellipsis;white-space: nowrap;overflow: hidden;"></div>');
    var vs = $('<div class="col-2 p-0 text-center d-inline-block"style="text-overflow:ellipsis;white-space: nowrap;overflow: hidden;">VS</div>');
    var visitTeam = $('<div class="teamB col-5 p-0 text-left d-inline-block" style="text-overflow:ellipsis;white-space: nowrap;overflow: hidden;"></div>');
    hostTeam.text(teamA);
    visitTeam.text(teamB);
    teamVS.html("");
    teamVS.append(hostTeam);
    teamVS.append(vs);
    teamVS.append(visitTeam);
    // $('#teamVS .teamA').text(teamA);
    // $('#teamVS .teamB').text(teamB);
    // });
}

function initLeagueAndMatch() {
    initLeagueDiv();
    initMatchDiv();
}

//初始化赛事筛选下拉框的联赛数据
function initLeagueDiv() {
    var leagueDiv = $('#leagueSelection');
    leagueDiv.html("");
    $.ajax({
        url: '/recommend/leagues',
        method: 'get',
        success: function (data) {
            if (data != undefined && data != null && data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    var leagueInput = $('<input class="leagueCheckbox" type="checkbox" onchange="resetMatchDiv(this)" checked>');
                    var span = $('<span class="m-0 ml-2 leagueName" style="font-size: 1.2vw"></span>');
                    span.text(data[i]);
                    var leagueSpan = $('<span class="dropdown-item league-item"></span>');
                    leagueSpan.append(leagueInput);
                    leagueSpan.append(span);
                    leagueDiv.append(leagueSpan);
                }

            }
        }
    });

}

//赛事筛选框选中状态变化时，隐藏或者显示比赛选择下拉框中比赛选项
function resetMatchDiv(element) {
    var checked = $(element).prop("checked");
    var val = $(element).siblings(".leagueName").text().trim();
    var item = $('.leagueNameDiv[leaguename="' + val + '"]');
    if (checked) {
        item.parents('a').show();
    } else {
        item.parents('a').hide();
    }
}

//比赛选择下拉框内容
function initMatchDiv() {
    var matchDiv = $('#teamsMenus');
    matchDiv.html("");
    $.ajax({
        url: '/recommend/matchs',
        method: 'get',
        success: function (data) {
            if (data != undefined && data != null && data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    var matchData = data[i];
                    var hostDiv = $('<div class="teamA col-5 p-0 pr-1 text-right" style="text-overflow:ellipsis;white-space: nowrap;overflow: hidden;"></div>');
                    var vsDiv = $('<div class="col-2 p-0 text-center" style="text-overflow:ellipsis;white-space: nowrap;overflow: hidden;">VS</div>');
                    var visitDiv = $('<div class="teamB col-5 p-0 pl-1 text-left" style="text-overflow:ellipsis;white-space: nowrap;overflow: hidden;"></div>');
                    hostDiv.text(matchData.home_name);
                    visitDiv.text(matchData.away_name);
                    var hiddenDiv = $('<div class="leagueNameDiv" leaguename="' + matchData.league_name + '" style="display: none;"></div>');
                    var vsRow = $('<div class="row mx-0 px-1 py-2 border"></div>');
                    vsRow.append(hostDiv);
                    vsRow.append(vsDiv);
                    vsRow.append(visitDiv);
                    vsRow.append(hiddenDiv);
                    var vsA = $('<a class="dropdown-item p-1" style="font-size: 1vw" matchid="' + matchData.gsm_match_id + '" onclick="initRecommendContent(this)"></a>');
                    vsA.append(vsRow);
                    matchDiv.append(vsA);
                }

            }
        }
    });
}

$(function () {
    $('#recommendModal').on('show.bs.modal', function (event) {
        //显示模态框时恢复teamVS按钮的内容
        $('#matchSelection').removeClass("dropdownPosition");
        $('#teamVS').html("选择比赛");

        initLeagueAndMatch();
        initRecommendPanel();
    });

    //赔率被选中时改变样式
    $('#europeOdds .europeOdd').click(function () {
        $('#europeOdds .europeOdd').css('background-color', '#ffffff');
        $(this).css('background-color', '#9a9a9a');
    });
    $('#asiaOdds .asiaOdd').click(function () {
        $('#asiaOdds .asiaOdd').css('background-color', '#ffffff');
        $(this).css('background-color', '#9a9a9a');
    });
    $('#sizeOdds .sizeOdd').click(function () {
        $('#sizeOdds .sizeOdd').css('background-color', '#ffffff');
        $(this).css('background-color', '#9a9a9a');
    });

});


