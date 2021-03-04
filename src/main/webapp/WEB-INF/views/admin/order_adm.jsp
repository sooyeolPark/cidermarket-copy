<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>관리자 주문관리 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/order_adm.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header_footer_adm.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>

	<div class="container">
		<div class="title-menu clearfix">
			<h2>전체주문 조회</h2>
			<select class="form-control" id="align-number">
				<option value="10" <c:if test="${pageData.listCount==10}">selected</c:if>>10개씩보기</option>
				<option value="20" <c:if test="${pageData.listCount==20}">selected</c:if>>20개씩보기</option>
			</select>
			<select class="form-control" id="align-menu">
				<option value="default" <c:if test="${orderby=='default'}">selected</c:if>>기본정렬</option>
				<option value="payAsc" <c:if test="${orderby=='payAsc'}">selected</c:if>>구매액(낮음)</option>
				<option value="payDesc" <c:if test="${orderby=='payDesc'}">selected</c:if>>구매액(높음)</option>
				<option value="J" <c:if test="${orderby=='J'}">selected</c:if>>거래중</option>
				<option value="W" <c:if test="${orderby=='W'}">selected</c:if>>거래완료</option>				
			</select>
		</div>


		<table class="table table-hover">
			<thead>
				<tr>
<!-- 					<th>
						<input id="all-check" type="checkbox">
					</th> -->
					<th class="text-center">번호</th>
					<th class="text-center">거래번호</th>
					<th class="text-center">구매금액</th>
					<th class="text-center">닉네임</th>
					<th class="text-center">일자</th>
					<th class="text-center">거래방법</th>
					<th class="text-center">거래상태</th>
					<th class="text-center">반품</th>
				

				</tr>
			</thead>
			<tbody id="board_body">

              <c:forEach var="item" items="${output}" varStatus="status">

    					<c:url var="viewUrl" value="/item_index.cider">
                          <c:param name="prodno" value="${item.prodno}" />                     
                       </c:url>
               <c:set var="num" value="${pageData.totalCount-pageData.listCount*(pageData.nowPage-1)-status.count+1}" /> 
			<tr>
			        
				<!--<td><input id="checkbox" type="checkbox" class="board board-group-item"/></td>-->		    
				<td class="text-center board-group-item">${num}</td>
		        <td class="text-center board-group-item"><a href="${viewUrl}">${item.prodno}</a></td>
		        <td class="text-center board-group-item"><fmt:formatNumber value="${item.price}" pattern="#,###" />원</td>
		        <td class="text-center board-group-item">${item.sellerNick}</td>
		        <td class="text-center board-group-item">${item.regdate}</td>
		        
		        <c:choose>
		        <c:when test="${item.how =='J'}">
		        <td class="text-center board-group-item"><span class="label label-info info-white">직거래</span></td></c:when>
		        <c:when test="${item.how =='T'}">
		        <td class="text-center board-group-item"><span class="label label-info info-white">택배</span></td>
		    	</c:when>
		        <c:when test="${item.how =='X'}">
		        <td class="text-center board-group-item"><span class="label label-info info-white">상관없음</span></td>
		    	</c:when>		    	
		    	</c:choose>
		    	
		    	<c:choose>
		    	<c:when test="${item.tradecon =='J'}">
		        <td class="text-center board-group-item"><span class="label label-info">거래중</span></td></c:when>
		        <c:when test="${item.tradecon =='W'}">
		        <td class="text-center board-group-item"><span class="label label-success">거래완료</span></td></c:when>
		        <c:when test="${item.tradecon =='S'}">
		        <td class="text-center board-group-item"><span class="label label-danger">거래정지</span></td></c:when>
		        <c:when test="${item.tradecon =='X'}">
		        <td class="text-center board-group-item"><span class="label label-warning">거래취소</span></td></c:when>		        
		        <c:when test="${item.tradecon =='A'}">
		        <td class="text-center board-group-item"><span class="label label-success">정산중</span></td></c:when>		        
		        <c:when test="${item.tradecon =='C'}">
		        <td class="text-center board-group-item"><span class="label label-success">정산완료</span></td></c:when>
				</c:choose>

				<c:choose>
		        <c:when test="${item.refund =='N'}">
		        <td class="text-center board-group-item"><span class="label label-info info-white">일반</span></td></c:when>
		        <c:when test="${item.refund =='J'}">
		        <td class="text-center board-group-item"><span class="label label-danger">반품중</span></td></c:when>	
		        <c:when test="${item.refund =='W'}">
		        <td class="text-center board-group-item"><span class="label label-danger">반품완료</span></td></c:when>	
		        </c:choose>
        	</tr>
        	</c:forEach>
			</tbody>
		</table>

		<div class="input-group">
			<div class="input-group-btn">
				<button class="btn btn-default" type="button" id="search_prod">
					<span class="glyphicon glyphicon-search"></span>
				</button>
			</div>
			<input type="text" class="form-control searchInput" id="keyword" placeholder="키워드를 입력하세요" value="${keyword}">
		</div>
	 <!-- 페이지네이션 -->
	<div class="clearfix text-center pagination">
        <ul class="pagination">
        	<%-- 이전 그룹에 대한 링크 --%>
        	<c:choose>
            	<%-- 이전 그룹으로 이동 가능하다면? --%>
                <c:when test="${pageData.prevPage > 0}">
                	<%-- 이동할 URL 생성 --%>
                    <c:url value="/admin/order_adm.cider/" var="prevPageUrl">
                    	<c:param name="page" value="${pageData.prevPage}" />
                 		<c:param name="orderby" value="${orderby}" />          
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
                  <c:url value="/admin/order_adm.cider/" var="pageUrl">
                     <c:param name="page" value="${i}" />
                 		<c:param name="orderby" value="${orderby}" />          
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
          
          	<%-- 이전 그룹에 대한 링크 --%>
        	<c:choose>
            	<%-- 다음 그룹으로 이동 가능하다면? --%>
                <c:when test="${pageData.nextPage > 0}">
                	<%-- 이동할 URL 생성 --%>
                    <c:url value="/admin/order_adm.cider/" var="nextPageUrl">
                    	<c:param name="page" value="${pageData.nextPage}" />
                  		<c:param name="orderby" value="${orderby}" />          
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

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
    <!-- 유효성검사 -->
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
    <script type="text/javascript">
   
    $(function(){
    	
        //   n개씩 보기 드롭다운의 변경이벤트
	    $("#align-number").change(function(){
            let listCount = $(this).val(); //사용자선택값 가져오기
            let orderby = "${orderby}";
            let keyword = "${keyword}";
            window.location = "${pageContext.request.contextPath}/admin/order_adm.cider?"+
            		"orderby="+orderby+"&listCount="+listCount+"&keyword="+keyword;
	    });
        
	    //   정렬 드롭다운의 변경이벤트
	    $("#align-menu").change(function(){
            let orderby = $(this).val(); //사용자선택값 가져오기
            let listCount = "${pageData.listCount}";
            let keyword = "${keyword}";
            window.location = "${pageContext.request.contextPath}/admin/order_adm.cider?"+
            		"orderby="+orderby+"&listCount="+listCount+"&keyword="+keyword;
	    });
   
 	    //   검색 입력의 이벤트
	    $("#search_prod").click(function(){
            let keyword = $("#keyword").val(); //사용자선택값 가져오기
            let orderby = "${orderby}";
            let listCount = "${pageData.listCount}";
            window.location = "${pageContext.request.contextPath}/admin/order_adm.cider?"+
            		"orderby="+orderby+"&listCount="+listCount+"&keyword="+keyword;
	    });
    	
 /*        // 드롭다운의 변경이벤트
        $("#align-number").change(function(){
            var choice=$(this).find("option:selected").val(); //사용자선택값 가져오기
            location.href='${pageContext.request.contextPath}/admin/order_adm.cider?page=${pageData.nowPage}&keyword=${keyword}&listCount='+choice;
        }); */
 
        // 로그아웃
        $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('login_adm.html'); 
                }else{

                }
            });
    //   전체선택
      $("#all-check").change(function(){
          $(".board").prop('checked',$(this).prop('checked'));
      });
    

});
    
    

    </script>
</body>
</html>