<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>회원가입 - 사이다마켓</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/css/user/style.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<!-- content 시작 -->
	<section>
		<!-- Item 영역 -->
		<div class="container">
			<h3 class="text-center">회원가입</h3>
			<!-- login form -->
			<form role="form" id="join-form">
				<fieldset>
					<legend class="sr-only">회원가입</legend>

					<div class="form-group clearfix">
						<label for="user_id" class="col-sm-2">아이디(이메일) <span
							class="star">*</span></label>
						<div class="col-sm-10">
							<input type="email" id="user_id" name="user_id"
								class="form-control" placeholder="이메일을 입력하세요." />
							<p id="idc" class="pop"></p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label for="user_pw" class="col-sm-2">비밀번호 <span
							class="star">*</span></label>
						<div class="password_icon col-sm-10">
							<input type="password" id="user_pw" name="user_pw"
								class="form-control" placeholder="비밀번호를 입력하세요." /> <i
								class="eyeicon glyphicon glyphicon-eye-close"></i> <span
								class="in-eng">✔ 영어포함</span> <span class="in-num">✔ 숫자포함</span>
							<span class="in-spc">✔ 특수문자포함</span>
							<p id="pwc" class="pop"></p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label for='user_pw_re' class="col-sm-2">비밀번호 확인 <span
							class="star">*</span></label>
						<div class="password_icon col-sm-10">
							<input type="password" id="user_pw_re" name="user_pw_re"
								class="form-control" placeholder="비밀번호를 입력하세요." /> <i
								class="eyeicon glyphicon glyphicon-eye-close"></i>
						</div>
					</div>

					<div class="form-group clearfix">
						<label for="tel" class="col-sm-2">휴대폰번호 <span class="star">*</span></label>
						<div class="input-group col-sm-10">
							<input type="tel" id="tel" name="tel" class="form-control"
								placeholder="연락처를 입력하세요" /> <span class="input-group-btn"><button
									type="button" class="btn btn-default" data-toggle="modal"
									data-target="#myModal">인증요청</button></span>
						</div>
						<span class="help-block col-sm-offset-2 phone-help-block">숫자만
							입력하세요.</span>
					</div>

					<div class="join_info">
						<p>
							가입시 <a href="${pageContext.request.contextPath}/user/terms.cider">이용약관</a>
							및 <a
								href="${pageContext.request.contextPath}/user/protection.cider">개인정보
								취급방침</a>, <a
								href="${pageContext.request.contextPath}/user/location.cider">위치정보제공</a>에
							동의합니다.
						</p>
					</div>
					<button type="submit" class="btn btn-primary btn-block btn-lg">회원가입</button>
					<div class="join_info text-center">
						<a href="${pageContext.request.contextPath}/user/login.cider">로그인</a>
					</div>
				</fieldset>
			</form>
			<!-- // login form -->

			<!-- Modal -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">휴대폰 인증</h4>
						</div>
						<div class="modal-body">
							<p>인증이 완료되었습니다.</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-success"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</section>
	<!-- // content 끝 -->

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

	<!-- Javascript -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>
	<script type="text/javascript">
          $(function() {

            $(".eyeicon").click(function() {
              if ($(this).hasClass("glyphicon-eye-close")) {
                $(this).removeClass("glyphicon-eye-close").addClass("glyphicon-eye-open");
                var type = $(this).prev("input[type='password']").attr("type", "text");
              } else {
                $(this).removeClass("glyphicon-eye-open").addClass("glyphicon-eye-close");
                var type = $(this).prev("input[type='text']").attr("type", "password");
              }
            });

            var check_num = /[0-9]/; // 숫자 
            var check_eng = /[a-zA-Z]/; // 문자 
            var check_spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
            var check_email = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

            $('#user_id').keyup(function(){
              var msg = '', val = this.value;
              if(!check_email.test(val)){
                msg = '이메일 형식으로 입력하세요.'
                $('#idc').html(msg).css('visibility', 'visible');
              } else {
                $('#idc').css('visibility', 'hidden');
              };
            });

            $('#user_pw').keyup(function(){
              var msg = '', val = this.value;
              msg = GetAjaxPW(val);
              if( val.length > 7 && val.length < 21 ){
                msg = GetAjaxPW(val);
                $('#pwc').css('visibility', 'hidden');
                }else{
                    msg = '8 ~ 20자 이내로 입력하세요.'
                    $('#pwc').html(msg).css('visibility', 'visible');
                };
            });
            var GetAjaxPW = function(val){
              if(check_eng.test(val)) { $('.in-eng').css('color', '#ff8e18') } else {$('.in-eng').css('color', '#aaa')}
              if(check_num.test(val)) { $('.in-num').css('color', '#ff8e18') } else {$('.in-num').css('color', '#aaa')}
              if(check_spc.test(val)) { $('.in-spc').css('color', '#ff8e18') } else {$('.in-spc').css('color', '#aaa')}
              return false;
            };

            $("#join-form").submit(function(e) {
              e.preventDefault();
              /** 이름 검사 */
              if (!regex.value('#user_id', '아이디(이메일)을 입력하세요.')) { return false; }
              if (!regex.email('#user_id', '이메일 주소가 잘못되었습니다.')) { return false; }

              /** 비밀번호 검사 */
              if (!regex.value('#user_pw', '비밀번호를 입력하세요.')) { return false; }
              if (!regex.eng_num_spc('#user_pw', '비밀번호를 형식에 맞게 입력하세요.')) { return false; }
              if (!regex.min_length('#user_pw', 8, '비밀번호는 최소 5자 이상 입력 가능합니다.')) { return false; }
              if (!regex.max_length('#user_pw', 20, '비밀번호는 최대 15자 까지만 입력 가능합니다.')) { return false; }
              if (!regex.compare_to('#user_pw', '#user_pw_re', '비밀번호 확인이 잘못되었습니다.')) { return false; }
              
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