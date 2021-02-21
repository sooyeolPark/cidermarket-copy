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

                    <!-- 목록 -->
                    <div class="list-group inquiry-list">
	                    <c:choose>
							<%-- 조회결과가 없는 경우 --%>
							<c:when test="${output == null || fn:length(output) == 0}">
								<p>조회 결과가 없습니다.</p>
							</c:when>
							<%-- 조회결과가 있는 경우 --%>
							<c:otherwise>
								<%-- 조회 결과에 따른 반복 처리 --%>
								<c:forEach var="item" items="${output}" varStatus="status">
									
									<%-- 상세페이지로 이동하기 위한 URL --%>
									<c:url var="viewUrl" value="/help/inquiry_view.cider">
										<c:param name="bbsno" value="${item.bbsno}" />							
									</c:url>
									
									<%-- 글 번호 --%>
                              		<c:set var="num" value="${pageData.totalCount-pageData.listCount*(pageData.nowPage-1)-status.count+1}" />
                              			
	                      			<a href="${viewUrl}" class="list-group-item">
	                      				<span class="badge inquiryNum">${num}</span> ${item.title}
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
									<c:url value="/help/inquiry_list.cider" var="prevPageUrl">
										<c:param name="page" value="${pageData.prevPage}" />
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
								<c:url value="/help/inquiry_list.cider" var="pageUrl">
									<c:param name="page" value="${i}" />
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
									<c:url value="/help/inquiry_list.cider" var="nextPageUrl">
										<c:param name="page" value="${pageData.nextPage}" />
									</c:url>
		                        	<li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
		                       	</c:when>
								<c:otherwise>
		                        	<li class="arr disabled"><a href="#">&raquo;</a></li>
								</c:otherwise>
							</c:choose>
		                    </ul>
		                </div> <!-- 페이지 번호 구현 끝 -->

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