<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 파라미터 수신에 사용할 문자셋 설정
	request.setCharacterEncoding("UTF-8");
	
	// 세션 유효시간 설정 (분단위, 기본값 5분)
	session.setMaxInactiveInterval(60);
	
	// 사용자 입력값 받기
	String input = request.getParameter("keyword");
	
	if (input != null && !input.equals("")) {
		// 세션 저장
		session.setAttribute("mysession", input);
	} else {
		// 개별 세션 삭제
		session.removeAttribute("mysession");
	}
	
	// 페이지 강제 이동
	response.sendRedirect("");
%>