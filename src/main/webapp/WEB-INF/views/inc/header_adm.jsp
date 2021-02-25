<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 로그인 되어 있지 않으면 메인페이지로 강제 이동
	if (session.getAttribute("myAdmNum") == null || session.getAttribute("myAdmNum").equals("")) {
		out.println("<script>alert('로그인 후 이용 가능합니다.');</script>");
		response.sendRedirect("/cidermarket/admin/login_adm.cider");
	}
%>
<header>
	<div class="container">
		<div class="logo ">

			<a class="logo_img_a" href="${pageContext.request.contextPath}/admin/home_adm.cider">
				<img src="${pageContext.request.contextPath}/assets/img/logo.png" />
			</a>
			<button id="log-out" class="btn btn-default log_out" type="submit">로그아웃</button>
			<a class="nav_top_a btn btn-danger" href="${pageContext.request.contextPath}" target="_blank">
				User_Page <span class="logo_right glyphicon glyphicon-user"></span>
			</a>

		</div>
	</div>
	<div class="navbar navbar-default" role="navigation">
		<div class="container">

			<div class="collapse navbar-collapse">
				<ul id="nav_bar_menu" class="nav navbar-nav">

					<li class="nav_menu"><a href="${pageContext.request.contextPath}/admin/home_adm.cider">Home</a></li>
					<li class="nav_menu"><a class="nav_menu_a" href="${pageContext.request.contextPath}/admin/order_adm.cider">주문관리</a></li>
					<li class="nav_menu"><a class="nav_menu_a" href="${pageContext.request.contextPath}/admin/notice/list.cider">게시판관리</a>
						<ul class="sub-menu">
							<li><a href="${pageContext.request.contextPath}/admin/notice/list.cider">공지사항</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/question_adm.cider">일반문의</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/event_adm.cider">이벤트</a></li>
						</ul></li>
					<li class="nav_menu"><a class="nav_menu_a" href="${pageContext.request.contextPath}/admin/member_adm.cider">회원관리</a>
						<ul class="sub-menu">
							<li><a href="${pageContext.request.contextPath}/admin/member_adm.cider">회원정보조회</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/outmember_adm.cider">탈퇴회원관리</a></li>
						</ul></li>
					<li class="nav_menu"><a class="nav_menu_a" href="${pageContext.request.contextPath}/admin/product_adm.cider">상품관리</a>
						<ul class="sub-menu">
							<li><a href="${pageContext.request.contextPath}/admin/product_adm.cider">상품목록</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/category_adm.cider">상품분류</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/display_adm.cider">상품진열</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/singo_adm.cider">신고상품</a></li>
						</ul></li>
				</ul>
			</div>
			<!-- /.nav-collapse -->
		</div>
		<!-- /.container -->
	</div>
	<!-- /.navbar -->
</header>
<script>
/** Ajax 호출 */
$("#log-out").click(function(){
	var result = confirm("로그아웃 하시겠습니까?");
    $.ajax({
        type: "GET",
        url: "${pageContext.request.contextPath}/admin/logout.cider",
        success: function(json) {
				console.log(json);
				alert("로그아웃 되셨습니다.");
				if (json.rt == "OK") {
					window.location = "${pageContext.request.contextPath}/admin/login_adm.cider";
				}
			}
      });    	
});
</script>