<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<ul class="media-list" id="user_profile">
  <li class="media clearfix">
    <a class="pull-left" href="#">
      <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img${output.filepath}" width="110" height="110" alt="Generic placeholder image" />
      <img class="img-circle" src="${pageContext.request.contextPath}/assets/img/grade_3.png" width="40" height="40" id="user_grade" />
    </a>
    <div class="media-body">
      <div id="user_id">${output.nickname}</div>
      <div id="user_date">
          <fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss" value="${output.joindate }"/>
          <fmt:formatDate var="dateTempParse" pattern="yyyy년 MM월 dd일" value="${dateFmt }" />
          <c:out value="${dateTempParse }" /> 가입
      </div>
      <div id="user_intro">${output.intro}</div>
    </div>
  </li>
</ul>