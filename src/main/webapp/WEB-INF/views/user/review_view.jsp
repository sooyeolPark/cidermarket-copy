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
                          <a href="${pageContext.request.contextPath}/user/item_index.cider" class="clearfix">
                            <span class="boardImg"><img src="${pageContext.request.contextPath}/assets/img/item_07.jpg" alt="에어팟프로 선물용 미개봉"></span>
                            <span class="boardTitle">${output.subject}</span>
                            <span class="boardDate">${output.price}원</span>
                          </a>                            
                        </div>
                        <div class="panel-body">
                          <div class="foryou">To. <b>${output.nickname}</b>님께 따뜻한 후기를 보냈어요.</div>
                            <p>${output.content}<br></p>
                            <div class="review_img">
                                <img src="${pageContext.request.contextPath}/assets/img/review_img1.jpg" alt="리뷰이미지">
                                <img src="${pageContext.request.contextPath}/assets/img/review_img2.png" alt="리뷰이미지">
                                <img src="${pageContext.request.contextPath}/assets/img/review_img3.jpg" alt="리뷰이미지">
                                <img src="${pageContext.request.contextPath}/assets/img/review_img4.jpg" alt="리뷰이미지">
                            </div>
                        </div>
                    </div>
                    <!-- button -->
                    <div class="text-center">
                        <button type="button" class="btn btn-lg btn-danger" onclick="javascript:history.back()">돌아가기</button>
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