<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>쿨거래 할 땐 사이다마켓!</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>



	<div class="itemReg">
		<button type="button" class="btn btn-lg btn-primary" onclick="location.href='${pageContext.request.contextPath}/itemreg.cider'">내 물건 판매하기</button>
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
						<a href="${pageContext.request.contextPath}/user/event_view.cider">
							<img src="${pageContext.request.contextPath}/assets/img/banner_01.jpg" alt="그랜드오픈 기념이벤트 에어팟맥스 100분 추첨 증정" width="100%">
						</a>
					</div>
					<!-- 항목 (2) -->
					<div class="item">
						<a href="${pageContext.request.contextPath}/user/notice_view.cider">
							<img src="${pageContext.request.contextPath}/assets/img/banner_02.jpg" alt="쿨하게 거래하자! 사이다마켓!" width="100%">
						</a>
					</div>
					<!-- 항목 (3) -->
					<div class="item">
						<a href="${pageContext.request.contextPath}/user/notice_view.cider">
							<img src="${pageContext.request.contextPath}/assets/img/banner_03.jpg" alt="쉽고 간편하게 사고 팔고 관리해요" width="100%">
						</a>
					</div>
				</div>

				<!-- Controls -->
				<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span class="sr-only">Previous</span>
				</a>
				<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> <span class="sr-only">Next</span>
				</a>
			</div>

			<div class="box" id="item-list">
				<!-- Ajax로 로드한 결과가 표시될 곳 -->
				<c:choose>
					<%-- 조회결과가 없는 경우 --%>
					<c:when test="${output == null || fn:length(output) == 0}">
						<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
							<p>등록된 상품이 없습니다.</p>
						</div>
					</c:when>
					<%-- 조회결과가 있는 경우 --%>
					<c:otherwise>
						<%-- 조회 결과에 따른 반복 처리 --%>
						<c:forEach var="item" items="${output}" varStatus="status">
							<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
								<%-- 상세페이지로 이동하기 위한 URL --%>
								<c:url var="viewUrl" value="/product/item_index.cider">
									<c:param name="prodno" value="${item.prodno}" />
								</c:url>
								
				                <a href="${viewUrl}">
				                    <div class="sorting thumbnail">
			                        	<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img${item.filepath}">
				                        <div class="caption">
				                            <h5>${item.subject}</h5>
				                            <h4>${item.price}원</h4>
				                        </div>
				                    </div>
				                </a>
				            </div>
			            </c:forEach>
		            </c:otherwise>
	            </c:choose>
			</div>
	

		</div>
	</section>


	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>



	<!-- template -->
	<script id="prod-item-tmpl" type="text/x-handlebars-template">
		{{#each item}}
		<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
             <a href="${pageContext.request.contextPath}/product/item_index.cider?prodno={{prodno}}">
             	<div class="sorting thumbnail">
                	<img alt="{{subject}}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img{{filepath}}">
                    <div class="caption">
                       	<h5>{{subject}}</h5>
                        <h4>{{price}}원</h4>
                    </div>
                </div>
            </a>
        </div>
		{{/each}}
	</script>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/touchSwipe.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/carousel.js"></script>
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<!-- handlebar plugin -->
	<script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
	<!-- 사용자 정의 스크립트 -->
	<script>
		let nowPage = 1;  // 현재 페이지의 기본값
		let isEnd = false;  // 데이터를 모두 불러온 후 무한스크롤 종료를 위한 전역변수
		
        /** 스크롤이벤트 정의 */
		$(function() {
            $(window).scroll(function(e) {
                if ($(window).height() + $(window).scrollTop() == $(document).height()) {
					// 다음 페이지를 요청하기 위해 페이지 변수 1 증가 후 실행
    				nowPage++;
        			getProduct();
                }
            })
		})
		
		/** Ajax와 Handlebars를 이용해 상품 불러오는 기능 정의 */
		let getProduct = function(){
			if (isEnd == true) {
				return;
			}
			
			// Restful API에 GET 방식 요청
			$.get("${pageContext.request.contextPath}/product", {
				"page": nowPage    // 페이지 번호는 GET 파라미터로 전송한다.
			}, function(json) {
				var source = $("#prod-item-tmpl").html();	// 템플릿 코드 가져오기
				var template = Handlebars.compile(source);  // 템플릿 코드 컴파일
				var result = template(json);	// 템플릿 컴파일 결과물에 json 전달
				$("#item-list").append(result);		// 최종 결과물을 #list 요소에 추가한다.
				
				// 현재 페이지 번호가 전체 페이지 수에 도달했다면 isEnd 전역변수를 true로 바꿔 스크롤 이벤트를 종료시킨다.
				if (json.meta.totalPage <= nowPage) {
					isEnd = true;
				}
        	});
		}
	</script>
</body>

</html>