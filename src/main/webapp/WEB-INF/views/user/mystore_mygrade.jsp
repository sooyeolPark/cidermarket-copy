<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>내상점-나의등급 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_mygrade.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
	<!-- 화면에 표시될 원본 보기 영역 - 기본적으로 숨겨진 상태이다. -->
	<div class='gray_layer' id='background'></div>
	<div class='over_layer' id='front'>
		<ul>
			<li class="media clearfix"><img class="media-object pull-left" src="${pageContext.request.contextPath}/assets/img/grade_1.png" width="70" height="70">
				<div class="media-body">
					<div class="grade_color">화이트 등급</div>
					<div>기본등급</div>
				</div></li>
			<li class="media clearfix"><img class="media-object pull-left" src="${pageContext.request.contextPath}/assets/img/grade_2.png" width="70" height="70">
				<div class="media-body">
					<div class="grade_color">블루 등급</div>
					<div>최근 90일간 거래 1건 이상</div>
				</div></li>
			<li class="media clearfix"><img class="media-object pull-left" src="${pageContext.request.contextPath}/assets/img/grade_3.png" width="70" height="70">
				<div class="media-body">
					<div class="grade_color">브론즈</div>
					<div>최근 90일간 거래 3건 이상</div>
				</div></li>
			<li class="media clearfix"><img class="media-object pull-left" src="${pageContext.request.contextPath}/assets/img/grade_4.png" width="70" height="70">
				<div class="media-body">
					<div class="grade_color">실버</div>
					<div>최근 90일간 거래 7건 이상</div>
				</div></li>
			<li class="media clearfix"><img class="media-object pull-left" src="${pageContext.request.contextPath}/assets/img/grade_5.png" width="70" height="70">
				<div class="media-body">
					<div class="grade_color">골드 등급</div>
					<div>최근 90일간 거래 15건 이상</div>
				</div></li>

		</ul>
	</div>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<section>
		<div class="container">
			<!-- 유저 프로필 고정부분 -->
			<%@ include file="/WEB-INF/views/inc/user_profile.jsp"%>
		</div>
		<div class="div_blank"></div>
		
		<!-- 탭 화면 시작 -->
		<div id="mygrade">
			<div class="container">
				<div class="media clearfix">
					<c:set var="totalCount" value="${output_sell.month+output_sell.lastmonth+output_sell.lasttwomonth+output_buy.month+output_buy.lastmonth+output_buy.lasttwomonth}" />
					<c:choose>
						<c:when test="${totalCount < 1}">
							<img class="media-object pull-left" src="${pageContext.request.contextPath}/assets/img/grade_1.png" width="70" height="70">
							<div class="media-body">
								<div id="user_grade_now">
									이번달 ${output.nickname}님은 <b>화이트 등급</b>입니다.
								</div>
								<div id="user_number">
									<b>1</b>건 더 거래하면 다음 달에 블루 등급이 됩니다!
								</div>
								<a id="modal" href="#">등급표 보기</a>
							</div>

						</c:when>
						<c:when test="${totalCount > 0 && totalCount < 3}">
							<img class="media-object pull-left" src="${pageContext.request.contextPath}/assets/img/grade_2.png" width="70" height="70">
							<div class="media-body">
								<div id="user_grade_now">
									이번달 ${output.nickname}님은 <b>블루 등급</b>입니다.
								</div>
								<div id="user_number">
									<b>${3-totalCount}</b>건 더 거래하면 브론즈등급이 됩니다!
								</div>
								<a id="modal" href="#">등급표 보기</a>
							</div>
						</c:when>
						<c:when test="${totalCount > 2 && totalCount < 7}">
							<img class="media-object pull-left" src="${pageContext.request.contextPath}/assets/img/grade_3.png" width="70" height="70">
							<div class="media-body">
								<div id="user_grade_now">
									이번달 ${output.nickname}님은 <b>브론즈 등급</b>입니다.
								</div>
								<div id="user_number">
									<b>${7-totalCount}</b>건 더 거래하면 다음 달에 실버 등급이 됩니다!
								</div>
								<a id="modal" href="#">등급표 보기</a>
							</div>
						</c:when>
						<c:when test="${totalCount > 6 && totalCount < 15}">
							<img class="media-object pull-left" src="${pageContext.request.contextPath}/assets/img/grade_4.png" width="70" height="70">
							<div class="media-body">
								<div id="user_grade_now">
									이번달 ${output.nickname}님은 <b>실버 등급</b>입니다.
								</div>
								<div id="user_number">
									<b>${15-totalCount}</b>건 더 거래하면 다음 달에 골드 등급이 됩니다!
								</div>
								<a id="modal" href="#">등급표 보기</a>
							</div>
						</c:when>
						<c:when test="${totalCount > 14}">
							<img class="media-object pull-left" src="${pageContext.request.contextPath}/assets/img/grade_5.png" width="70" height="70">
							<div class="media-body">
								<div id="user_grade_now">
									이번달 ${output.nickname}님은 <b>골드 등급</b>입니다.
								</div>
								<a id="modal" href="#">등급표 보기</a>
							</div>
						</c:when>
					</c:choose>




				</div>

				<div id="trade_ea">
					<div id="trade_ea_subject">최근 90일 거래실적</div>
					<table>


						<tr>
							<td></td>
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:formatDate value="${now}" pattern="M" var="thisMonth" />
							<c:set var="lastMonth" value="${thisMonth-1}" />
							<c:set var="lastTwoMonth" value="${thisMonth-2}" />

							<c:if test="${thisMonth == 0 }">
								<td>12월</td>
							</c:if>
							<c:if test="${thisMonth ==-1 }">
								<td>11월</td>
							</c:if>
							<td>${thisMonth}월</td>
							<c:if test="${lastMonth ==0 }">
								<td>12월</td>
							</c:if>
							<c:if test="${lastMonth ==-1 }">
								<td>11월</td>
							</c:if>
							<td>${lastMonth}월</td>
							<c:if test="${lastTwoMonth ==0 }">
								<td>12월</td>
							</c:if>
							<c:if test="${lastTwoMonth ==-1 }">
								<td>11월</td>
							</c:if>
							<c:if test="${lastTwoMonth ==-1 }">
								<td>${lastTwoMonth}월</td>
							</c:if>
						</tr>

						<tr>
							<!-- 판매합계 출력 -->
							<td>판매</td>
							<td>${output_sell.month}</td>
							<td>${output_sell.lastmonth}</td>
							<td>${output_sell.lasttwomonth}</td>
						</tr>


						<tr>
							<!-- 구매합계 출력 -->
							<td>구매</td>
							<td>${output_buy.month}</td>
							<td>${output_buy.lastmonth}</td>
							<td>${output_buy.lasttwomonth}</td>
						</tr>


					</table>
				</div>
				<div id="trade_anou">
					<div id="trade_anou_subject">유의사항</div>
					<ul id="trade_anou_cont">
						<li>등급은 최근 90일간 실적을 반영하여 매월 1일에 적용됩니다.</li>
						<li>등급 산정 및 헤택은 당사 사정에 의해 변경될 수 있습니다.</li>
						<li>부정한 방법으로 등급을 획득한 경우, 등급이 조정되거나 회원제재가 진행될 수 있습니다.</li>
					</ul>
				</div>
			</div>
		</div>
	</section>

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<script type="text/javascript">
	    /* 서브메뉴버튼 활성화 */
        document.querySelector('.my_ctg li:nth-child(3)').className = 'active';
	    
		$(function() {
			/** modal 링크를 클릭한 경우 */
			$("#modal").click(function(e) {
				e.preventDefault(); // 페이지 이동 방지
				$("#background").fadeIn(300); // 배경 레이어를 화면에 표시한다.
				$("#front").fadeIn(200); // 이미지 레이어를 화면에 표시한다.
			});
			/** (화면에 표시된) 배경 레이어를 클릭한 경우 */
			$("#background").click(function() {
				$(this).fadeOut(300); // 배경 레이어의 숨김
				$("#front").fadeOut(200); // 이미지 레이어의 숨김
			});
		});
	</script>
</body>

</html>