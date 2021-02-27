<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<nav class="list-group product-left-nav">
	<!-- 목록의 아이템 -->
	<p>상품관리</p>
	<a href="${pageContext.request.contextPath}/admin/product_adm.cider" class="list-group-item">
		<span>상품목록</span>
	</a>
	<a href="${pageContext.request.contextPath}/admin/category_adm.cider" class="list-group-item">
		<span>상품분류</span>
	</a>
	<a href="${pageContext.request.contextPath}/admin/display_adm.cider" class="list-group-item">
		<span>상품진열</span>
	</a>
	<a href="${pageContext.request.contextPath}/admin/singo_adm.cider" class="list-group-item">
		<span>신고상품</span>
	</a>
</nav>