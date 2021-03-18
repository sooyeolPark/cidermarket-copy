<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
                            <a href="${pageContext.request.contextPath}/help/help.cider?selected=faq" class="tab-button-item-link3 pull-left" id="faq">자주묻는질문</a>
                        </li>
                        <li role="presentation" class="tab-button-item text-center">
                            <a href="${pageContext.request.contextPath}/help/help.cider?selected=policy" class="tab-button-item-link3 pull-left" id="policy">운영정책</a>
                        </li>
                        <li role="presentation" class="tab-button-item text-center">
                            <a href="#tab-page-inquiry" class="tab-button-item-link3 pull-left selected">일반문의</a>
                        </li>
                    </ul>

                    <!-- 내용영역 -->
                    <!-- sorting -->
                    <div class="recordSort text-center recordSort2">
                      <button type="button" class="ing btn btn-lg btn-info" onclick="location.href='${pageContext.request.contextPath}/help/inquiry_write.cider'">문의하기</button>
                      <button type="button" class="ing btn btn-lg btn-primary" onclick="location.href='${pageContext.request.contextPath}/help/inquiry_list.cider'">문의내역</button>
                    </div>

                    <!-- view -->
                    <div class="panel panel-default user-write">
                      <!-- Default panel contents -->
                      <div class="panel-heading" id="user-write">${output.title}</div>
                      <div class="panel-body">
                      	<c:choose>
                    		<%-- 조회결과가 없는 경우 --%>
							<c:when test="${files == null || fn:length(files) == 0}">
								<div class="text-center alert alert-info" role="alert">등록된 이미지가 없습니다.</div>
							</c:when>	
							<c:otherwise>
								<%-- 조회 결과에 따른 반복 처리 --%>
								<c:forEach var="item" items="${files}" varStatus="status">
		                    		<div class="text-center first_img"><img src="${pageContext.request.contextPath}/upload${item.filepath}" alt="${output.title}" /></div>
		                    	</c:forEach>
							</c:otherwise>
                    	</c:choose>
                        <p>${output.content}</p>
                      </div>
                    </div>
                    <!-- reply -->
                    <div class="panel panel-danger">
                      <div class="panel-heading" id="admin-write"><i class="glyphicon glyphicon-comment"></i> 사이다마켓이 답변 드립니다.</div>
                      <div class="panel-body">
                        <p>${output.reply}</p>
                      </div>
                    </div>
                    <div class="text-center">
                      <button type="button" class="btn btn-lg btn-primary" onclick="location.href='${pageContext.request.contextPath}/help/inquiry_list.cider'">목록</button>
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
</body>

</html>