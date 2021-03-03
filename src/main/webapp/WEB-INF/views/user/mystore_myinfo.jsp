<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>내상점-내정보설정 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_myinfo.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
	<!-- 화면에 표시될 원본 보기 영역 - 기본적으로 숨겨진 상태이다. -->
	<div class='gray_layer' id='background'></div>
	<div class='over_layer' id='front'></div>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<section>
		<div class="container">
			<!-- 유저 프로필 고정부분 -->
			<%@ include file="/WEB-INF/views/inc/user_profile.jsp"%>
		</div>
		<div class="div_blank"></div>
		<!--// 탭 메뉴 끝 -->
		<!-- 탭 화면 시작 -->
		<div id="myinfo">
			<div class="container">
				
				<form id="addForm" name="addForm" enctype=“multipart/form-data” role="form" action="${pageContext.request.contextPath}/myinfo_profile">
				<div class="media">
					<!-- 프로필이미지 -->
					<span> 
					<c:choose>
                    	<c:when test="${output.filepath == null && fn:length(output.filepath) == 0}">
							<img id="image_section" class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img/default_profile.jpg" width="110" height="110" alt="${output.nickname}">
                    	</c:when>
                   		<c:otherwise>
                   			<input type="hidden" name="origin_image0" value="${output_01.fileno}">
							<img name="origin_img" id="image_section" class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img${output.filepath}" width="110" height="110" alt="${output.nickname}" >
                   		</c:otherwise>
                   	</c:choose>
                   	<input name="image0" type="file" id="imgInput" class="image_plus" accept="image/*"/>
                   	
					</span>
					<div class="col-xs-3 col-xs-offset-6 mediaBtn">
						<button id="change-btn1" class="btn btn-warning" type="submit">사진변경</button>
					</div>	
				</div>
				</form>
				<!-- ---------------------------------------------------- -->
				<form name="editForm1" id="editForm1" action="${pageContext.request.contextPath}/myinfo_id">
					<div class="row ">
						<div class="col-sm-2 my_title">
							<span>닉네임</span>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-9 margin-bt-big">
							<input name="nickname" type="text" class="form-control" value="${output.nickname}"></input>
						</div>
						<div class="col-xs-3">
							<button id="change-btn1" class="btn btn-warning" type="submit">변경</button>
						</div>
					</div>

				</form>
				<!-- 소개글 -->
				<form name="editForm2" id="editForm2" action="${pageContext.request.contextPath}/myinfo_intro">
					<div class="row margin-top">
						<div class="col-sm-2 margin-top">
							<span>소개글</span>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-9 form-group margin-bt">
							<textarea id="intro" name="intro" class="form-control" rows="3">${output.intro}</textarea>
						</div>
						<div class="col-xs-3">
							<button id="change-btn2" class="btn btn-warning" type="submit">변경</button>
						</div>
					</div>
				</form>

				<!-- 상점주소 -->
				<form name="editForm3" id="editForm3" action="${pageContext.request.contextPath}/myinfo_shopaddress">
				<div class="row">
					<div class="col-sm-2">
						<span>상점주소</span>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-9">
						<span id="address">www.cidermarket.com/mystore/</span> <input id="store-id" name="shopaddress" type="text" class="form-control" value="${output.shopaddress}"></input>
					</div>
					<div class="col-xs-3">
						<button id="change-btn3" class="btn btn-warning" type="submit" value="submit">변경</button>
					</div>
					<div class="col-xs-10">
						<span class="write-rule">* 6-15자 영문 소문자, 숫자로 입력해주세요.(숫자만 불가)</span>
					</div>
					<div class="col-xs-10 margin-bt">
						<span class="write-rule">* 한 번 설정한 주소는 30일 이후 변경할 수 있습니다. </span>
					</div>
				</div>
				</form >

				<!-- 아이디 -->
				<div class="row">
					<div class="col-sm-2 margin-top">
						<span class=>아이디</span>
					</div>
				</div>
				<form name="editForm4" id="editForm4" action="${pageContext.request.contextPath}/myinfo_email">
				<div class="row">
					<div class="col-xs-9 bottom margin-bt">
						<span class="form-control">${output.email}</span>
					</div>
					<div class="col-xs-3">
						<button id="change-btn4" class="btn btn-warning" type="button">변경</button>
					</div>

					<!-- 숨겨진내용 -->
					<div id="show1" class="col-xs-9 bottom hide-id">
						<input id="emailid" name="email" type="text" class="form-control" placeholder="이메일주소를 입력하세요"></input>
					</div>
					<div id="show2" class="col-xs-3 hide-id">
						<button id="prove" class="btn btn-info" type="button">인증</button>
					</div>
					<div id="show3" class="col-xs-9 bottom hide-id">
						<input id="id-phone" name="certificate" type="text" class="form-control" placeholder="인증번호를 입력해 주세요"></input>
					</div>
					<div id="show4" class="col-xs-3 hide-id">
						<button id="confirm" class="btn btn-info" type="submit">확인</button>
					</div>
					<!-- 여기까지 -->
				</div>
				</form>

				<!-- 휴대폰 -->
				<form name="editForm5" id="editForm5" action="${pageContext.request.contextPath}/myinfo_tel">
				<div class="row ">
					<div class="col-sm-2 margin-top">
						<span>휴대폰</span>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-9 margin-bt">
						<input class="form-control" value="${output.tel}" />
					</div>
					<div class="col-xs-3">
						<button id="change-btn5" class="btn btn-warning" type="button">변경</button>
					</div>

					<!-- 핸드폰인증 -->
					<div id="show5" class="col-xs-9 bottom hide-id">
						<input id="phone-number" name="tel" type="text" class="form-control" placeholder="휴대폰번호를 입력해주세요"></input>
					</div>
					<div id="show6" class="col-xs-3 hide-id">
						<button id="prove1" class="btn btn-info" type="submit">인증</button>
					</div>
					<!-- 여기까지 -->
				</div>
				</form>

				<!-- 비밀번호 -->
				<form name="editForm6" id="editForm6" action="${pageContext.request.contextPath}/myinfo_password">
				<div class="row ">
					<div class="col-sm-2 margin-top">
						<span>비밀번호</span>
					</div>
				</div>
				
				<div class="row">
					<div class="col-xs-9 margin-bt">
						<span class="form-control">********</span>
					</div>
					<div class="col-xs-3">
						<button id="change-btn6" class="btn btn-warning" type="button">변경</button>
					</div>

					<!-- 비밀번호변경 -->
					<div id="show7" class="col-xs-9 bottom hide-id">
						<input id="user_pw" name="password" type="password" class="form-control" placeholder="현재 비밀번호를 입력해주세요"></input>
					</div>

					<div id="show9" class="col-xs-9 bottom hide-id">
						<input name="newpassword" type="password" class="form-control" placeholder="신규 비밀번호를 입력해주세요"></input>
					</div>
					<div id="show8" class="col-xs-3 hide-id">
						<button id="confirm1" class="btn btn-info" type="submit">확인</button>
					</div>
					<div class="col-xs-10 margin-bt">
						<span class="write-rule">최소 8~16자 이하의 영문,숫자,특수문자 중 1개 이상 포함</span>
					</div>

				</div>
				</form>


				<!-- 수신설정 -->
		
				<div class="row margin-top">
					<div class="col-sm-2">
						<span>수신설정</span>
					</div>
				</div>
				
				<div class="row">
					
					
				
						<form name="editForm7" id="editForm7" action="${pageContext.request.contextPath}/myinfo_SMS">
						<c:choose>
						 <c:when test="${output.sms==1}">
						<div class="col-xs-9">
							<input type="checkbox" id="email" name="sms" value="1" checked> <span class="email">Email</span> 
							<input class="SMS" type="checkbox" id="sms" name="sms" value="2"> <span class="SMS">SMS</span> <span class="write-rule block">회원정보, 거래정보 및 서비스 주요 정책 관련 내용은 수신동의 여부와 관계없이 발송됩니다.</span>
						</div>
						<div class="col-xs-3">
							<button type="submit" id="change-btn5" class="btn btn-warning" type="button">변경</button>
						</div>
						</c:when>
						 <c:when test="${output.sms==2}">
						<div class="col-xs-9">
							<input type="checkbox" id="email" name="sms" value="1"> <span class="email">Email</span> 
							<input class="SMS" type="checkbox" id="sms" name="sms" value="2" checked> <span class="SMS">SMS</span> <span class="write-rule block">회원정보, 거래정보 및 서비스 주요 정책 관련 내용은 수신동의 여부와 관계없이 발송됩니다.</span>
						</div>
						<div class="col-xs-3">
							<button type="submit" id="change-btn5" class="btn btn-warning" type="button">변경</button>
						</div>
						</c:when>
						 <c:when test="${output.sms==3}">
						<div class="col-xs-9">
							<input type="checkbox" id="email" name="sms" value="1" checked> <span class="email">Email</span> 
							<input class="SMS" type="checkbox" id="sms" name="sms" value="2" checked> <span class="SMS">SMS</span> <span class="write-rule block">회원정보, 거래정보 및 서비스 주요 정책 관련 내용은 수신동의 여부와 관계없이 발송됩니다.</span>
						</div>
						<div class="col-xs-3">
							<button type="submit" id="change-btn5" class="btn btn-warning" type="button">변경</button>
						</div>
						</c:when>
						 <c:when test="${output.sms==0}">
						<div class="col-xs-9">
							<input type="checkbox" id="email" name="sms" value="1"> <span class="email">Email</span> 
							<input class="SMS" type="checkbox" id="sms" name="sms" value="2"> <span class="SMS">SMS</span> <span class="write-rule block">회원정보, 거래정보 및 서비스 주요 정책 관련 내용은 수신동의 여부와 관계없이 발송됩니다.</span>
						</div>
						<div class="col-xs-3">
							<button type="submit" id="change-btn5" class="btn btn-warning" type="button">변경</button>
						</div>
						</c:when>																		
						</c:choose>
						</form>
					
					<form name="editForm8" id="editForm8" action="${pageContext.request.contextPath}/myinfo_out">
					<div class="row">
						<div class="col-xs-3 col-xs-offset-8">
							<button id="outmember1" class="btn btn-default out-btn" type="submit">회원탈퇴</button>
							<input id="outmember" name=outmember type="hidden" value="Y"/>
						</div>
					</div>
					</form>
					<div class="last-div"></div>
				</div>

				
			</div>
		</div>
	</section>

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
	<script type="text/javascript">
		/* 서브메뉴버튼 활성화 */
    	document.querySelector('.my_ctg li:nth-child(4)').className = 'active';
	
		$(function() {
			
		

			// 이름변경 
			$("#editForm1").submit(function(e) {
			e.preventDefault();
			/** 이름 검사 */
			/** Ajax 호출 */
			const form = $(this);
			const url = form.attr('action');

			$.ajax({
				type : "PUT",
				url : url,
				data : form.serialize(),
				success : function(json) {
					console.log(">>>>>>>>>>>>>>>>>>>>>>"+ json);
					alert("변경되었습니다.");
					window.location = "${pageContext.request.contextPath}/mystore/{shopaddress}/myinfo.cider?membno"
							+ json.item.membno;}

					});
			});
			
			// 소개글변경 
			$("#editForm2").submit(function(e) {
			e.preventDefault();
			/** 이름 검사 */
			/** Ajax 호출 */
			const form = $(this);
			const url = form.attr('action');

			$.ajax({
				type : "PUT",
				url : url,
				data : form.serialize(),
				success : function(json) {
					console.log(">>>>>>>>>>>>>>>>>>>>>>"+ json);
					alert("변경되었습니다.");
					window.location = "${pageContext.request.contextPath}/mystore/{shopaddress}/myinfo.cider?membno"
							+ json.item.membno;}

					});
			});			
			
			$("#editForm3").submit(function(e) {
				e.preventDefault();
				/** 이름 검사 */
				/** Ajax 호출 */
				const form = $(this);
				const url = form.attr('action');

				$.ajax({
					type : "PUT",
					url : url,
					data : form.serialize(),
					success : function(json) {
						console.log(">>>>>>>>>>>>>>>>>>>>>>"+ json);
						alert("변경되었습니다.");
						window.location = "${pageContext.request.contextPath}/mystore/{shopaddress}/myinfo.cider?membno"
								+ json.item.membno;}

						});
				});	
			$("#editForm4").submit(function(e) {
				e.preventDefault();
				/** 이름 검사 */
				/** Ajax 호출 */
				const form = $(this);
				const url = form.attr('action');

				$.ajax({
					type : "PUT",
					url : url,
					data : form.serialize(),
					success : function(json) {
						console.log(">>>>>>>>>>>>>>>>>>>>>>"+ json);
						alert("변경되었습니다.");
						window.location = "${pageContext.request.contextPath}/mystore/{shopaddress}/myinfo.cider?membno"
								+ json.item.membno;}

						});
				});		
			$("#editForm5").submit(function(e) {
				e.preventDefault();
				/** 이름 검사 */
				/** Ajax 호출 */
				const form = $(this);
				const url = form.attr('action');

				$.ajax({
					type : "PUT",
					url : url,
					data : form.serialize(),
					success : function(json) {
						console.log(">>>>>>>>>>>>>>>>>>>>>>"+ json);
						alert("변경되었습니다.");
						window.location = "${pageContext.request.contextPath}/mystore/{shopaddress}/myinfo.cider?membno"
								+ json.item.membno;}

						});
				});		
			
			$("#editForm6").submit(function(e) {
				e.preventDefault();
				/** 이름 검사 */
				/** Ajax 호출 */
				const form = $(this);
				const url = form.attr('action');

				$.ajax({
					type : "PUT",
					url : url,
					data : form.serialize(),
					success : function(json) {
						console.log(">>>>>>>>>>>>>>>>>>>>>>"+ json);
						alert("변경되었습니다.");
						window.location = "${pageContext.request.contextPath}/mystore/{shopaddress}/myinfo.cider?membno"
								+ json.item.membno;}

						});
				});	
			
			$("#editForm7").submit(function(e) {
				e.preventDefault();
				/** 이름 검사 */
				/** Ajax 호출 */
				const form = $(this);
				const url = form.attr('action');

				$.ajax({
					type : "PUT",
					url : url,
					data : form.serialize(),
					success : function(json) {
						console.log(">>>>>>>>>>>>>>>>>>>>>>"+ json);
						alert("변경되었습니다.");
						window.location = "${pageContext.request.contextPath}/mystore/{shopaddress}/myinfo.cider?membno"
								+ json.item.membno;}

						});
				});	
			
			$("#editForm8").submit(function(e) {
				e.preventDefault();
				var f = confirm("정녕 탈퇴하시겠습니까?");
				if (f==true) {
					
					/** 이름 검사 */
					/** Ajax 호출 */
					const form = $(this);
					const url = form.attr('action');
					$.ajax({
						type : "PUT",
						url : url,
						data : form.serialize(),
						success : function(json) {
							console.log(">>>>>>>>>>>>>>>>>>>>>>"+ json);
							alert("탈퇴처리 되었습니다.");
							window.location = "${pageContext.request.contextPath}/"}
							});
					// submit(); //실제로 데이터 안넘어갈때 submit() 활성화 할것! 
				} else {
					return false;
				}
				});	


            
            $("#show2").click(function(){
            	alert("인증번호를 이메일로 발송하였습니다.");
            });
			

			/** modal 링크를 클릭한 경우 */
			$("#modal").click(function(e) {
				e.preventDefault(); // 페이지 이동 방지
				$("#background").fadeIn(300); // 배경 레이어를 화면에 표시한다.
				$("#front").fadeIn(200); // 이미지 레이어를 화면에 표시한다.
			});

			/** (화면에 표시된) 배경 레이어를 클릭한 경우 */
			$("#background").click(function() {
				$(this).fadeOut(300); // 배경 레이어의 숨김
				$("#front").fadeOut(200); // 이미지 레이어의 숨김
			});

		

			// 숨겨진 내용 보여주기
			$("#change-btn4").click(function() {
				$("#show1").slideToggle(300);
				$("#show2").slideToggle(300);
				$("#show3").slideToggle(300);
				$("#show4").slideToggle(300);

			});

			$("#change-btn5").click(function() {
				$("#show5").slideToggle(300);
				$("#show6").slideToggle(300);

			});

			$("#change-btn6").click(function() {
				$("#show7").slideToggle(300);
				$("#show8").slideToggle(300);
				$("#show9").slideToggle(300);
				$("#show10").slideToggle(300);

			});


			// 등록 이미지 등록 미리보기
			function readURL(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$("#image_section").attr('src', e.target.result);

						// $(input).css('background-image', 'url(\"' + e.target.result + '\")');
						// $(input).prev().css('display', 'block');
					}
					reader.readAsDataURL(input.files[0]);
				}
			}

			$("#imgInput").on('change', function() {
				readURL(this);
			});
			
			
			// #item_img_group에 대한 submit이벤트를 가로채서 Ajax요청을 전송한다.
         	 $("#addForm").ajaxForm({
	                // 전송 메서드 지정
	                method: "POST",
	                // 서버에서 200 응답을 전달한 경우 실행됨
	                success: function(json) {
	                    console.log(json);
	                 // json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
	                    if (json.rt == "OK") {
	                    	alert("프로필사진을 변경하였습니다.");
	                   	 window.location="${pageContext.request.contextPath}/mystore/{shopaddress}/myinfo.cider?membno"
								+ json.item.membno;;
	                    }
	                }
	            });
				

 
		});

	</script>
</body>

</html>