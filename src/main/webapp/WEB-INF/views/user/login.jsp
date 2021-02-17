<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
// 세션 유효시간 설정 (분단위, 기본값 5분) -> 모든 페이지마다 개별 설정함.
//session.setMaxInactiveInterval(60);

// Session 객체 추출 --> Object 타입으로 형변환 되어 저장되므로, 추출시에는 원래의 형태로 명시적 변환이 필요하다.
//String myId = (String) session.getAttribute("myId");
%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>로그인 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<!-- content 시작 -->
	<section>
		<!-- Item 영역 -->
		<div class="container">
			<h3 class="text-center">로그인</h3>
			<!-- login form -->
			<form role="form" method="post" id="loginForm" action="${pageContext.request.contextPath}/login.cider">
				<fieldset>
					<legend class="sr-only">로그인</legend>

					<div class="form-group clearfix">
						<label for="email" class="col-sm-2">아이디</label>
						<div class="col-sm-10">
							<input type="email" id="email" name="email" class="form-control" placeholder="아이디를 입력하세요." />
							<p id="idc" class="pop"></p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label for="password" class="col-sm-2">비밀번호</label>
						<div class="password_icon col-sm-10">
							<input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요." />
							<i class="eyeicon glyphicon glyphicon-eye-close"></i> <span class="in-eng">✔ 영어포함</span> <span class="in-num">✔ 숫자포함</span> <span class="in-spc">✔ 특수문자포함</span>
							<p id="pwc" class="pop"></p>
						</div>
					</div>

					<div class="checkbox col-sm-offset-2">
						<label><input type="checkbox" id="idSave">아이디 저장</label> 
						<label><input type="checkbox" id="idStateful">로그인 상태유지</label>
					</div>

					<button type="submit" class="btn btn-primary btn-block btn-lg">로그인</button>

					<div class="find_id_pw text-center">
						<a href="${pageContext.request.contextPath}/member/find_id.cider">아이디찾기</a>
						<span>|</span>
						<a href="${pageContext.request.contextPath}/member/find_pw.cider">비밀번호찾기</a>
					</div>
					<div class="join_info text-center">
						처음이신가요?
						<a href="${pageContext.request.contextPath}/member/join.cider">회원가입</a>
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
	<!-- jQeury Ajax Form plugin CDN -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
	<script type="text/javascript">
	
          $(function() {
        	  if ($("#idSave").is(":checked") == true) { // 아이디 저장을 체크 하였을때
	  	          setCookie("id", $("#email").val(), 1); //쿠키이름을 id로 아이디입력필드값을 7일동안 저장
	  	      } else { // 아이디 저장을 체크 하지 않았을때
	  	          setCookie("id", $("#email").val(), 0); //날짜를 0으로 저장하여 쿠키삭제
	  	      }
        	  
			  // 비밀번호 '*' 해제하기
              $(".eyeicon").click(function() {
                if ($(this).hasClass("glyphicon-eye-close")) {
                  $(this).removeClass("glyphicon-eye-close").addClass("glyphicon-eye-open");
                  var type = $(this).prev("input[type='password']").attr("type", "text");
                } else {
                  $(this).removeClass("glyphicon-eye-open").addClass("glyphicon-eye-close");
                  var type = $(this).prev("input[type='text']").attr("type", "password");
                }
              });

			  // 아이디, 비밀번호 정규표현식 검사
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
              
              // 정규표현식 만족 여부 알림
              var GetAjaxPW = function(val){
                if(check_eng.test(val)) { $('.in-eng').css('color', '#ff8e18') } else {$('.in-eng').css('color', '#aaa')}
                if(check_num.test(val)) { $('.in-num').css('color', '#ff8e18') } else {$('.in-num').css('color', '#aaa')}
                if(check_spc.test(val)) { $('.in-spc').css('color', '#ff8e18') } else {$('.in-spc').css('color', '#aaa')}
                return false;
              };

              $("#loginForm").submit(function(e) {
                e.preventDefault();
                /** 이름 검사 */
                if (!regex.value('#email', '아이디(이메일)을 입력하세요.')) { return false; }
                if (!regex.email('#email', '이메일 주소가 잘못되었습니다.')) { return false; }

                /** 비밀번호 검사 */
                if (!regex.value('#password', '비밀번호를 입력하세요.')) { return false; }
                if (!regex.eng_num_spc('#password', '비밀번호를 형식에 맞게 입력하세요.')) { return false; }
                if (!regex.min_length('#password', 8, '비밀번호는 최소 8자 이상 입력 가능합니다.')) { return false; }
                if (!regex.max_length('#password', 20, '비밀번호는 최대 20자 까지만 입력 가능합니다.')) { return false; }
                
                /** Ajax 호출 */
                const form = $(this);
                const url = form.attr('action');
                const email = $("#email").val();
                const p = email.lastIndexOf("@");
            	const name = email.substring(0, p);
                $.ajax({
                    type: "POST",
                    url: url,
                    data: form.serialize(),
                    success: function(json) {
  	    				console.log(json);
  	    				alert("반갑습니다 "+ name + "님! 쿨거래 하세요^^");
  	    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
  	    				if (json.rt == "OK") {
  	    					
  	    					window.location = "${pageContext.request.contextPath}";
  	    				}
  	    			}
                 });
                

              });
              
          });
        </script>


</body>

</html>