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
			<form role="form" id="findpwForm" action="${pageContext.request.contextPath}/member/find_pw">
				<fieldset>
					<legend class="sr-only">비밀번호 찾기</legend>

					<div class="form-group">
						<label for="tel">휴대폰번호</label> 
						<div class="input-group">
						  <input type="tel" id="tel" name="tel" class="form-control" placeholder="휴대폰번호를 숫자만 입력하세요." />
						  <div class="input-group-btn">
							  <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">인증요청</button>
						  </div>
						</div>
					</div>

					<div class="form-group">
						<label for="email">아이디(이메일)</label> 
						<input type="email"	id="email" name="email" class="form-control" placeholder="이메일 주소를 입력하세요." /> 
						<span class="help-block alert alert-warning" role="alert" id="newPassword">* 새로운 비밀번호를 발급 후 반드시 로그인 후 비밀번호를 변경해 주세요.</span>
					</div>
					
					<button type="submit" class="btn btn-primary btn-block btn-lg">새 비밀번호 받기</button>

					<div class="find_id_pw text-center">
						<a href="${pageContext.request.contextPath}">홈으로</a>
						<span>|</span>
						<a href="${pageContext.request.contextPath}/member/login.cider">로그인</a>
					</div>
				</fieldset>
			</form>
			<!-- // login form -->
		</div>
	</section>
	<!-- // content 끝 -->
	
	<!-- Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">휴대폰 인증</h4>
				</div>
				<div class="modal-body">
					<p>인증이 완료되었습니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

	<!-- Javascript -->
	<script	src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script	src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>
	<script type="text/javascript">
          $(function() {

              $("#findpwForm").submit(function(e) {
                e.preventDefault();
                /** 연락처 검사 */
                if (!regex.value('#tel', '연락처를 입력하세요.')) { return false; }
                if (!regex.phone('#tel', '연락처가 잘못되었습니다.')) { return false; }

                /** 아이디 검사 */
                if (!regex.value('#email', '아이디(이메일)을 입력하세요.')) { return false; }
                if (!regex.email('#email', '이메일 주소가 잘못되었습니다.')) { return false; }
                
                    
                const form = $(this);
                const url = form.attr('action');
                $.ajax({
                    type: "POST",
                    url: url,
                    data: form.serialize(),
                    success: function(json) {
  	    				console.log(json);
  	    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
  	    				if (json.rt == "OK") {
 	 	    				alert("새로운 비밀번호를 발급받았습니다.");
 	 	    				var newPass = json.item.password;
 	 	    				$("#newPassword").empty();
 	 	    				$("#newPassword").append("신규 비밀번호는 " + newPass + " 입니다.");
  	    				}
  	    			}
                 });
                    
              });
          });
        </script>
</body>

</html>