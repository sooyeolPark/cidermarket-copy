<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 로그인 되어 있으면 메인페이지로 강제 이동
	if (session.getAttribute("myNum") != null && session.getAttribute("myNum") != "") {
		response.sendRedirect("/cidermarket");
	}
%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>회원가입 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css" />
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
			<form role="form" id="addForm" action="${pageContext.request.contextPath}/member.cider">
				<fieldset>
					<legend class="sr-only">회원가입</legend>

					<div class="form-group clearfix">
						<label for="email" class="col-sm-2"> 아이디(이메일)<span class="star">*</span>
						</label>
						<div class="col-sm-10">
							<input type="email" id="email" name="email" class="form-control" placeholder="이메일을 입력하세요." />
							<p id="idc" class="pop"></p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label for="password" class="col-sm-2">비밀번호 <span class="star">*</span></label>
						<div class="password_icon col-sm-10">
							<input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요." />
							<i class="eyeicon glyphicon glyphicon-eye-close"></i> <span class="in-eng">✔ 영어포함</span> <span class="in-num">✔ 숫자포함</span> <span class="in-spc">✔ 특수문자포함</span>
							<p id="pwc" class="pop"></p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label for='user_pw_re' class="col-sm-2">비밀번호 확인 <span class="star">*</span></label>
						<div class="password_icon col-sm-10">
							<input type="password" id="user_pw_re" name="user_pw_re" class="form-control" placeholder="비밀번호를 입력하세요." />
							<i class="eyeicon glyphicon glyphicon-eye-close"></i>
						</div>
					</div>

					<div class="form-group clearfix">
						<label for="tel" class="col-sm-2">휴대폰번호 <span class="star">*</span></label>
						<div class="input-group col-sm-10">
							<input type="tel" id="tel" name="tel" class="form-control" placeholder="연락처를 입력하세요" />
							<span class="input-group-btn"><button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">인증요청</button></span>
						</div>
						<span class="help-block col-sm-offset-2 phone-help-block">숫자만 입력하세요.</span>
					</div>

					<div class="join_info">
						<p>
							가입시
							<a href="${pageContext.request.contextPath}/help/terms.cider">이용약관</a>
							및
							<a href="${pageContext.request.contextPath}/help/protection.cider">개인정보 취급방침</a>
							,
							<a href="${pageContext.request.contextPath}/help/location.cider">위치정보제공</a>
							에 동의합니다.
						</p>
					</div>
					<button type="submit" class="btn btn-primary btn-block btn-lg">회원가입</button>
					<div class="join_info text-center">
						<a href="${pageContext.request.contextPath}/member/login.cider">로그인</a>
					</div>
				</fieldset>
			</form>
			<!-- // login form -->

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

		</div>
	</section>
	<!-- // content 끝 -->

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>
	<!-- jQeury Ajax Form plugin CDN -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
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

            $('#email').keyup(function(){
              var msg = '', val = this.value;
              if(!check_email.test(val)){
                msg = '이메일 형식으로 입력하세요.'
                $('#idc').html(msg).css('visibility', 'visible');
              } else {
                $('#idc').css('visibility', 'hidden');
              };
            });

            $('#password').keyup(function(){
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

            $("#addForm").submit(function(e) {
           	  e.preventDefault();
              /** 이름 검사 */
              if (!regex.value('#email', '아이디(이메일)을 입력하세요.')) { return false; }
              if (!regex.email('#email', '이메일 주소가 잘못되었습니다.')) { return false; }

              /** 비밀번호 검사 */
              if (!regex.value('#password', '비밀번호를 입력하세요.')) { return false; }
              if (!regex.eng_num_spc('#password', '비밀번호를 형식에 맞게 입력하세요.')) { return false; }
              if (!regex.min_length('#password', 8, '비밀번호는 최소 8자 이상 입력 가능합니다.')) { return false; }
              if (!regex.max_length('#password', 20, '비밀번호는 최대 15자 까지만 입력 가능합니다.')) { return false; }
              if (!regex.compare_to('#password', '#user_pw_re', '비밀번호 확인이 잘못되었습니다.')) { return false; }
              
              /** 연락처 검사 */
              if (!regex.value('#tel', '연락처를 입력하세요.')) { return false; }
              if (!regex.phone('#tel', '연락처가 잘못되었습니다.')) { return false; }
              
              /** Ajax 호출 */
              const form = $(this);
              const url = form.attr('action');
              
              $.ajax({
                  type: "POST",
                  url: url,
                  data: form.serialize(),
                  success: function(json) {
	    				console.log(json);
	    				alert("가입을 환영합니다. 로그인 후 이용해주세요.");
	    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
	    				if (json.rt == "OK") {
	    					window.location = "${pageContext.request.contextPath}/member/login.cider";
	    				}
	    			}
                });
            });
            			
            
          });
        </script>
</body>

</html>