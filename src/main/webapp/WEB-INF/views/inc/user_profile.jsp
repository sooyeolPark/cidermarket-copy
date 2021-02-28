<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<ul class="media-list" id="user_profile">
  <li class="media clearfix">
    <a class="pull-left" href="#">
	  <c:choose>
	    	<c:when test="${user.filepath == null && fn:length(user.filepath) == 0}">
	      		<img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img/default_profile.jpg" width="110" height="110" alt="${user.nickname}" />
	    	</c:when>
	   		<c:otherwise>
	      		<img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img${user.filepath}" width="110" height="110" alt="${user.nickname}" />
	   		</c:otherwise>
	  </c:choose>
    </a>
    <div class="media-body">
      <div id="user_id">${user.nickname}</div>
      <div id="user_date">
          <fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss" value="${user.joindate }"/>
          <fmt:formatDate var="dateTempParse" pattern="yyyy년 MM월 dd일" value="${dateFmt }" />
          <c:out value="${dateTempParse }" /> 가입
      </div>
      <div id="user_intro">${user.intro}</div>
    </div>
  </li>
</ul>
<!-- 탭 메뉴 시작 -->
<ul class="my_ctg">
  <li><a href="${pageContext.request.contextPath}/mystore/${user.shopaddress}">내상점</a></li>
  <li data-url="review"><a href="${pageContext.request.contextPath}/mystore/${user.shopaddress}/review.cider">거래후기</a></li>
  <li data-url="mygrade"><a href="${pageContext.request.contextPath}/mystore/${user.shopaddress}/mygrade.cider">나의 등급</a></li>
  <c:if test="${myNum == user.membno}">
   <li data-url="myinfo"><a href="${pageContext.request.contextPath}/mystore/${user.shopaddress}/myinfo.cider">내정보 설정</a></li>
  </c:if>
</ul>