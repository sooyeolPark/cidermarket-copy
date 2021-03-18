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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                <h3 class="text-center">공지사항</h3>
                
                <!-- 목록 -->
                <div class="list-group" id="notice-list">
                  <!-- Ajax로 로드한 결과가 표시될 곳 -->
                  <c:choose>
					<%-- 조회결과가 없는 경우 --%>
					<c:when test="${output == null || fn:length(output) == 0}">
						<p class="alert alert-success" role="alert">조회결과가 없습니다.</p>
					</c:when>
					<%-- 조회결과가 있는 경우 --%>
					<c:otherwise>
						<%-- 조회 결과에 따른 반복 처리 --%>
						<c:forEach var="item" items="${output}" varStatus="status">
							<%-- 출력을 위해 준비한 제목 변수 --%>
							<c:set var="title" value="${item.title}" />
							
							<%-- 검색어가 있다면? --%>
							<c:if test="${keyword != ''}">
								<%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
								<c:set var="mark" value="<mark>${keyword}</mark>" />
								<%-- 출력을 위해 준비한 제목에 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
								<c:set var="title" value="${fn:replace(title, keyword, mark)}" />
							</c:if>
							
							<%-- 상세페이지로 이동하기 위한 URL --%>
							<c:url var="viewUrl" value="/notice/view.cider">
								<c:param name="bbsno" value="${item.bbsno}" />							
							</c:url>
							
							<a href="${viewUrl}" class="list-group-item clearfix">
					        	<span class="boardImg"><img src="${pageContext.request.contextPath}/upload${item.filepath}" alt="${item.title}"></span>
					            <p class="boardTitle">${title}</p>
					            <span class="boardDate">${item.regdate}</span>
					        </a>
						</c:forEach>
					</c:otherwise>
				</c:choose>
                </div>
                
                <!-- 페이지 번호 구현 -->
                <div class="clearfix text-center pagination">
                    <ul>
                   	<%-- 이전 그룹에 대한 링크 --%>
                   	<c:choose>
						<%-- 이전 그룹으로 이동 가능하다면? --%>
						<c:when test="${pageData.prevPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/notice/list.cider" var="prevPageUrl">
								<c:param name="page" value="${pageData.prevPage}" />
								<c:param name="keyword" value="${keyword}" />				
							</c:url>
                        	<li class="arr"><a href="${prevPageUrl}">&laquo;</a></li>
                       	</c:when>
                       	<c:otherwise>
                        	<li class="arr disabled"><a href="#">&laquo;</a></li>
						</c:otherwise>
					</c:choose>
					
					<%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
					<c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">
						<%-- 이동할 URL 생성 --%>
						<c:url value="/notice/list.cider" var="pageUrl">
							<c:param name="page" value="${i}" />
							<c:param name="keyword" value="${keyword}" />				
						</c:url>
						
						<%-- 페이지 번호 출력 --%>
						<c:choose>
							<%-- 현재 머물고 있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
							<c:when test="${pageData.nowPage == i}">
		                        <li class="active"><span>${i} <span class="sr-only">(current)</span></span></li>
							</c:when>
							<c:otherwise>
		                        <li><a href="${pageUrl}">${i}</a></li>							
							</c:otherwise>
						</c:choose>
					</c:forEach>
                    
                    <%-- 다음 그룹에 대한 링크 --%>
					<c:choose>
						<%-- 다음 그룹으로 이동 가능하다면? --%>
						<c:when test="${pageData.nextPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/notice/list.cider" var="nextPageUrl">
								<c:param name="page" value="${pageData.nextPage}" />
								<c:param name="keyword" value="${keyword}" />				
							</c:url>
                        	<li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
                       	</c:when>
						<c:otherwise>
                        	<li class="arr disabled"><a href="#">&raquo;</a></li>
						</c:otherwise>
					</c:choose>
                    </ul>
                </div>

            </div>
            
            <!-- 검색폼 -->
			<form method="get" action="${pageContext.request.contextPath}/notice/list.cider" id="searchBox_help" class="container">
				<input type="search" name="keyword" id="keyword" class="form-control" placeholder="공지사항 키워드를 입력해 주세요" value="${keyword}" />
				<button class="btn btnSearch-help" type="submit"><i class="glyphicon glyphicon-search"></i></button>
			</form>
			
        </section>
        
        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

        <!-- Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
        
</body>

</html>