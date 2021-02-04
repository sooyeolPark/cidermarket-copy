<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<nav class="list-group">
<a href="${pageContext.request.contextPath}/admin/board_adm.cider" class="list-group-item"><p>공지사항</p></a>
<a href="${pageContext.request.contextPath}/admin/event_adm.cider" class="list-group-item"><p>이벤트 게시판</p></a>
<a href="${pageContext.request.contextPath}/admin/question_adm.cider" class="list-group-item"><p>일반문의<span class="badge"> 10</span></p>
<a href="${pageContext.request.contextPath}/admin/faq_adm.cider" class="list-group-item"><p>자주묻는질문</p></a>
<a href="${pageContext.request.contextPath}/admin/policy_adm.cider" class="list-group-item"><p>운영정책</p></a>
</nav>