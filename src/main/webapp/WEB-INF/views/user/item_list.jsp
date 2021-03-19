<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>상품목록 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<section>
		<!-- Item 영역 -->
		<div class="container">
			<p class="category-name text-center">Category</p>
			<h3 id="category-title" class="text-center" data-cateno="${category.cateno}">${category.name}</h3>

			<div class="item-filter text-center">
				<button type="button" class="btn btn-danger btn-lg" data-toggle="modal" data-target="#myModal">
					<span class="glyphicon glyphicon-filter"></span> 상품필터
				</button>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">상품필터</h4>
						</div>
						<div class="modal-body">
							<div class="filter_category_sort">
								<div class="filter_sort">
									<h5>상품상태</h5>
									<button id="button0" name="prodcon" class="btn btn-tag" value="10">
										<span class="glyphicon glyphicon-ok"></span> 새상품
									</button>
									<button id="button1" name="prodcon" class="btn btn-tag" value="100">
										<span class="glyphicon glyphicon-ok"></span> 거의새것
									</button>
									<button id="button2" name="prodcon" class="btn btn-tag" value="1000">
										<span class="glyphicon glyphicon-ok"></span> 중고
									</button>
								</div>
								<div class="filter_sort">
									<h5>판매방법</h5>
									<button id="button3" name="how" class="btn btn-tag" value="20">
										<span class="glyphicon glyphicon-ok"></span> 직거래
									</button>
									<button id="button4" name="how" class="btn btn-tag" value="200">
										<span class="glyphicon glyphicon-ok"></span> 택배거래
									</button>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button id="applyFilter" type="button" class="btn btn-primary" data-dismiss="modal">선택적용</button>
						</div>
					</div>
				</div>
			</div>
			<!-- Modal -->

			<div class="item-row">
				<select class="form-control" id="item-select">
					<option value="fastest">정렬하기</option>
					<option value="fastest">최신순</option>
					<option value="lowprice">저가순</option>
					<option value="highprice">고가순</option>
				</select>
				<div class="btn-group">
					<button id="sortList" type="button" class="btn btn-default btn-list">
						<span class="glyphicon glyphicon glyphicon-th-list"></span><span class="sr-only">썸네일로 보기</span>
					</button>
					<button id="sortThumb" type="button" class="btn btn-default btn-list active">
						<span class="glyphicon glyphicon glyphicon-th-large"></span><span class="sr-only">리스트로 보기</span>
					</button>
				</div>
				<div></div>
			</div>

			<div class="box" id="item-list">
				<!-- Ajax로 로드한 결과가 표시될 곳 -->
				<c:choose>
					<%-- 조회결과가 없는 경우 --%>
					<c:when test="${output == null || fn:length(output) == 0}">
						<div class="noSearch alert alert-success">등록된 상품이 없습니다.</div>
					</c:when>
					<%-- 조회결과가 있는 경우 --%>
					<c:otherwise>
						<%-- 조회 결과에 따른 반복 처리 --%>
						<c:forEach var="item" items="${output}" varStatus="status">
							<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
								<%-- 상세페이지로 이동하기 위한 URL --%>
								<c:url var="viewUrl" value="/item_index.cider">
									<c:param name="prodno" value="${item.prodno}" />
								</c:url>

								<a href="${viewUrl}">
									<div class="sorting thumbnail">
										<c:choose>
											<c:when test="${item.filepath == null && fn:length(item.filepath) == 0}">
												<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/upload/default_product.jpg" />
											</c:when>
											<c:otherwise>
												<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/upload${item.thumbnailPath}" />
											</c:otherwise>
										</c:choose>
										<div class="caption">
											<h5>${item.subject}</h5>
											<h4>
												<fmt:formatNumber value="${item.price}" pattern="#,###" />
												원
											</h4>
											<h6>${item.sellerNick}님의상품</h6>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>

		</div>
	</section>

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>


	<!-- Handlebar 템플릿 코드 -->
	<script id="item_tmpl" type="text/x-handlebars-template">
		{{#each item}}
        <div class="col-xs-6 col-sm-4 col-lg-3 item-list">
            <a href="${pageContext.request.contextPath}/item_index.cider?prodno={{prodno}}">
                <div class="sorting thumbnail">
				{{#if filepath}}
		        	<img alt="{{subject}}" class="img-rounded" src="${pageContext.request.contextPath}/upload{{thumbnailPath}}" />
		        {{else}}
			        <img alt="{{subject}}" class="img-rounded" src="${pageContext.request.contextPath}/upload/default_product.jpg" />
				{{/if}}
                    <div class="caption">
                        <h5>{{subject}}</h5>
                        <h4>{{price}}원</h4>
						<h6>{{sellerNick}} 님의 상품</h6>
                    </div>
                </div>
            </a>
        </div>
        {{/each}}
	</script>


	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<!-- handlebar plugin -->
	<script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
	<script type="text/javascript">
		/** AJAX로 JSON데이터를 가져와서 화면에 출력하는 함수 */
		function get_sort() {
			if ($("#sortList").hasClass("active")) {
				$(".item-list").removeClass("col-xs-6 col-sm-4 col-md-3");
				$(".item-list").addClass("col-xs-12 col-sm-6 col-md-6");
				$(".sorting").removeClass("thumbnail");
				$(".sorting").addClass("itemList");
			} else if ($("#sortThumb").hasClass("active")) {
				$(".item-list").removeClass("col-xs-12 col-sm-6 col-md-6");
				$(".item-list").addClass("col-xs-6 col-sm-4 col-md-3");
				$(".sorting").removeClass("itemList");
				$(".sorting").addClass("thumbnail");
			}
			;
		}

		let nowPage = 1; // 현재페이지 위치 설정
		let isEnd = false; // 데이터를 모두 불러온 후 무한스크롤 종료를 위한 전역변수
		let isConnect = false;  // Ajax 호출 중복 방지
		
		$(function() {
			const cateno = $('#category-title').data('cateno');

			/* 정렬하기 기능 value 값 가져오기 */
			let sort = $('#item-select option:selected').val(); // 셀렉트 된 값 가져오기(기본값)
			var filter = 0;
			
			
			$("#item-select").change(function() {
				filter =0; //filter값 초기화
				sort = this.value; // 선택한 셀렉트 값 가져오기
				$("#item-list").empty(); // 기존 상품 호출 지우기
				isEnd = false; // 무한스크롤 초기화
				nowPage = 1; // 현재 페이지 1로 초기화
				for (var i = 0; i < 5; i++) {
					if ($("#button" + i + "").hasClass("active")) {
					var int_val = Number($("#button" + i + "").val());
					filter+=int_val;
					}
				}
				getProduct(sort,filter);// sort값을 기준으로 상품 다시 가져오기
			});

			// 필터버튼 눌렀을때 
			$("#applyFilter").click(function() {
				filter =0; //filter값 초기화
			
				for (var i = 0; i < 5; i++) {
					if ($("#button" + i + "").hasClass("active")) {
					var int_val = Number($("#button" + i + "").val());
					filter+=int_val;
					}
				}
				
				sort = this.value; // 선택한 셀렉트 값 가져오기
				$("#item-list").empty(); // 기존 상품 호출 지우기
				isEnd = false; // 무한스크롤 초기화
				nowPage = 1; // 현재 페이지 1로 초기화
				getProduct(sort,filter); // sort값을 기준으로 상품 다시 가져오기
			});


			/* 스크롤 이벤트 */
			$(window).scroll(function(e) {
				if (isConnect) {
					return false;
				}
				
				let totalPage = "${pageData.totalPage}";
				if ($(window).height() + $(window).scrollTop() + 60 >= $(document).height()) {
					// 현재페이지 체크 후 다음 페이지를 요청하기 위해 페이지 변수 1 증가 후 실행
					if (totalPage <= nowPage) {
						isEnd = true;
					} else {
						nowPage++;
						getProduct(sort,filter);
						get_sort();
					}
				}
			})

			/** 화면 하단에 스크롤이 도달할 때 일어날 이벤트 정의 */
			let getProduct = function(sort,filter) {
				if (isEnd == true) {
					return;
				}
				
				isConnect = true;

				// Restful API에 GET 방식 요청
				$.get("${pageContext.request.contextPath}/Item_list", {
					"page" : nowPage,
					"sort" : sort,
					"cateno" : cateno,
					"filter":filter
				// GET 파라미터로 전송한다.
				}, function(json) {
					var source = $("#item_tmpl").html(); // 템플릿 코드 가져오기
					var template = Handlebars.compile(source); // 템플릿 코드 컴파일
					var result = template(json); // 템플릿 컴파일 결과물에 json 전달
					$("#item-list").append(result); // 최종 결과물을 #list 요소에 추가한다.

					// 현재 페이지 번호가 전체 페이지 수에 도달했다면 더 보기 버튼을 숨긴다.
					if (json.pageData.totalPage <= nowPage) {
						isEnd = true;
					}
				});
				
				isConnect = false;
			}

			/* 필터정렬 */

			/* 상품필터 */
			$(".btn-tag").click(function() {
				$(this).toggleClass('active');
			});

			/* 상품리스트형 */
			$(".btn-list").click(function() {
				$(".btn-list").not(this).removeClass('active');
				$(this).toggleClass('active');
				get_sort();
			});

		});
	</script>
</body>

</html>