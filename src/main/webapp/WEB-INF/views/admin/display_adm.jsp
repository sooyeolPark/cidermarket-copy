<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
<title>관리자 진열관리 - 사이다마켓</title>
<!-- 나눔고딕 웹 폰트 적용 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/display_adm.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header_footer_adm.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
	<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>


	<div class="container">
		<div class="row">
			<div class="col-lg-2">
				<nav class="list-group">
					<!-- 목록의 아이템 -->
					<p>상품관리</p>
					<a href="${pageContext.request.contextPath}/admin/product_adm.cider" class="list-group-item">
						<p>상품목록</p>
					</a>
					<a href="${pageContext.request.contextPath}/admin/category_adm.cider" class="list-group-item">
						<p>상품분류</p>
					</a>
					<a href="${pageContext.request.contextPath}/admin/display_adm.cider" class="list-group-item">
						<p>상품진열</p>
					</a>
					<a href="${pageContext.request.contextPath}/admin/singo_adm.cider" class="list-group-item">
						<p>
							신고상품<span class="badge"> 10</span>
						</p>
					</a>
				</nav>
			</div>
			<div class="col-lg-10">

				<div class="title-menu clearfix">
					<h4>상품진열</h4>
					<select class="form-control" id="align-number">
						<option value="10" <c:if test="${pageData.listCount==10}">selected</c:if>>10개씩보기</option>
						<option value="20" <c:if test="${pageData.listCount==20}">selected</c:if>>20개씩보기</option>
					</select>
					<select class="form-control" id="align-menu">
						<option value="regdate" <c:if test="${orderby=='regdate'}">selected</c:if>>최신순</option>
						<option value="subject" <c:if test="${orderby=='subject'}">selected</c:if>>가나다순</option>
					</select>
					<select class="form-control" id="align-category">
						<option value="0">- 카테고리순 -</option>
						<c:forEach var="cate" items="${cateList}">
							<option value="${cate.cateno}" <c:if test="${cate.cateno==category}">selected</c:if>>${cate.name}</option>
						</c:forEach>
					</select>
				</div>

				<table class="table table-hover">
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">상품제목</th>
							<th class="text-center">판매자</th>
							<th class="text-center">카테고리</th>
							<th class="text-center">수정</th>
						</tr>
					</thead>
					<tbody id="result">
						<!-- Ajax로 로드한 결과가 표시될 곳 -->
						<c:choose>
							<%-- 조회결과가 없는 경우 --%>
							<c:when test="${output == null || fn:length(output) == 0}">
								<td class="alert alert-success" role="alert" colspan="5">조회결과가 없습니다.</td>
							</c:when>
							<%-- 조회결과가 있는 경우 --%>
							<c:otherwise>
								<%-- 조회 결과에 따른 반복 처리 --%>
								<c:forEach var="item" items="${output}" varStatus="status">
									<%-- 출력을 위해 준비한 제목 변수 --%>
									<c:set var="title" value="${item.subject}" />

									<%-- 검색어가 있다면? --%>
									<c:if test="${keyword != ''}">
										<%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
										<c:set var="mark" value="<mark>${keyword}</mark>" />
										<%-- 출력을 위해 준비한 제목에 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
										<c:set var="title" value="${fn:replace(title, keyword, mark)}" />
									</c:if>

									<%-- 상세페이지로 이동하기 위한 URL --%>
									<c:url var="viewUrl" value="/item_index.cider">
										<c:param name="prodno" value="${item.prodno}" />
									</c:url>
									<%-- 글 번호 --%>
									<c:set var="num" value="${pageData.totalCount-pageData.listCount*(pageData.nowPage-1)-status.count+1}" />
									<tr>
										<td class="text-center board-group-item">${num}</td>
										<td class="text-center">
											<a href="${viewUrl}">${title}</a>
										</td>
										<td class="text-center board-group-item">${item.sellerNick}</td>
										<td class="text-center board-group-item">
											<select class="form-control cateSelected">
												<c:forEach var="cate" items="${cateList}">
													<option value="${cate.cateno}" <c:if test="${item.cateno == cate.cateno}">selected</c:if>>${cate.name}</option>
												</c:forEach>
											</select>
										</td>
										<td class="text-center board-group-item ">
											<button type="submit" class="btn btn-primary cateSave" data-prodno="${item.prodno}">저장</button>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>

				<form method="get" action="${pageContext.request.contextPath}/admin/display_adm.cider" id="searchBox_help">
					<div class="input-group">
						<div class="input-group-btn">
							<button class="btn btn-default" type="submit" id="search_memb">
								<span class="glyphicon glyphicon-search"></span>
							</button>
						</div>
						<input type="search" class="form-control" name="keyword" id="keyword" placeholder="키워드를 입력하세요" value="${keyword}">
					</div>
				</form>

				<!-- 페이지 번호 구현 -->
				<ul class="pagination">
					<%-- 이전 그룹에 대한 링크 --%>
					<c:choose>
						<%-- 이전 그룹으로 이동 가능하다면? --%>
						<c:when test="${pageData.prevPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/admin/display_adm.cider" var="prevPageUrl">
								<c:param name="page" value="${pageData.prevPage}" />
								<c:param name="orderby" value="${orderby}" />
								<c:param name="category" value="${category}" />
								<c:param name="keyword" value="${keyword}" />
								<c:param name="listCount" value="${pageData.listCount}" />
							</c:url>
							<li class="arr"><a href="${prevPageUrl}">&laquo;</a></li>
						</c:when>
						<c:otherwise>
							<li class="disabled"><a href="#">&laquo;</a></li>
						</c:otherwise>
					</c:choose>

					<%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
					<c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">
						<%-- 이동할 URL 생성 --%>
						<c:url value="/admin/display_adm.cider" var="pageUrl">
							<c:param name="page" value="${i}" />
							<c:param name="orderby" value="${orderby}" />
							<c:param name="category" value="${category}" />
							<c:param name="keyword" value="${keyword}" />
							<c:param name="listCount" value="${pageData.listCount}" />
						</c:url>

						<%-- 페이지 번호 출력 --%>
						<c:choose>
							<%-- 현재 머물고 있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
							<c:when test="${pageData.nowPage == i}">
								<li class="active"><span>${i} <span class="sr-only">(current)</span></span></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageUrl}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<%-- 다음 그룹에 대한 링크 --%>
					<c:choose>
						<%-- 다음 그룹으로 이동 가능하다면? --%>
						<c:when test="${pageData.nextPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/admin/display_adm.cider" var="nextPageUrl">
								<c:param name="page" value="${pageData.nextPage}" />
								<c:param name="orderby" value="${orderby}" />
								<c:param name="category" value="${category}" />
								<c:param name="keyword" value="${keyword}" />
								<c:param name="listCount" value="${pageData.listCount}" />
							</c:url>
							<li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
						</c:when>
						<c:otherwise>
							<li class="disabled"><a href="#">&raquo;</a></li>
						</c:otherwise>
					</c:choose>
				</ul>


			</div>
		</div>
	</div>


	<!-- footer -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<script type="text/javascript">
	
	
	
		$(function(){
			//   정렬 드롭다운의 변경이벤트
    	    $("#align-menu").change(function(){
                let orderby = $(this).val(); //사용자선택값 가져오기
                let listCount = "${pageData.listCount}";
				let category = "${category}";                
				let keyword = "${keyword}";
                window.location = "${pageContext.request.contextPath}/admin/display_adm.cider?"+
                		"orderby="+orderby+"&listCount="+listCount+"&category="+category+"&keyword="+keyword;
    	    });
        	
       		//   n개씩 보기 드롭다운의 변경이벤트
    	    $("#align-number").change(function(){
                let listCount = $(this).val(); //사용자선택값 가져오기
                let orderby = "${orderby}";
                let category = "${category}";
                let keyword = "${keyword}";
                window.location = "${pageContext.request.contextPath}/admin/display_adm.cider?"+
                		"orderby="+orderby+"&listCount="+listCount+"&category="+category+"&keyword="+keyword;
    	    });
       		
	    	//   카테고리순 보기 드롭다운의 변경이벤트
    	    $("#align-category").change(function(){
                let category = $(this).val();  //사용자선택값 가져오기
    	    	let listCount = "${pageData.listCount}";
                let orderby = "${orderby}";
                let keyword = "${keyword}";
                window.location = "${pageContext.request.contextPath}/admin/display_adm.cider?"+
                		"orderby="+orderby+"&listCount="+listCount+"&category="+category+"&keyword="+keyword;
    	    });
	    	
    		//   카테고리순 보기 드롭다운의 변경이벤트
    	    $("#search_memb").click(function(){
                let keyword = $('#keyword').val();  //사용자선택값 가져오기
    	    	let listCount = "${pageData.listCount}";
                let orderby = "${orderby}";
                let category = "${category}";
                window.location = "${pageContext.request.contextPath}/admin/display_adm.cider?"+
                		"orderby="+orderby+"&listCount="+listCount+"&category="+category+"&keyword="+keyword;
    	    });
			
			
		  /* 카테고리 수정	 */		
	      $('.cateSave').click(function() {	    	  
		      const prodno = $(this).data('prodno');
		      const cateno = $(this).parent().prev().children().children('.cateSelected option:selected').val();
	        swal({ 
	          title: '확인',
	          text: "저장 하시겠습니까?" ,
	          type:'warning', //종류
	          confirmButtonText:'네', //확인버튼 표시문구
	          showCancelButton:true, //취소버튼 표시여부
	          cancelButtonText:'아니오', //취소버튼 표시문구 
	        }).then(function(result){
	        	if(result.value) {   //확인버튼이 눌러진 경우 
	 	        	   $.put("${pageContext.request.contextPath}/admin/display_adm",{
	 	              	 "prodno": prodno, "cateno":cateno
	 	                }, function(json){
	 	              	  if(json.rt=="OK"){ swal('수정 완료', '카테고리가 변경 되었습니다.', 'success') }
	 	                });
	        	} else if(result.dismiss==='cancel') {  //취소버튼 눌러진경우 
	 	             swal('취소', '취소하였습니다.', 'error');
 	            }
            });
	 	           
        });
     });
    </script>

</body>

</html>