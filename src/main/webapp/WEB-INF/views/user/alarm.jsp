<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>알림내역 - 사이다마켓</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/css/user/alarm.css" />
</head>

<body>
	<div class="topReturn">
		<div class="container">
			<button type="button" class="btn-close"
				onclick="javascript:history.back()">
				<span class="glyphicon glyphicon-remove"></span>
			</button>
		</div>
	</div>

	<!-- content 시작 -->
	<section>
		<!-- 알림 영역 -->
		<div class="container">
			<div class="refresh text-right">
				<button type="button" class="btn" onClick="window.location.reload()">
					<span class="glyphicon glyphicon-refresh"></span>
				</button>
			</div>
			<!-- 리스트 -->
			<div class="alarmList">
				<h4>2020-10-26</h4>
				<div class="alarmContent">
					<a href="${pageContext.request.contextPath}/user/review_view.cider">
						<span class="alarmTitle">거래후기</span> <span> <b
							class="userId">applemania</b> 님이 회원님과의 거래 후기를 남겼습니다.
					</span> <i class="glyphicon glyphicon-menu-right"></i>
					</a>
				</div>
			</div>
			<!-- 리스트 끝 -->
			<!-- 리스트 -->
			<div class="alarmList">
				<h4>2020-10-25</h4>
				<div class="alarmContent">
					<a href="${pageContext.request.contextPath}/user/msgbox.cider">
						<span class="alarmTitle">쪽지알림</span> <span> <b
							class="userId">honolulu</b> 님이 쪽지를 보냈습니다.
					</span> <i class="glyphicon glyphicon-menu-right"></i>
					</a>
				</div>
			</div>
			<!-- 리스트 끝 -->
			<!-- 리스트 -->
			<div class="alarmList">
				<h4>2020-10-24</h4>
				<div class="alarmContent">
					<a
						href="${pageContext.request.contextPath}/user/record_sell.cider?selected=sellend">
						<span class="alarmTitle">판매완료</span> <span> <b
							class="userId">applemania</b> 님이 <b class="pdTitle">에어팟프로 선물용
								미개봉</b> 상품을 구매하셨습니다.
					</span> <i class="glyphicon glyphicon-menu-right"></i>
					</a>
				</div>
			</div>
			<!-- 리스트 끝 -->
		</div>
	</section>
	<!-- // content 끝 -->

</body>

</html>