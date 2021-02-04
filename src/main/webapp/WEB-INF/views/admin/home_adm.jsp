<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!doctype html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>관리자 홈 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="assets/css/admin/home_adm.css" />
<link rel="stylesheet" type="text/css" href="assets/css/admin/header&footer_adm.css" />
</head>

<body>
	

	<div class="body_height">
		<div class="container">
			<h4>마켓현황</h4>
			<h5 id="today"></h5>
			<h6 id="today-time"></h6>
			<ul class="home_ul text-center">
				<li class="home_li"><a href="order_adm.html">
						<span>123,456건</span>
					</a> <span>총 거래건수(일주일 기준)</span></li>
				<li class="home_li"><a href="order_adm.html">
						<span>9,999,999원</span>
					</a> <span>총 거래액(일주일 기준)</span></li>
				<li class="home_li"><a href="product_adm.html">
						<span>123,456개</span>
					</a> <span>상품등록수</span></li>
				<li class="home_li"><a href="member_adm.html">
						<span>23,456명</span>
					</a> <span>전체 회원수</span></li>
			</ul>
			<div id="chart">
				<div id="transaction_qty" style="width: 500px; height: 400px;"></div>
				<div id="new_member" style="width: 500px; height: 400px;"></div>
			</div>
		</div>
	</div>



	<!--/row-->
	<hr>
	

	<!--/.container-->
	<!-- Javascript -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/asidebar.jquery.js"></script>
	<script src="assets/js/searchbox.js"></script>
	<script src="plugins/sweetalert/sweetalert2.all.min.js"></script>
	<!-- ajax-helper -->
	<link rel="stylesheet" href="plugins/ajax/ajax_helper.css" />
	<script src="plugins/ajax/ajax_helper.js"></script>
	<script src="plugins/validate/jquery.validate.min.js"></script>
	<script src="plugins/validate/additional-methods.min.js"></script>
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/data.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="https://code.highcharts.com/modules/export-data.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>
	<script type="text/javascript">
        $(function () {
            $(".board_left").load("board_adm_left.html");



            // 추가기능------------------------------------------------------------
         //필터 


        // 로그아웃
        $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('login_adm.html'); 
                }else{

                }
            });
      $("#delete").click(function () {
        swal({ 
          title: '확인',
          text: "정말 삭제 하시겠습니까?" ,
          type:'warning', //종류
          confirmButtonText:'네', //확인버튼 표시문구
          showCancelButton:true, //취소버튼 표시여부
          cancelButtonText:'아니오', //취소버튼 표시문구 
        });
        // .then(function(result){
        //   if(result.value) {   //확인버튼이 눌러진 경우 
        //     swal('로그아웃', '로그아웃 되었습니다.', 'success');
        //   } else if(result.dismiss==='cancel') {  //취소버튼 눌러진경우 
        //     swal('취소', '취소하였습니다.', 'error');
        //   }
        // });
      });

    //   전체선택
      $("#all-check").change(function(){
          $(".board").prop('checked',$(this).prop('checked'));
      });

    //   오늘날짜 대입
    




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
    todayTime = "("+hh+"시"+mi+"분"+"기준"+")" ;
    //alert(today);
    document.getElementById("today").innerHTML = today;
    document.getElementById("today-time").innerHTML = todayTime;
    //$('#date').text(today);
} 

todayTime();

    });
    </script>

	<!-- 구글차트 -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['date', 'qty'],
          ['2020-12-21', 1201],
          ['2020-12-22', 850],
          ['2020-12-23', 991],
          ['2020-12-24', 300],
          ['2020-12-25', 750],
          ['2020-12-26', 750],
          ['2020-12-27',800]


        ]);

        var options = {
          chart: {
            title: '일주일간 거래건수'
          }
        };

        var chart = new google.charts.Bar(document.getElementById('transaction_qty'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>
	<script type="text/javascript">
            google.charts.load('current', {'packages':['bar']});
            google.charts.setOnLoadCallback(drawChart);
      
            function drawChart() {
              var data = google.visualization.arrayToDataTable([
              ['Date', 'Qty', { role: 'style' }],
                ['2020-12-21', 85 ,'#31a05f'],
                ['2020-12-22', 58,'#31a05f'],
                ['2020-12-23', 30,'#31a05f'],
                ['2020-12-24', 200,'#31a05f'],
                ['2020-12-25', 26,'#31a05f'],
                ['2020-12-26', 180,'#31a05f'],
                ['2020-12-27',100,'#31a05f']
      
      
              ]);
      
              var options = {
                chart: {
                  title: '일주일간 회원가입'
                }
              };
      
              var chart = new google.charts.Bar(document.getElementById('new_member'));
      
              chart.draw(data, google.charts.Bar.convertOptions(options));
            }
          </script>

</body>
</html>