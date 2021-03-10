<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>이벤트 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                <h3 class="text-center">이벤트</h3>

                <!-- 탭의 전체 박스 -->
                <div class="clearfix">
                    <!-- view -->
                    <div class="panel panel-default user-write">
                        <!-- Default panel contents -->
                        <div class="panel-heading boardTitle-view" id="user-write">
                            사이다마켓 그랜드오픈 기념이벤트 에어팟 맥스 100분께 쏩니다!
                            <span class="boardDate boardDate-view">2021-01-01</span>
                        </div>
                        <div class="panel-body">
                            <div class="boardImg-view"><img src="${pageContext.request.contextPath}/upload/banner_01.jpg" alt="사이다마켓 그랜드오픈 기념이벤트 에어팟 맥스 100분께 쏩니다!"></div>
                            <p>오픈을 기념해 100분께 애플 에어팟 맥스를 드립니다.<br><br>
                              응모기간 : 2021-01-01 ~ 2021-01-31<br>
                              응모대상 : 거래건수 상위 100분 추첨하여 증정<br>
                              경품수령 : 2021-02-20, 개별 문자 발송<br><br>
                              주의사항<br>
                              ※ 부정한 방법으로 이벤트 참여 시 당첨이 취소 될 수 있습니다.<br>
                              ※ 경품은 이벤트에 응모하신 로그인 ID 회원 정보 기준으로 지급되니 회원 정보를 한번 더 확인해 주시기 바랍니다.<br>
                              ※ 경품으로 증정되는 상품은 교환이 불가합니다.<br>
                              ※ 이벤트에 응모하실 경우 개인 정보 제공에 동의하신 것으로 간주되며, 제공된 정보는 경품 발송 완료 후 즉시 파기합니다.<br>
                              ※ 경품은 2020년 2월 7일 기준 회원 정보로 2020년 2월 20일에 일괄 문자 발송됩니다.<br>
                            </p>
                        </div>
                    </div>
                    <!-- button -->
                    <div class="text-center">
                        <button
                            type="button"
                            class="btn btn-lg btn-primary"
                            onclick="location.href='${pageContext.request.contextPath}/user/event_list.cider'">목록</button>
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