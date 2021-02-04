<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<header>
	<div class="container">
		<div class="logo ">

			<a class="logo_img_a" href="item_index.html">
				<img src="img/logo.png" />
			</a>
			<button id="log-out" class="btn btn-default log_out" type="submit">로그아웃</button>
			<a class="nav_top_a btn-primary" href="index.html">
				User_Page <span class="logo_right glyphicon glyphicon-user"></span>
			</a>

		</div>
	</div>
	<div class="navbar navbar-default" role="navigation">
		<div class="container">

			<div class="collapse navbar-collapse">
				<ul id="nav_bar_menu" class="nav navbar-nav">

					<li class="nav_menu"><a href="home_adm.html">Home</a></li>
					<li class="nav_menu"><a class="nav_menu_a" href="order_adm.html">주문관리</a></li>
					<li class="nav_menu"><a class="nav_menu_a" href="board_adm.html">게시판관리</a>
						<ul class="sub-menu">
							<li><a href="board_adm.html">공지사항</a></li>
							<li><a href="event_adm.html">이벤트게시판</a></li>
							<li><a href="question_adm.html">일반문의</a></li>
							<li><a href="faq_adm.html">자주묻는질문</a></li>
							<li><a href="policy_adm.html">운영정책</a></li>
						</ul></li>
					<li class="nav_menu"><a class="nav_menu_a" href="member_adm.html">회원관리</a>
						<ul class="sub-menu">
							<li><a href="member_adm.html">회원정보조회</a></li>
							<li><a href="outmember_adm.html">탈퇴회원관리</a></li>
						</ul></li>
					<li class="nav_menu"><a class="nav_menu_a" href="product_adm.html">상품관리</a>
						<ul class="sub-menu">
							<li><a href="product_adm.html">상품목록</a></li>
							<li><a href="category_adm.html">상품분류</a></li>
							<li><a href="display_adm.html">상품진열</a></li>
							<li><a href="singo_adm.html">신고상품</a></li>
						</ul></li>
				</ul>
			</div>
			<!-- /.nav-collapse -->
		</div>
		<!-- /.container -->
	</div>
	<!-- /.navbar -->
</header>