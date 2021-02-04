<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<header>
	<div class="container">
		<div class="logo ">

			<a class="logo_img_a" href="${pageContext.request.contextPath}/admin/home_adm.cider">
				<img src="${pageContext.request.contextPath}/assets/img/logo.png" />
			</a>
			<button id="log-out" class="btn btn-default log_out" type="submit">로그아웃</button>
			<a class="nav_top_a btn-primary" href="${pageContext.request.contextPath}">
				User_Page <span class="logo_right glyphicon glyphicon-user"></span>
			</a>

		</div>
	</div>
	<div class="navbar navbar-default" role="navigation">
		<div class="container">

			<div class="collapse navbar-collapse">
				<ul id="nav_bar_menu" class="nav navbar-nav">

					<li class="nav_menu"><a href="home_adm.html">Home</a></li>
					<li class="nav_menu"><a class="nav_menu_a" href="${pageContext.request.contextPath}/admin/order_adm.cider">주문관리</a></li>
					<li class="nav_menu"><a class="nav_menu_a" href="${pageContext.request.contextPath}/admin/board_adm.cider">게시판관리</a>
						<ul class="sub-menu">
							<li><a href="${pageContext.request.contextPath}/admin/board_adm.cider">공지사항</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/event_adm.cider">이벤트게시판</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/question_adm.cider">일반문의</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/faq_adm.cider">자주묻는질문</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/policy_adm.cider">운영정책</a></li>
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