<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>거래후기 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                <h3 class="text-center">거래후기</h3>

                <!-- 탭의 전체 박스 -->
                <div class="clearfix">
                    <!-- view -->
                    <div class="panel panel-default user-write">
                        <!-- Default panel contents -->
                        <div class="panel-heading boardTitle-view" id="user-write">
                            <span class="boardImg"><img src="${pageContext.request.contextPath}/upload${output.filepath}" alt="${output.subject}"></span>
                            <span class="boardTitle">${output.subject}</span>
                            <span class="boardDate"><fmt:formatNumber value="${output.price}" pattern="#,###" />원</span>
                        </div>
                        <div class="panel-body">
                          <div class="foryou">To. <b>${output.nickname}</b>님께 
                          <c:if test="${output.rate == 5}">쌍따봉과 함께 칭찬을</c:if>
                          <c:if test="${output.rate == 4}">따뜻한 후기를</c:if>
                          <c:if test="${output.rate == 3}">솔직한 후기를</c:if>
                          <c:if test="${output.rate == 2}">아쉬운 마음을</c:if>
                          <c:if test="${output.rate == 1}">상처입은 마음을</c:if> 
                          보냈어요.</div>
                            <p>${output.content}<br></p>
                            <div id="review_img" class="review_img">
                             <c:forEach var="item" items="${fileimages}" varStatus="status">
                                <img class="userreview_img" src="${pageContext.request.contextPath}/upload${item.filepath}" alt="리뷰이미지">
                            </c:forEach>
                            </div>
                        </div>
                    </div>
                    <!-- button -->
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/member/record/selling.cider" class="btn btn-lg btn-danger">돌아가기</a>
                    </div>
                </div>

            </div>
        </section>

        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

        <!-- Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
        <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>
</body>

</html>