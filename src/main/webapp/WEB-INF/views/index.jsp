<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
    <%@ include file="inc/head.jsp" %>
    <title>쿨거래 할 땐 사이다마켓!</title>
    <link rel="stylesheet" type="text/css" href="assets/css/user/index.css"/>
</head>

<body>
	<!-- 헤더 영역 -->
    <%@ include file="inc/header.jsp"%>



        <div class="itemReg">
            <button type="button" class="btn btn-lg btn-primary" onclick="location.href='item_reg.html'">내 물건 판매하기</button>
        </div>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                
                <!-- 캐러셀 영역 구성 -->
                <div id="carousel-example-generic" class="carousel slide row" data-ride="carousel">
                    <!-- 현재 위치 표시 -->
                    <ol class="carousel-indicators">
                        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                    </ol>

                    <!-- 내용 영역 -->
                    <div class="carousel-inner">
                        <!-- 항목 (1) -->
                        <div class="item active">
                            <a href="event_view.html"><img src="assets/img/banner_01.jpg" alt="그랜드오픈 기념이벤트 에어팟맥스 100분 추첨 증정" width="100%"></a>
                        </div>
                        <!-- 항목 (2) -->
                        <div class="item">
                            <a href="notice_view.html"><img src="assets/img/banner_02.jpg" alt="쿨하게 거래하자! 사이다마켓!" width="100%"></a>
                        </div>
                        <!-- 항목 (3) -->
                        <div class="item">
                            <a href="notice_view.html"><img src="assets/img/banner_03.jpg" alt="쉽고 간편하게 사고 팔고 관리해요" width="100%"></a>
                        </div>
                    </div>
                    
                    <!-- Controls -->
				    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
				        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				        <span class="sr-only">Previous</span>
				    </a>
				    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
				        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				        <span class="sr-only">Next</span>
				    </a>
                </div>

                <div class="box" id="item-list">
                    <!-- Ajax로 로드한 결과가 표시될 곳 -->
                </div>
                
            </div>
        </section>
        

    <!-- 푸터 영역 -->
    <%@ include file="inc/footer.jsp"%>
    
    
    
    <!-- template -->
		<script id="item_tmpl" type="text/x-handlebars-template">
			{{#each item}}
			<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
                <a href="{{href}}">
                    <div class="sorting thumbnail">
                        <img alt="{{title}}" class="img-rounded" src="assets/{{imgurl}}">
                        <div class="caption">
                            <h5>{{title}}</h5>
                            <h4>{{price}}원</h4>
                        </div>
                    </div>
                </a>
            </div>
			{{/each}}
		</script>

        <!-- Javascript -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/asidebar.jquery.js"></script>
        <script src="assets/js/searchbox.js"></script>
        <script src="assets/js/touchSwipe.js"></script>
        <script src="assets/js/carousel.js"></script>
        <!-- ajax-helper -->
	    <link rel="stylesheet" href="assets/plugins/ajax/ajax_helper.css" />
	    <script src="assets/plugins/ajax/ajax_helper.js"></script>
	    <!-- handlebar plugin -->
	    <script src="assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
        <!-- 사용자 정의 스크립트 -->
		<script type="text/javascript">
			/** AJAX로 JSON데이터를 가져와서 화면에 출력하는 함수 */
			function get_list() {
				$.get("assets/plugins/ajax/item.json", function(req) {
					// 미리 준비한 HTML틀을 읽어온다.
					var template = Handlebars.compile($("#item_tmpl").html());
					// Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
					var html = template(req);
					// #dept_list_body 읽어온 내용을 추가한다.
					$("#item-list").append(html);
				});
			}

			$(function() {
                get_list();	// 최초 불러오기
                /** 스크롤이벤트 정의 */
                $(window).scroll(function(e) {
                    if ($(window).height() + $(window).scrollTop() == $(document).height()) {
                        get_list();
                    };
                });
            });
		</script>
</body>

</html>