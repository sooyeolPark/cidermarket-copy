<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
	<title>아이디찾기 - 사이다마켓</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<!-- content 시작 -->
	<section>
		<!-- Item 영역 -->
		<div class="container">
			<h3 class="text-center">아이디 찾기</h3>
			<!-- login form -->
			<form role="form" id="findid-form">
				<fieldset>
					<legend class="sr-only">아이디 찾기</legend>

					<div class="form-group clearfix">
						<label for="tel" class="col-sm-2">휴대폰번호</label>
						<div class="col-sm-10">
							<input type="tel" id="tel" name="tel" class="form-control" placeholder="휴대폰번호를 숫자만 입력하세요." />
						</div>
					</div>

					<button type="submit" class="btn btn-primary btn-block">찾기</button>

					<div class="find_id_pw text-center">
						<a href="${pageContext.request.contextPath}">홈으로</a>
						<span>|</span>
						<a href="${pageContext.request.contextPath}/user/find_pw.cider">비밀번호찾기</a>
					</div>
				</fieldset>
			</form>
			<!-- // login form -->

		</div>
	</section>
	<!-- // content 끝 -->

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>
	<script type="text/javascript">
          $(function() {

              $("#login-form").submit(function(e) {
                e.preventDefault();
                /** 연락처 검사 */
                if (!regex.value('#tel', '연락처를 입력하세요.')) { return false; }
                if (!regex.phone('#tel', '연락처가 잘못되었습니다.')) { return false; }
                
                // 처리 완료
                alert("입력형식 검사 완료!!!");
              });
          });
        </script>
</body>

</html>