<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>비밀번호찾기 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<!-- content 시작 -->
	<section>
		<!-- Item 영역 -->
		<div class="container">
			<h3 class="text-center">비밀번호 찾기</h3>
			<!-- login form -->
			<form role="form" id="findpw-form">
				<fieldset>
					<legend class="sr-only">비밀번호 찾기</legend>

					<div class="form-group">
						<label for="tel">휴대폰번호</label> 
						<input type="tel" id="tel" name="tel" class="form-control" placeholder="휴대폰번호를 숫자만 입력하세요." />
					</div>

					<div class="form-group">
						<label for="user_id">아이디(이메일)</label> 
						<input type="email"	id="user_id" name="user_id" class="form-control" placeholder="이메일 주소를 입력하세요." /> 
						<span class="help-block">* 등록하신 아이디(이메일)로 새로운 비밀번호를 보내드립니다.</span>
						<span class="help-block">* 반드시 로그인 후 비밀번호를 변경해 주세요.</span>
					</div>

					<button type="submit" class="btn btn-primary btn-block btn-lg">새 비밀번호 받기</button>

					<div class="find_id_pw text-center">
						<a href="${pageContext.request.contextPath}">홈으로</a>
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
	<script	src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script	src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>
	<script type="text/javascript">
          $(function() {

              $("#findpw-form").submit(function(e) {
                e.preventDefault();
                /** 연락처 검사 */
                if (!regex.value('#tel', '연락처를 입력하세요.')) { return false; }
                if (!regex.phone('#tel', '연락처가 잘못되었습니다.')) { return false; }

                /** 아이디 검사 */
                if (!regex.value('#user_id', '아이디(이메일)을 입력하세요.')) { return false; }
                if (!regex.email('#user_id', '이메일 주소가 잘못되었습니다.')) { return false; }
                
                // 처리 완료
                alert("입력형식 검사 완료!!!");
              });
          });
        </script>
</body>

</html>