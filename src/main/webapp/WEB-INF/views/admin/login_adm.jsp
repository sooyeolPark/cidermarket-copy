<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 로그인 되어 있지 않으면 메인페이지로 강제 이동
	if (session.getAttribute("myAdmNum") != null) {
		response.sendRedirect("/cidermarket/admin/home_adm.cider");
	}
%>
<!doctype html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
<title>관리자 로그인 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/common/font.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/common/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/common/nav.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/login_adm.css" />
</head>

<body>
	<!-- content 시작 -->
	<section>
		<!-- Item 영역 -->
		<div class="container">
			<h3 class="text-center">관리자 로그인</h3>
			<!-- login form -->
			<form role="form" id="login-form" action="${pageContext.request.contextPath}/admin/login.cider">
				<fieldset>
					<legend class="sr-only">로그인</legend>

					<div class="form-group clearfix">
						<label for="email">아이디</label>
						<div class="email-box">
							<input type="email" id="email" name="email" class="form-control" placeholder="아이디를 입력하세요." />
							<p id="idc" class="pop"></p>
						</div>
					</div>

					<div class="form-group clearfix">
						<label for="password">비밀번호</label>
						<div class="password_icon">
							<input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요." />
							<i class="eyeicon glyphicon glyphicon-eye-close"></i> <span class="in-eng">✔ 영어포함</span> <span class="in-num">✔ 숫자포함</span> <span class="in-spc">✔ 특수문자포함</span>
							<p id="pwc" class="pop"></p>
						</div>
					</div>

					<div class="checkbox">
						<label><input type="checkbox" id="idSave" <c:if test="${cookie.id.value != null && cookie.id.value != ''}">checked</c:if>>아이디 저장</label> 
						<label><input type="checkbox" id="idStateful" <c:if test="${cookie.idStateful.value != null && cookie.idStateful.value != ''}">checked</c:if>>로그인 상태유지</label>
						<input type="hidden" name="idStateful" id="ids" value="" />
					</div>

					<button type="submit" class="btn btn-primary btn-block btn-lg">로그인</button>
				</fieldset>
			</form>
		</div>
		<!-- // login form -->
	</section>
	<!-- // content 끝 -->

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>
	<script type="text/javascript">
	
	//쿠키 저장함수 | 쿠키이름=쿠키값; Domain=도메인값; Path=경로값; Expires=GMT형식의만료일시
	function setCookie(name, value, expiredays) {
	    var todayDate = new Date();
	    todayDate.setDate(todayDate.getDate() + expiredays);
	    document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	
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

              $("#login-form").submit(function(e) {
                e.preventDefault();
                /** 이름 검사 */
                if (!regex.value('#email', '아이디(이메일)을 입력하세요.')) { return false; }
                if (!regex.email('#email', '이메일 주소가 잘못되었습니다.')) { return false; }

                /** 비밀번호 검사 */
                if (!regex.value('#password', '비밀번호를 입력하세요.')) { return false; }
                if (!regex.eng_num_spc('#password', '비밀번호를 형식에 맞게 입력하세요.')) { return false; }
                if (!regex.min_length('#password', 8, '비밀번호는 최소 8자 이상 입력 가능합니다.')) { return false; }
                if (!regex.max_length('#password', 20, '비밀번호는 최대 20자 까지만 입력 가능합니다.')) { return false; }
                
             	// 아이디 저장 체크시 쿠키에 값 저장
                if ($("#idSave").is(":checked") == true) { // 아이디 저장을 체크 하였을때
  	  	          setCookie("id", $("#email").val(), 7); //쿠키이름을 id로 아이디입력필드값을 7일동안 저장
  	  	        } else { // 아이디 저장을 체크 하지 않았을때
  	  	          setCookie("id", $("#email").val(), 0); //날짜를 0으로 저장하여 쿠키삭제
  	  	        }
                
                // 로그인 상태유지
                if ($("#idStateful").is(":checked") == true) { // 아이디 저장을 체크 하였을때
                	$("#ids").val("true");
                } else {
                	$("#ids").val("");
                }
                
                /** Ajax 호출 */
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
  	    					window.location = "${pageContext.request.contextPath}/admin/home_adm.cider";
  	    				}
  	    			},
  	    			error: function(error) {
  	    				alert("관리자 아이디가 존재하지 않습니다.");
  	    			}
			     });

              });


          });
        </script>
</body>
</html>