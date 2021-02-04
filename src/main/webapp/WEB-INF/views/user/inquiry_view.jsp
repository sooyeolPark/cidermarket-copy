<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>문의내역 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                <h3 class="text-center">헬프센터</h3>

                <!-- 탭의 전체 박스 -->
                <div class="tab clearfix">
                    
                    <!-- 탭 버튼 영역 -->
                    <ul class="row tab-button clearfix">
                        <li role="presentation" class="tab-button-item text-center">
                            <a href="${pageContext.request.contextPath}/user/help.cider?selected=faq" class="tab-button-item-link3 pull-left" id="faq">자주묻는질문</a>
                        </li>
                        <li role="presentation" class="tab-button-item text-center">
                            <a href="${pageContext.request.contextPath}/user/help.cider?selected=policy" class="tab-button-item-link3 pull-left" id="policy">운영정책</a>
                        </li>
                        <li role="presentation" class="tab-button-item text-center">
                            <a href="#tab-page-inquiry" class="tab-button-item-link3 pull-left selected">일반문의</a>
                        </li>
                    </ul>

                    <!-- 내용영역 -->
                    <!-- sorting -->
                    <div class="recordSort text-center recordSort2">
                      <button type="button" class="ing btn btn-lg btn-info" onclick="location.href='${pageContext.request.contextPath}/user/help.cider?selected=inquiry'">문의하기</button>
                      <button type="button" class="ing btn btn-lg btn-primary">문의내역</button>
                    </div>

                    <!-- view -->
                    <div class="panel panel-default user-write">
                      <!-- Default panel contents -->
                      <div class="panel-heading" id="user-write">상품 판매 일시 중지 부탁합니다.</div>
                      <div class="panel-body">
                        <p>상품 판매 일시 중지 부탁합니다. 상품 판매 일시 중지 부탁합니다. 상품 판매 일시 중지 부탁합니다. 상품 판매 일시 중지 부탁합니다.</p>
                      </div>
                    </div>
                    <!-- reply -->
                    <div class="panel panel-danger">
                      <div class="panel-heading" id="admin-write"><i class="glyphicon glyphicon-comment"></i> 사이다마켓이 답변 드립니다.</div>
                      <div class="panel-body">
                        <p>고객님께서 말씀하신 상품 판매 일시 중지 금일부로 적용해 드렸습니다.<br>
                        다른 문의사항 있으시면 문의하기로 남겨주시거나 고객센터로 연락 바랍니다.<br>
                        그럼 오늘도 쿨거래 즐기시는 차도남 되시기 바랍니다.^^</p>
                      </div>
                    </div>
                    <div class="text-center">
                      <button type="button" class="btn btn-lg btn-primary" onclick="location.href='${pageContext.request.contextPath}/user/inquiry_cider.cider'">목록</button>
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
        <script type="text/javascript">
            $(function() {
                /** sorting */
                $(".recordSort > .btn").click(function(e) {
                    e.preventDefault();
                    if ($(this).hasClass("btn-info")) {
                        $(this).addClass("btn-primary").removeClass("btn-info");
                        $(".recordSort > .btn").not(this).removeClass("btn-primary").addClass("btn-info");
                    }
                });
            });
        </script>
</body>

</html>