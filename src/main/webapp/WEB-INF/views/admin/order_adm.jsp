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
			<tr>
		        <td><input id="checkbox" type="checkbox" class="board board-group-item"/></td>
		        <td class="text-center board-group-item">${item.bbsno}</td>
		        <td class="text-center board-group-item"><a href="{{url}}">${recono}</a></td>
		        <td class="text-center board-group-item">${amount}</td>
		        <td class="text-center board-group-item">${writer}</td>
		        <td class="text-center board-group-item">${date}</td>
		        <td class="text-center board-group-item">${delivery}</td>
		        <td class="text-center board-group-item">${status}</td>
		        <td class="text-center board-group-item">${payment}</td>
		        <td class="text-center board-group-item">
		        <button class="btn btn-danger" type="submit" id="button_refund" >${refund}</button></td>
        	</tr>
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
	 
	 <ul class="pagination">
                  <%-- 이전 그룹에 대한 링크 --%>
                     <c:choose>
                  <%-- 이전 그룹으로 이동 가능하다면? --%>
                  <c:when test="${pageData.prevPage > 0}">
                     <%-- 이동할 URL 생성 --%>
                     <c:url value="/admin/notice/list.cider" var="prevPageUrl">
                        <c:param name="page" value="${pageData.prevPage}" />
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
                  <c:url value="/admin/notice/list.cider" var="pageUrl">
                     <c:param name="page" value="${i}" />
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
                     <c:url value="/admin/notice/list.cider" var="nextPageUrl">
                        <c:param name="page" value="${pageData.nextPage}" />
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
        $(document).on('click','.btn-danger', function(e){
            e.preventDefault();                  
  
            var yes = confirm("환불승인 하시겠습니까?");
            if(yes==true) {
            var current_td = $(this).parent().prev().prev();
            current_td.html("환불완료");
            }else{
            	alert("취소하였습니다.")
          	}
            });
                
        $(function () {
           
        Handlebars.registerHelper('convertDisable', function(h) {
                var h = $("#status").attr()
            if (h == "반품확인(판매자") {
                return "value 값을 able로 변경 ";
            } else {
                return "직거래";
            }
        });

            // 추가기능------------------------------------------------------------
         //필터 


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

      // --------------------------------------------추가기능-------------------------------------

        
        // 버튼삭제이벤트
        $("#delete").click(function(e){
            e.preventDefault();
            swal({ 
            title: '확인',
            text: "정말 삭제 하시겠습니까?" ,
            type:'warning', //종류
            confirmButtonText:'네', //확인버튼 표시문구
            showCancelButton:true, //취소버튼 표시여부
            cancelButtonText:'아니오', //취소버튼 표시문구 
            }).then(function(result){
                if(result.value) {

                    if($("input").is(":checked") == true){ //체크된 요소가 있으면               
                    var i = $("input:checked").parents("tr");
                   i.remove();
                 }else {
	                	swal("삭제할 항목을 선택해주세요!")
    	        	}
              	}
            });
            
        });



    });

    </script>
</body>
</html>