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
	// 이전 페이지 기록
    String referer = request.getHeader("referer");
    if(referer==null)referer = "/";
%>
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
			<form role="form" method="get" id="findidForm" action="${pageContext.request.contextPath}/member/find_id">
				<fieldset>
					<legend class="sr-only">아이디 찾기</legend>

					<div class="form-group clearfix">
						<label for="tel" class="col-sm-2">휴대폰번호</label>
						<div class="col-sm-10">
							<input type="tel" id="tel" name="tel" class="form-control" placeholder="휴대폰번호를 숫자만 입력하세요." />
						</div>
					</div>
					
					<div class="alert alert-success" role="alert" id="findEmail">개인정보이므로 일부만 공개됩니다.</div>

					<button type="submit" class="btn btn-primary btn-block">찾기</button>

					<div class="find_id_pw text-center">
						<a href="${pageContext.request.contextPath}">홈으로</a>
						<span>|</span>
						<a href="${pageContext.request.contextPath}/member/find_pw.cider">비밀번호찾기</a>
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
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<script type="text/javascript">
          $(function() {
        	  
        	

              $("#findidForm").submit(function(e) {
                e.preventDefault();
                /** 연락처 검사 */
                if (!regex.value('#tel', '연락처를 입력하세요.')) { return false; }
                if (!regex.phone('#tel', '연락처가 잘못되었습니다.')) { return false; }
                
                
                const form = $(this);
                const url = form.attr('action');
                $.ajax({
                    type: "get",
                    url: url,
                    data: form.serialize(),
                    success: function(json) {
  	    				console.log(json);
  	    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
  	    				if (json.rt == "OK") {
 	 	    				alert("아이디를 찾았습니다.");
 	 	    				var email = json.item.email;
 	 	    				var count = email.length - 4;
 	 	    				email = email.substring(0, 4);
 	 	    				$("#findEmail").empty();
 	 	    				$("#findEmail").append("찾으신 아이디는 " + email);
 	 	    				$("#findEmail").append("*".repeat(count) + " 입니다.");
  	    				}
  	    			}
                 });
                
              });
              
              
          });
        </script>
</body>

</html>