<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>헬프센터 자주묻는질문 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<section>
		<!-- Item 영역 -->
		<div class="container">
			<h3 class="text-center">헬프센터</h3>

			<!-- 탭의 전체 박스 -->
			<div class="tab clearfix">

				<!-- 탭 버튼 영역 -->
				<ul class="row tab-button clearfix">
					<li role="presentation" class="tab-button-item text-center"><a href="#tab-page-faq" class="tab-button-item-link3 pull-left selected" id="faq">자주묻는질문</a></li>
					<li role="presentation" class="tab-button-item text-center"><a href="#tab-page-policy" class="tab-button-item-link3 pull-left" id="policy">운영정책</a></li>
					<li role="presentation" class="tab-button-item text-center"><a href="#tab-page-inquiry" class="tab-button-item-link3 pull-left" id="inquiry">일반문의</a></li>
				</ul>

				<!-- 내용영역 -->
				<div class="tab-panel">
					<div id="tab-page-faq">
						<!-- 검색 -->
						<div id="searchBox_help" class="container">
							<input type="text" class="form-control" id="myInput" placeholder="키워드를 입력해 주세요.">
							<button class="btn btnSearch-help" type="button">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
						<!-- sorting -->
						<div class="recordSort text-center">
							<button type="button" class="ing btn btn-primary" data-faq="faq_list_01">TOP 10</button>
							<button type="button" class="ing btn btn-info" data-faq="faq_list_02">이용방법</button>
							<button type="button" class="ing btn btn-info" data-faq="faq_list_03">택배</button>
							<button type="button" class="ing btn btn-info" data-faq="faq_list_04">결제</button>
						</div>
						<!-- Ajax 패널 -->
						<div class="panel-group" id="accordion"></div>
					</div>

					<!-- 탭 - 운영정책 -->
					<div id="tab-page-policy" class="hide">
						<%@ include file="/WEB-INF/views/user/policy.jsp"%>
					</div>

					<!-- 탭 - 일반문의 -->
					<div id="tab-page-inquiry" class="hide">
						<%@ include file="/WEB-INF/views/user/inquiry.jsp"%>
					</div>
				</div>
			</div>


		</div>
	</section>

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

	<!-- template -->
	<script id="faq1_tmpl" type="text/x-handlebars-template">
		{{#each List}}
		<div class="panel panel-faq">
			<div class="panel-body">
				<h4 class="panel-title accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse{{@key}}">
					{{title}}
				</h4>
			</div>
			<div id="collapse{{@key}}" class="panel-collapse collapse">
				<div class="panel-footer">
					<p>{{{content}}}</p>
				</div>
			</div>
		</div><!-- // 리스트 끝 -->	
		{{/each}}
	</script>
	<!-- template -->
	<script id="faq2_tmpl" type="text/x-handlebars-template">
		{{#each List}}
		<div class="panel panel-faq">
			<div class="panel-body">
				<h4 class="panel-title accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse{{@key}}">
					{{title}}
				</h4>
			</div>
			<div id="collapse{{@key}}" class="panel-collapse collapse">
				<div class="panel-footer">
					<p>{{{content}}}</p>
				</div>
			</div>
		</div><!-- // 리스트 끝 -->	
		{{/each}}
	</script>
	<!-- template -->
	<script id="faq3_tmpl" type="text/x-handlebars-template">
		{{#each List}}
		<div class="panel panel-faq">
			<div class="panel-body">
				<h4 class="panel-title accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse{{@key}}">
					{{title}}
				</h4>
			</div>
			<div id="collapse{{@key}}" class="panel-collapse collapse">
				<div class="panel-footer">
					<p>{{{content}}}</p>
				</div>
			</div>
		</div><!-- // 리스트 끝 -->	
		{{/each}}
	</script>
	<!-- template -->
	<script id="faq4_tmpl" type="text/x-handlebars-template">
		{{#each List}}
		<div class="panel panel-faq">
			<div class="panel-body">
				<h4 class="panel-title accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse{{@key}}">
					{{title}}
				</h4>
			</div>
			<div id="collapse{{@key}}" class="panel-collapse collapse">
				<div class="panel-footer">
					<p>{{{content}}}</p>
				</div>
			</div>
		</div><!-- // 리스트 끝 -->	
		{{/each}}
	</script>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<!-- handlebar plugin -->
	<script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
	<script type="text/javascript">
		function faq_list_01() {
			$.get("${pageContext.request.contextPath}/assets/plugins/ajax/faq_01.json",	function(req) {
				// 미리 준비한 HTML틀을 읽어온다.
				var template = Handlebars.compile($("#faq1_tmpl").html());
				// Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
				var html = template(req);
				// #dept_list_body 읽어온 내용을 추가한다.
				$("#accordion").append(html);
			});
		}
		function faq_list_02() {
			$.get("${pageContext.request.contextPath}/assets/plugins/ajax/faq_02.json",	function(req) {
				var template = Handlebars.compile($("#faq2_tmpl").html());
				var html = template(req);
				$("#accordion").append(html);
			});
		}
		function faq_list_03() {
			$.get("${pageContext.request.contextPath}/assets/plugins/ajax/faq_03.json",	function(req) {
				var template = Handlebars.compile($("#faq3_tmpl").html());
				var html = template(req);
				$("#accordion").append(html);
			});
		}
		function faq_list_04() {
			$.get("${pageContext.request.contextPath}/assets/plugins/ajax/faq_04.json",	function(req) {
				var template = Handlebars.compile($("#faq4_tmpl").html());
				var html = template(req);
				$("#accordion").append(html);
			});
		}
		$(function() {
			faq_list_01();
			/** selected 파라미터 받아와서 1차 탭 선택함 */
			var url = new URL(window.location.href);
			var selector = url.searchParams.get("selected");
			$(".tab-button-item-link3").removeClass("selected");
			$("#" + selector).prop("selected", true).addClass("selected");
			/** 선택된 1차 탭의 href값으로 탭 패널 열기 */
			var target = $("#" + selector).attr('href');
			$(target).removeClass('hide');
			$(".tab-panel > div").not($(target)).addClass('hide');

			/** 탭 버튼의 클릭 처리 */
			$(".tab-button-item-link3").click(function(e) {
				e.preventDefault();
				$(".tab-button-item-link3").not(this).removeClass("selected");
				$(this).addClass("selected");
				var target = $(this).attr('href');
				$(target).removeClass('hide');
				$(".tab-panel > div").not($(target)).addClass('hide');
			});

			/** 자주묻는질문 하위탭 분류 */
			$(".recordSort > .btn").click(
					function(e) {
						e.preventDefault();
						$("#accordion").empty(); // 불러오기 전 기존 데이터 비우기
						var tab = $(this).data("faq"); // 탭 버튼별 데이터-속성값 가져오기.(함수명으로 사용)
						if ($(this).hasClass("btn-info")) {
							$(this).addClass("btn-primary").removeClass(
									"btn-info");
							$(".recordSort > .btn").not(this).removeClass(
									"btn-primary").addClass("btn-info");
							window[tab](); // 클릭된 데이터-속성값과 동일한 이름의 함수 호출
						} else {
							window[tab]();
						}
					});

			$("#myInput").on("keyup", function() {
				var value = $(this).val();
				$(".panel-faq h4").filter(function() {
					$(this).toggle($(this).text().indexOf(value) > -1);
				});
			});

		});
	</script>
</body>

</html>