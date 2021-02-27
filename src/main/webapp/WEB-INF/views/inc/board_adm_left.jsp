<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<nav class="list-group">
<p>게시판관리</p>
<a href="${pageContext.request.contextPath}/admin/notice/list.cider" class="list-group-item"><p>공지사항</p></a>
<a href="${pageContext.request.contextPath}/admin/question_adm.cider" class="list-group-item"><p>일반문의</p></a>
<a href="${pageContext.request.contextPath}/admin/event_adm.cider" class="list-group-item"><p>이벤트</p></a>
</nav>