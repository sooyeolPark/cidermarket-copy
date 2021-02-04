<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>공지사항 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                <h3 class="text-center">공지사항</h3>

                <!-- 탭의 전체 박스 -->
                <div class="clearfix">
                    <!-- view -->
                    <div class="panel panel-default user-write">
                        <!-- Default panel contents -->
                        <div class="panel-heading boardTitle-view" id="user-write">
                            사이다마켓의 공지사항을 안내해 드립니다.
                            <span class="boardDate boardDate-view">2021-01-01</span>
                        </div>
                        <div class="panel-body">
                            <div class="boardImg-view"><img src="${pageContext.request.contextPath}/assets/img/banner_03.jpg" alt="사이다마켓의 공지사항을 안내해 드립니다."></div>
                            <p><b>쿨~하게 거래하자! 사이다마켓</b><br><br>
                                <b>[이용방법]</b><br><br>
                                판매자가 제목, 사진, 설명, 가격 등 상품정보를 올려두면 구매자가 그것을 보고 문자로 연락한다.<br>
                                구매자가 구매의사를 밝히면, 판매자가 택배 or 직거래 여부를 물어본다.<br>
                                간단한 질문 및 상품에 대한 설명 후 택배거래시 발송날짜, 
                                택배비를 협의하고 계좌번호를 알려주면,<br>
                                구매자가 현금을 선입금하고 판매자는 택배 발송 후 <br>
                                운송장 번호를 구매자에게 알려주면 거래가 마무리된다. <br>
                                운송장이나 영수증 사진을 찍어서 보내주기도 한다. <br>
                                주로 편의점택배, 대한통운, 우체국 택배를 많이 이용한다.<br><br>
                                
                                직거래 시 거래 약속 날짜, 장소, 시간을 협의하고<br>
                                (보통 중간 지점, 점심/퇴근이후 시간대에 지하철역에서 많이 만난다)<br>
                                현장에 도착하면 전화나 문자로 지금 위치를 물어보고 만난다. <br>
                                그런다음 구매자가 물건을 확인하고 현금을 건네거나 <br>
                                계좌이체, 토스 등으로 입금해주고 액수 확인하고 인사하고 끝. <br>
                                물건은 보통 종이봉투나 쇼핑백 등에 담아서 건네주는 편이다.<br>
                            </p>
                        </div>
                    </div>
                    <!-- button -->
                    <div class="text-center">
                        <button
                            type="button"
                            class="btn btn-lg btn-primary"
                            onclick="location.href='${pageContext.request.contextPath}/user/notice_list.cider'">목록</button>
                    </div>
                </div>

            </div>
        </section>

        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

        <!-- Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
</body>

</html>