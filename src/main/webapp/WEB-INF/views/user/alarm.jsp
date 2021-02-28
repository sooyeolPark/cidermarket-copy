<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>알림내역 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/alarm.css" />
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
			<!-- Ajax로 로드한 결과가 표시될 곳 -->
            <c:choose>
				<%-- 조회결과가 없는 경우 --%>
				<c:when test="${output == null || fn:length(output) == 0}">
					<p class="alert alert-success" role="alert">알림이 없습니다.</p>
				</c:when>
				<%-- 조회결과가 있는 경우 --%>
				<c:otherwise>
					<%-- 조회 결과에 따른 반복 처리 --%>
					<c:forEach var="item" items="${output}" varStatus="status">					
						<div class="alarmList">
							<h4>${item.regdate}</h4>
							<div class="alarmContent">
							<c:choose>
								<c:when test="${item.sort == 'R'}">
								<a href="${pageContext.request.contextPath}/mystore/${shopaddress}/review.cider" class="alarmDel" data-alarno="${item.alarno}">
									<span class="alarmTitle">거래후기</span> 
									<span> <b class="userId">${item.nickname}</b> 님이 회원님과의 거래 후기를 남겼습니다.</span>										
									<i class="glyphicon glyphicon-menu-right"></i>
								</a>
								</c:when>
								<c:when test="${item.sort == 'M'}">
								<a href="${pageContext.request.contextPath}/msgbox/receiver.cider" class="alarmDel" data-alarno="${item.alarno}">
									<span class="alarmTitle">쪽지알림</span> 
									<span> <b class="userId">${item.nickname}</b> 님이 쪽지를 보냈습니다.</span>										
									<i class="glyphicon glyphicon-menu-right"></i>
								</a>
								</c:when>
								<c:otherwise>
								<a href="${pageContext.request.contextPath}/member/record/selling.cider" class="alarmDel" data-alarno="${item.alarno}">
									<span class="alarmTitle">판매완료</span> 
									<span> <b class="userId">${item.nickname}</b> 님이 <b class="pdTitle">${item.subject}</b> 상품을 구매하셨습니다.</span>										
									<i class="glyphicon glyphicon-menu-right"></i>
								</a>
								</c:otherwise>
							</c:choose>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<!-- 리스트 끝 -->
		</div>
	</section>
	<!-- // content 끝 -->
	<script type="text/javascript">
	$(function(){
		$('.alarmDel').click(function(){
			let alarno = $(this).data('alarno');
			$.ajax({
				type: "DELETE",
				url: "${pageContext.request.contextPath}/alarm",
				data: {"alarno":alarno},
				success: function(json) {
					console.log(json);
					if (json.rt == "OK") {
						window.location.reload;
					}
				}
			});
		});
	})
	</script>
</body>

</html>