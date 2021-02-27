<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
<title>관리자 홈 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/home_adm.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>

	<div class="body_height">
		<div class="container">
			<h4 class="market_title">
				마켓현황 <span id="today"></span> <span id="today-time"></span>
			</h4>

			<ul class="home_ul text-center">
				<li class="home_li">
					<h5>총 거래건수(일주일 기준)</h5> <a href="${pageContext.request.contextPath}/admin/order_adm.cider">
						<strong><fmt:formatNumber value="${recordbyday[0]+recordbyday[1]+recordbyday[2]+recordbyday[3]+
						recordbyday[4]+recordbyday[5]+recordbyday[6]}" pattern="#,###" />건</strong>
					</a>
				</li>
				<li class="home_li">
					<h5>총 거래액(일주일 기준)</h5> <a href="${pageContext.request.contextPath}/admin/order_adm.cider">
						<strong><fmt:formatNumber value="${totalpay}" pattern="#,###" />원</strong>
					</a>
				</li>
				<li class="home_li">
					<h5>상품등록수</h5> <a href="${pageContext.request.contextPath}/admin/product_adm.cider">
						<strong><fmt:formatNumber value="${totalproduct}" pattern="#,###" />개</strong>
					</a>
				</li>
				<li class="home_li">
					<h5>전체 회원수</h5> <a href="${pageContext.request.contextPath}/admin/member_adm.cider">
						<strong><fmt:formatNumber value="${totalmember}" pattern="#,###" />명</strong>
					</a>
				</li>
			</ul>
			<div id="chart">
				<div style="width: 500px; height: 400px;">
				<canvas id="transaction_qty"></canvas>
				</div>
				<div style="width: 500px; height: 400px;">
				<canvas id="new_member"></canvas>
				</div>
			</div>
		</div>
	</div>

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
	<!-- chartjs cdn 참조 -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>

	<script type="text/javascript">
    // 오늘 날짜 조회
	function todayTime() {
	    var todayTime = new Date();
	    var dd = todayTime.getDate();
	    var mm = todayTime.getMonth()+1; // Jan is 0
	    var yyyy = todayTime.getFullYear();
	    var hh =todayTime.getHours();
	    var mi =todayTime.getMinutes();
	
	    if(dd<10){
	        dd = '0'+dd
	    }
	    if(mm<10){
	        mm = '0'+mm
	    }
	
	    today = yyyy + '-' + mm + '-' + dd;
	    todayTime = "("+hh+"시 "+mi+"분 "+"기준"+")" ;
	    //alert(today);
	    document.getElementById("today").innerHTML = today;
	    document.getElementById("today-time").innerHTML = todayTime;
	    //$('#date').text(today);
	} 
    
    function printDateTime(date){
    	var year = date.getFullYear();
    	var month = (date.getMonth() + 1)+"";
    	var day = date.getDate()+"";
    	if(month.length==1){
    		month = "0"+month;
    	}
    	if(day.length==1){
    		month = "0"+month;
    	}
    	return year + '-' + month + '-' + day;
    }
    
    function setDate(i) {
    	  var d = new Date();
    	  var dayOfMonth = d.getDate();
    	  d.setDate(dayOfMonth - i);
    	  return printDateTime(d);
    	}

    var ctx = document.getElementById('transaction_qty').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [ setDate(6), setDate(5), setDate(4), setDate(3), setDate(2), setDate(1), setDate(0)], // 각각의 bar에 표시할 x축 텍스트들 (영화제목)
            datasets: [{
                label: '일별 거래건수', // 범주
                data: [${recordbyday[6]}, ${recordbyday[5]}, ${recordbyday[4]}, ${recordbyday[3]}, ${recordbyday[2]}, ${recordbyday[1]}, ${recordbyday[0]}],       // 각 bar에 대한 y축 좌표 데이터 (관람객 수)
                backgroundColor: 'rgba(255, 99, 132, 0.2)', // 각 bar의 배경 색상
                borderColor: 'rgba(255, 99, 132, 1)',       // 각 bar의 테두리 색상
                borderWidth: 1                              // 각 bar의 테두리 굵기
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
    
    var ctx2 = document.getElementById('new_member').getContext('2d');
    var myChart2 = new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: [ setDate(6), setDate(5), setDate(4), setDate(3), setDate(2), setDate(1), setDate(0)], // 각각의 bar에 표시할 x축 텍스트들 (영화제목)
            datasets: [{
                label: '일별 회원 가입수', // 범주
                data: [${memberbyday[6]}, ${memberbyday[5]}, ${memberbyday[4]}, ${memberbyday[3]}, ${memberbyday[2]}, ${memberbyday[1]}, ${memberbyday[0]}],       // 각 bar에 대한 y축 좌표 데이터 (관람객 수)
                backgroundColor: 'rgba(255, 99, 132, 0.2)', // 각 bar의 배경 색상
                borderColor: 'rgba(255, 99, 132, 1)',       // 각 bar의 테두리 색상
                borderWidth: 1                              // 각 bar의 테두리 굵기
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
        $(function () {			
			todayTime();
        });
          </script>

</body>
</html>