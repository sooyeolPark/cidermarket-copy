<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
<title>회원관리 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/member_adm.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-lg-2">
				<nav class="list-group">
					<!-- 목록의 아이템 -->
					<p>회원관리</p>
					<a href="${pageContext.request.contextPath}/admin/member_adm.cider" class="list-group-item">
						<p>회원정보조회</p>
					</a>
					<a href="${pageContext.request.contextPath}/admin/outmember_adm.cider" class="list-group-item">
						<p>탈퇴회원관리</p>
					</a>
				</nav>


			</div>
			<div class="col-lg-10">

				<div class="title-menu clearfix">
					<h4>회원정보조회</h4>
					<select class="form-control" id="align-number">
						<option value="10" <c:if test="${pageData.listCount==10}">selected</c:if>>10개씩보기</option>
						<option value="20" <c:if test="${pageData.listCount==20}">selected</c:if>>20개씩보기</option>
					</select>
					<select class="form-control" id="align-menu">
						<option value="default" <c:if test="${orderby=='default'}">selected</c:if>>기본정렬</option>
						<option value="amountAsc" <c:if test="${orderby=='amountAsc'}">selected</c:if>>구매건(낮음)</option>
						<option value="amountDesc" <c:if test="${orderby=='amountDesc'}">selected</c:if>>구매건(높음)</option>
						<option value="payAsc" <c:if test="${orderby=='payAsc'}">selected</c:if>>구매액(낮음)</option>
						<option value="payDesc" <c:if test="${orderby=='payDesc'}">selected</c:if>>구매액(높음)</option>
						<option value="joinDesc" <c:if test="${orderby=='joinDesc'}">selected</c:if>>가입일순(최근)</option>
						<option value="joinAsc" <c:if test="${orderby=='joinAsc'}">selected</c:if>>가입일순(오래됨)</option>
						<option value="rateDesc" <c:if test="${orderby=='rateDesc'}">selected</c:if>>별점순(높음)</option>
						<option value="rateAsc" <c:if test="${orderby=='rateAsc'}">selected</c:if>>별점순(낮음)</option>
					</select>
				</div>


				<table class="table table-hover">
					<thead>
						<tr>
							<th class="text-center"></th>
							<th class="text-center">번호</th>
							<th class="text-center">이메일</th>
							<th class="text-center">닉네임</th>
							<th class="text-center">구매금액</th>
							<th class="text-center">구매건수</th>
							<th class="text-center">연락처</th>
							<th class="text-center">가입일</th>
							<th class="text-center">별점</th>
							<th class="text-center">탈퇴처리</th>

						</tr>
					</thead>
					<tbody id="board_body">
					<c:forEach var="item" items="${output}" varStatus="status">
					    <%-- 출력을 위해 준비한 email, nickname 변수 --%>
                        <c:set var="email" value="${item.email}" />
                        <c:set var="nickname" value="${item.nickname}" />
                        
                        <%-- 검색어가 있다면? --%>
                        <c:if test="${search != ''}">
                            <%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
                            <c:set var="mark" value="<mark>${search}</mark>" />
                            <%-- 출력을 위해 준비한 email과 nickname에서 에서 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
                            <c:set var="email" value="${fn:replace(email, search, mark)}" />
                            <c:set var="nickname" value="${fn:replace(nickname, search, mark)}" />
                        </c:if>
                        
                        <!-- 넘버링 -->
                    	<c:set var="num" value="${pageData.totalCount-pageData.listCount*(pageData.nowPage-1)-status.count+1}" />
   						 	<tr>
        						<td class="text-center board-group-item"></td>
        						<td class="text-center board-group-item">${num}</td>
        						<td class="text-center board-group-item">${email}</td>
							    <td class="text-center board-group-item">${nickname}</td>
							    <td class="text-center board-group-item">${item.totalpay}</td>
							    <td class="text-center board-group-item">${item.totalamount}</td>
							    <td class="text-center board-group-item">${item.tel}</td>
							    <td class="text-center board-group-item">${item.joindate }</td>
							    <td class="text-center board-group-item">${item.rate}</td>
							    <td class="text-center board-group-item">
			<button type="submit" class="btn btn-warning outmember" data-membno="${item.membno}">탈퇴</button>
        </td>
        </tr>
                    </c:forEach>
					</tbody>

				</table>
				<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-default" type="button" id="search_memb">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</div>
					<input type="text" class="form-control searchInput" id="search_btn" placeholder="키워드를 입력하세요" value="${search}">

				</div>
				
				<!-- 페이지 번호 구현 -->
				<ul class="pagination">
					<%-- 이전 그룹에 대한 링크 --%>
        	<c:choose>
            	<%-- 이전 그룹으로 이동 가능하다면? --%>
                <c:when test="${pageData.prevPage > 0}">
                	<%-- 이동할 URL 생성 --%>
                    <c:url value="/admin/member_adm.cider" var="prevPageUrl">
                    	<c:param name="page" value="${pageData.prevPage}" />          
                    	<c:param name="orderby" value="${orderby}" />          
                    	<c:param name="search" value="${search}" />          
                    	<c:param name="listCount" value="${pageData.listCount}" />          
                    </c:url>
                    <li><a href="${prevPageUrl}">&laquo;</a></li>
                </c:when>
                <c:otherwise>
                	<li class="disabled"><a href="#">&laquo;</a></li>
                </c:otherwise>
            </c:choose>
            
            <%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
               <c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">
                  <%-- 이동할 URL 생성 --%>
                  <c:url value="/admin/member_adm.cider" var="pageUrl">
                     <c:param name="page" value="${i}" />
                     <c:param name="orderby" value="${orderby}" />          
                     <c:param name="search" value="${search}" />          
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
          
          	<%-- 이전 그룹에 대한 링크 --%>
        	<c:choose>
            	<%-- 다음 그룹으로 이동 가능하다면? --%>
                <c:when test="${pageData.nextPage > 0}">
                	<%-- 이동할 URL 생성 --%>
                    <c:url value="/admin/member_adm.cider" var="nextPageUrl">
                    	<c:param name="page" value="${pageData.nextPage}" />          
                    	<c:param name="orderby" value="${orderby}" />          
                    	<c:param name="search" value="${search}" />          
                    	<c:param name="listCount" value="${pageData.listCount}" />
                    </c:url>
                    <li><a href="${nextPageUrl}">&raquo;</a></li>
                </c:when>
                <c:otherwise>
                	<li class="disabled"><a href="#">&raquo;</a></li>
                </c:otherwise>
            </c:choose>
				</ul>
			</div>
		</div>
	</div>

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<!-- 유효성검사 -->
	<script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>

	<script type="text/javascript">
        $(function () {
       //   정렬 드롭다운의 변경이벤트
    	    $("#align-menu").change(function(){
                let orderby = $(this).val(); //사용자선택값 가져오기
                let listCount = "${pageData.listCount}";
                let search = "${search}";
                window.location = "${pageContext.request.contextPath}/admin/member_adm.cider?"+
                		"orderby="+orderby+"&listCount="+listCount+"&search="+search;
    	    });
        	
       //   n개씩 보기 드롭다운의 변경이벤트
    	    $("#align-number").change(function(){
                let listCount = $(this).val(); //사용자선택값 가져오기
                let orderby = "${orderby}";
                let search = "${search}";
                window.location = "${pageContext.request.contextPath}/admin/member_adm.cider?"+
                		"orderby="+orderby+"&listCount="+listCount+"&search="+search;
    	    });
       
     	//   검색 드롭다운의 변경이벤트
    	    $("#search_memb").click(function(){
                let search = $("#search_btn").val(); //사용자선택값 가져오기
                let listCount = "${pageData.listCount}";
                let orderby = "${orderby}";
                window.location = "${pageContext.request.contextPath}/admin/member_adm.cider?"+
                		"orderby="+orderby+"&listCount="+listCount+"&search="+search;
    	    });
        	
	
	      $(".outmember").click(function () {
	    	  let membno = $(this).data("membno");
	        swal({ 
	          title: '확인',
	          text: "정말 탈퇴 시키시겠습니까?" ,
	          type:'warning', //종류
	          confirmButtonText:'네', //확인버튼 표시문구
	          showCancelButton:true, //취소버튼 표시여부
	          cancelButtonText:'아니오', //취소버튼 표시문구 
	        }).then(function(result){
	           if(result.value) {   //확인버튼이 눌러진 경우 
	        	   $.put("${pageContext.request.contextPath}/admin/member_adm",{
	              	 "membno": membno
	                }, function(json){
	              	  if(json.rt=="OK"){
	              		swal('탈퇴 완료', '탈퇴처리 되었습니다.', 'success').then(function(result){
 	 	              		//탈퇴처리완료후 새로고침
 	 	              		window.location.reload();
 	              		});
	              	  }
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