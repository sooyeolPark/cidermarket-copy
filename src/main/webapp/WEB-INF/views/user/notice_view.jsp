<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
                            ${output.title}
                            <span class="boardDate boardDate-view">${output.regdate}</span>
                        </div>
                        <div class="panel-body">
	                        <c:choose>
		                   		<%-- 조회결과가 없는 경우 --%>
								<c:when test="${files == null || fn:length(files) == 0}">
									<div class="text-center alert alert-info" role="alert">등록된 이미지가 없습니다.</div>
								</c:when>	
								<c:otherwise>
									<c:forEach var="item" items="${files}" varStatus="status">
			                    	<div class="boardImg-view"><img src="${pageContext.request.contextPath}/assets/img${item.filepath}" alt="${output.title}" /></div>
			                    	</c:forEach>
								</c:otherwise>
		                   	</c:choose>
                            <p>${output.content}</p>
                        </div>
                    </div>
                    <!-- button -->
                    <div class="text-center">
                        <button type="button" class="btn btn-lg btn-primary" 
                        onclick="location.href='${pageContext.request.contextPath}/notice/list.cider'">목록</button>
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