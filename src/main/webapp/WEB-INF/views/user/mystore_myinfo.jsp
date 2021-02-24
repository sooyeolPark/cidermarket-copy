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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.min.css" />
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
				<div class="media">

					<!-- 조던이미지 -->
					<span> <img id="image_section" class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img/user_jordan.jpg" width="110" height="110" alt="Generic placeholder image"> <input type="file" id="imgInput" class="image_plus" accept="image/*" />
					</span>

					<!-- 이미지파일추가 -->

				</div>

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
						<span class="write-rule">최소 6~15자 이하의 영문,숫자,특수문자 중 2개 이상 포함</span>
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
						
						<div class="col-xs-9">
							<input type="checkbox" id="email" name="email" value="1"> <span class="email">Email</span> <input class="SMS" type="checkbox" id="sms" name="sms" value="2"> <span class="SMS">SMS</span> <span class="write-rule block">회원정보, 거래정보 및 서비스 주요 정책 관련 내용은 수신동의 여부와 관계없이 발송됩니다.</span>
						</div>
						<div class="col-xs-3">
							<button type="submit" id="change-btn5" class="btn btn-warning" type="button">변경</button>
						</div>
						</form>
					
					<form name="editForm8" id="editForm8" action="${pageContext.request.contextPath}/myinfo_out">
					<div class="row">
						<div class="col-xs-3 col-xs-offset-8">
							<button id="outmember1" class="btn btn-default out-btn" type="submit">회원탈퇴</button>
							<input id="outmember" name=outmember type="hidden" value="y"/>
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
	<script type="text/javascript">
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

			


			

			
			  // 아이디, 비밀번호 정규표현식 검사
            var check_num = /[0-9]/; // 숫자 
            var check_eng = /[a-zA-Z]/; // 문자 
            var check_spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
            var check_email = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

            $('#emailid').keyup(function(){
              var msg = '', val = this.value;
              if(!check_email.test(val)){
                msg = '이메일 형식으로 입력하세요.'
                $('#idc').html(msg).css('visibility', 'visible');
              } else {
                $('#idc').css('visibility', 'hidden');
              };
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

			// 변경버튼 스윗alert

			// $("#change-btn1").click(function () {
			//   swal({ text: '변경완료 되었습니다.' });
			// });



			// 사진등록& 미리보기
			// function readInputFile(input) {
			//   if (input.files && input.files[0]) {
			//     var reader = new FileReader();
			//     reader.onload = function (e) {
			//       $(input).css('background-image', 'url(\"' + e.target.result + '\")');
			//       $(input).next().css('display', 'inline');
			//     }
			//     reader.readAsDataURL(input.files[0]);
			//   }
			// }

			// $(".image_plus").on('change', function () {
			//   readInputFile(this);
			// });

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

			// 유효성검사 nickname

			/** 플러그인의 기본 설정 옵션 추가 */
			jQuery.validator.setDefaults({
				onkeyup : false, // 키보드입력시 검사 안함
				onclick : false, // <input>태그 클릭시 검사 안함
				onfocusout : false, // 포커스가 빠져나올 때 검사 안함
				showErrors : function(errorMap, errorList) { // 에러 발생시 호출되는 함수 재정의
					// 에러가 있을 때만..
					if (this.numberOfInvalids()) {
						// 0번째 에러 메시지에 대한 javascript 기본 alert 함수 사용
						//alert(errorList[0].message);
						// 0번째 에러 발생 항목에 포커스 지정
						//$(errorList[0].element).focus();

						swal({
							title : "에러",
							text : errorList[0].message,
							type : "error"
						}).then(function(result) {
							// 창이 닫히는 애니메이션의 시간이 있으므로,
							// 0.1초의 딜레이 적용 후 포커스 이동
							setTimeout(function() {
								$(errorList[0].element).val('');
								$(errorList[0].element).focus();
							}, 100);
						});
					}
				}
			});

			/** 유효성 검사 추가 함수 */
			$.validator.addMethod("all", function(value, element) {
				return this.optional(element)
						|| /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/i.test(value);
			});

			$.validator.addMethod("kor", function(value, element) {
				return this.optional(element) || /^[ㄱ-ㅎ가-힣]*$/i.test(value);
			});

			$.validator.addMethod("phone", function(value, element) {
				return this.optional(element)
						|| /^01(?:0|1|[6-9])(?:\d{3}|\d{4})\d{4}$/i.test(value)
						|| /^\d{2,3}\d{3,4}\d{4}$/i.test(value);
			});

			/** form태그에 부여한 id속성에 대한 유효성 검사 함수 호출 */
			$("#join_form").validate({
				submitHandler : function() {
					var f = confirm("변경하시겠습니까?");
					if (f) {
						swal({
							text : '변경완료'
						});
						// submit(); //실제로 데이터 안넘어갈때 submit() 활성화 할것! 
					} else {
						return false;
					}
				},
				/** 입력검사 규칙 */
				rules : {
					// [아이디] 필수 + 알파벳,숫자 조합만 허용
					user_id : {
						required : true,
						all : true
					},

					store : {
						required : true,
						alphanumeric : true
					},

					// [비밀번호] 필수 + 글자수 길이 제한
					user_pw : {
						required : true,
						minlength : 4,
						maxlength : 20
					},
					// [비밀번호 확인] 필수 + 특정 항목과 일치 (id로 연결)
					user_pw_re : {
						required : true,
						equalTo : "#user_pw"
					},
					// [이름] 필수
					user_name : {
						required : true,
						kor : true
					},
					// [이메일] 필수 + 이메일 형식 일치 필요
					email : {
						required : true,
						email : true
					},
					// [연락처] 필수
					tel : {
						required : true,
						phone : true
					},
					// [생년월일] 필수 + 날짜 형식 일치 필요
					birthdate : {
						required : true,
						date : true
					},
					// [성별] 필수 입력,
					gender : "required",
					// [수강과목] 필수, 최소2개, 최대4개
					subject : {
						required : true,
						minlength : 2,
						maxlength : 4
					},
					// 허용할 확장자 명시
					profile_img : {
						extension : "jpg|gif|png"
					},

				},
				/** 규칙이 맞지 않을 경우의 메시지 */
				messages : {
					user_id : {
						required : "아이디를 입력하세요.",
						all : "아이디는 영어,한글,숫자만 입력 가능합니다.",
					},

					store : {
						required : "상점주소를 입력하세요.",
						alphanumeric : "아이디는 영어,숫자만 입력 가능합니다."
					},
					user_pw : {
						required : "비밀번호를 입력하세요.",
						minlength : "비밀번호는 4글자 이상 입력하셔야 합니다.",
						maxlength : "비밀번호는 최대 20자까지 가능합니다."
					},
					user_pw_re : {
						required : "비밀번호 확인값을 입력하세요.",
						equalTo : "비밀번호 확인이 잘못되었습니다."
					},
					user_name : {
						required : "이름을 입력하세요.",
						kor : "이름은 한글만 입력 가능합니다."
					},
					email : {
						required : "이메일을 입력하세요.",
						email : "이메일 형식이 잘못되었습니다."
					},
					tel : {
						required : "연락처를 입력하세요.",
						phone : "연락처 형식이 잘못되었습니다."
					},
					birthdate : {
						required : "생년월일을 입력하세요.",
						date : "생년월일의 형식이 잘못되었습니다."
					},
					gender : "성별을 선택해 주세요.",

					subject : {
						required : "수강과목을 선택하세요",
						minlength : "수강과목은 최소 2개 이상 선택하셔야 합니다.",
						maxlength : "수강과목은 최대 4개 까지 선택 가능합니다."
					},
					profile_img : {
						extension : "프로필 사진은 jpg,png,gif 형식만 가능합니다."
					}
				}

			}); // end validate()

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

		});

	</script>
</body>

</html>