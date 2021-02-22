<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>내상점-거래후기 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_common.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_review.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

  <section>
    <div class="container">
      <!-- 유저 프로필 고정부분 -->
      <ul class="media-list" id="user_profile">
        <li class="media clearfix">
          <a class="pull-left" href="#"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img/user_jordan.jpg" width="110"
            height="110" alt="Generic placeholder image" />
            <img class="img-circle" src="${pageContext.request.contextPath}/assets/img/grade_3.png" width="40"
            height="40" id="user_grade" />
        </a>
          <div class="media-body">
            <div id="user_id">마이클조던</div>
            <div id="user_date">2020년 10월 가입</div>
            <div id="user_intro">
              신발 파는 신발 매니아입니다.<br />
              주로 거래하는 브랜드는 나이키입니다.
            </div>
          </div>
        </li>
      </ul>
      <!-- 탭 메뉴 시작 -->
      <ul class="my_ctg">
        <li><a href="${pageContext.request.contextPath}/user/mystore.cider">내상점</a></li>
        <li class="active"><a href="${pageContext.request.contextPath}/mystore_review.cider">거래후기</a></li>
        <li><a href="${pageContext.request.contextPath}/mystore_mygrade.cider">나의 등급</a></li>
        <li><a href="${pageContext.request.contextPath}/mystore_myinfo.cider">내정보 설정</a></li>
      </ul>
    </div>
    <div class="div_blank"></div>
    <!--// 탭 메뉴 끝 -->
    
    
    
    <!-- 탭 화면 시작 -->
      <div id="myreview">
        <div id="myreview_subject">
          <h1>5</h1>
          <div id="user_star">
            <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
            <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
            <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
            <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
            <img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
            <span class="badge">${pageData.totalCount}</span>
          </div>
        </div>
        <div class="container">
          <div class="review2u">
            <ul class="review_list">
             <c:choose>
            	<%-- 조회결과가 없는 경우 --%>
           		<c:when test="${output == null || fn:length(output) == 0}">
                	<p class="alert alert-success" role="alert">조회결과가 없습니다.</p>
                </c:when>
                <%-- 조회결과가 있는 경우 --%>
                <c:otherwise>
                	<%-- 조회 결과에 따른 반복 처리 --%>
                    <c:forEach var="item" items="${output}" varStatus="status">
				<li class="media">
				  <a class="pull-left" href="#"> 
				  	<c:choose>
                    	<c:when test="${item.filepath == null && fn:length(item.filepath) == 0}">
                    		<img alt="${item.subject}" class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img/default_profile.jpg" width="50" height="50">
                    	</c:when>
                   		<c:otherwise>
                   			<img alt="${item.subject}" class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img${item.filepath}" width="50" height="50">
                   		</c:otherwise>
                   	</c:choose>
				  </a>
				  <div class="media-body">
				    <div class="clearfix">
				      <div class="pull-right">
				      
				      <c:choose>
				      	<c:when test="${item.how == 'T'}">
				        <div class="how_trade">택배</div>
				        </c:when>
				      	<c:when test="${item.how == 'J'}">
				        <div class="how_trade">직거래</div>
				        </c:when>				        	        
				        </c:choose>
				      </div>
				      <h4 class="media-heading review_user_name">${item.name} <small>${item.regdate}</small></h4>
				      <p class="review_item_subject">${item.subject}</p>
				    </div>
				    <div class="clearfix review_user_rpl">
				      <p>${item.content}
				      </p>
				
				    </div>
				    <div class="review_img">
			     			  <c:choose>
			            	<%-- 조회결과가 없는 경우 --%>
			           		<c:when test="${item.reviewpic == null || fn:length(item.reviewpic) == 0}">
			                	<h1></h1>
			                </c:when>
			                <%-- 조회결과가 있는 경우 --%>
			                <c:otherwise>				    
								      <a href="#">
								      <img id="reviewpic"src="${pageContext.request.contextPath}/assets/img/${item.reviewpic}">
								    </a>
						    </c:otherwise>
						    </c:choose>
				    </div>
					
				  </div>
				</li>
				</c:forEach>
				</c:otherwise>
				</c:choose>
            </ul>
          </div>
        </div>
<div class="clearfix text-center pagination">
        <ul>
        	<%-- 이전 그룹에 대한 링크 --%>
        	<c:choose>
            	<%-- 이전 그룹으로 이동 가능하다면? --%>
                <c:when test="${pageData.prevPage > 0}">
                	<%-- 이동할 URL 생성 --%>
                    <c:url value="/user/mystore_review.cider" var="prevPageUrl">
                    	<c:param name="page" value="${pageData.prevPage}" />          
                    </c:url>
                    <li class="arr"><a href="${prevPageUrl}">&laquo;</a></li>
                </c:when>
                <c:otherwise>
                	<li class="disabled"><a href="#">&laquo;</a></li>
                </c:otherwise>
            </c:choose>
            
            <%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
               <c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">
                  <%-- 이동할 URL 생성 --%>
                  <c:url value="/user/mystore_review.cider" var="pageUrl">
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
          
          	<%-- 이전 그룹에 대한 링크 --%>
        	<c:choose>
            	<%-- 다음 그룹으로 이동 가능하다면? --%>
                <c:when test="${pageData.nextPage > 0}">
                	<%-- 이동할 URL 생성 --%>
                    <c:url value="/user/mystore_review.cider" var="nextPageUrl">
                    	<c:param name="page" value="${pageData.nextPage}" />          
                    </c:url>
                    <li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
                </c:when>
                <c:otherwise>
                	<li class="disabled"><a href="#">&raquo;</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
      </div>
    
  </section>
  
 	 <!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>
  

  <!-- Javascript -->
  <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
  <!-- ajax-helper -->
  <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
  <!-- handlebar plugin -->
  <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
  <script type="text/javascript">
    

  </script>
</body>

</html>