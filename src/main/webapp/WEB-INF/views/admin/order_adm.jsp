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
				<option value='1'>10개씩보기</option>
				<option value="2">20개씩보기</option>
			</select>
			<select class="form-control" id="align-menu">
				<option value="lowprice">구매금액(낮음)</option>
				<option value="highprice">구매금액(높음)</option>
				<option value="">거래중</option>
				<option value="">거래완료</option>
				<option value="">반품요청(구매자)</option>
				<option value="">반품확인(판매자)</option>
				<option value="">환불승인</option>
			</select>
		</div>


		<table class="table table-hover">
			<thead>
				<tr>
					<th>
						<input id="all-check" type="checkbox">
					</th>
					<th class="text-center">번호</th>
					<th class="text-center">거래번호</th>
					<th class="text-center">구매금액</th>
					<th class="text-center">닉네임</th>
					<th class="text-center">일자</th>
					<th class="text-center">거래방법</th>
					<th class="text-center">거래상태</th>
					<th class="text-center">반품</th>
					<th class="text-center">환불</th>

				</tr>
			</thead>
			<tbody id="board_body">

              <c:forEach var="item" items="${output}" varStatus="status">

    					<c:url var="viewUrl" value="/item_list.cider?prodno=">
                          <c:param name="prodno" value="${item.prodno}" />                     
                       </c:url>
               <c:set var="num" value="${pageData.totalCount-pageData.listCount*(pageData.nowPage-1)-status.count+1}" /> 
			<tr>
			        
		        <td><input id="checkbox" type="checkbox" class="board board-group-item"/></td>
		        <td class="text-center board-group-item">${num}</td>
		        <td class="text-center board-group-item"><a href="${viewUrl}">${item.prodno}</a></td>
		        <td class="text-center board-group-item">${item.price}</td>
		        <td class="text-center board-group-item">${item.nickname}</td>
		        <td class="text-center board-group-item">${item.confirmdate}</td>
		        
		        <c:choose>
		        <c:when test="${item.how =='J'}">
		        <td class="text-center board-group-item">직거래</td></c:when>
		        <c:when test="${item.how =='T'}">
		        <td class="text-center board-group-item">택배</td>
		    	</c:when>
		    	</c:choose>
		    	
		    	<c:choose>
		    	<c:when test="${item.tradecon =='J'}">
		        <td class="text-center board-group-item">거래중</td></c:when>
		        <c:when test="${item.tradecon =='W'}">
		        <td class="text-center board-group-item">거래완료</td></c:when>
		        <c:when test="${item.tradecon =='S'}">
		        <td class="text-center board-group-item">거래정지</td></c:when>
		        <c:when test="${item.tradecon =='X'}">
		        <td class="text-center board-group-item">거래취소</td></c:when>		        
		        <c:when test="${item.tradecon =='A'}">
		        <td class="text-center board-group-item">정산중</td></c:when>		        
		        <c:when test="${item.tradecon =='C'}">
		        <td class="text-center board-group-item">정산완료</td></c:when>
				</c:choose>

				<c:choose>
		        <c:when test="${item.refund =='N'}">
		        <td class="text-center board-group-item">일반</td></c:when>
		        <c:when test="${item.tradecon =='J'}">
		        <td class="text-center board-group-item">반품중</td></c:when>	
		        <c:when test="${item.tradecon =='W'}">
		        <td class="text-center board-group-item">반품완료</td></c:when>	
		        </c:choose>
		        
		      <!-- 	<form id="refundConfirm" name="refundConfirm" action="${pageContext.request.contextPath}/admin/order">      	 -->	        
		        <td class="text-center board-group-item">
		        <input type="hidden" value="y"/>
		        <button class="btn btn-warning" type="submit" id="button_refund" >환불승인</button></td>
		 <!--   </form> -->
        		</tr>
        		</c:forEach>
			</tbody>
		</table>

		<div class="input-group">
			<div class="input-group-btn">
				<button class="btn btn-default" type="button">
					<span class="glyphicon glyphicon-search"></span>
				</button>
			</div>
			<input type="text" class="form-control" id="search_btn" placeholder="키워드를 입력하세요">
		</div>
	 <!-- 페이지네이션 -->
	<div class="clearfix text-center pagination">
        <ul class="pagination">
        	<%-- 이전 그룹에 대한 링크 --%>
        	<c:choose>
            	<%-- 이전 그룹으로 이동 가능하다면? --%>
                <c:when test="${pageData.prevPage > 0}">
                	<%-- 이동할 URL 생성 --%>
                    <c:url value="/mystore/${user.shopaddress}/review.cider" var="prevPageUrl">
                    	<c:param name="page" value="${pageData.prevPage}" />          
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
                  <c:url value="/mystore/${user.shopaddress}/review.cider" var="pageUrl">
                     <c:param name="page" value="${i}" />
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
                    <c:url value="/mystore/${user.shopaddress}/review.cider" var="nextPageUrl">
                    	<c:param name="page" value="${pageData.nextPage}" />          
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