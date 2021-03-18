<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>

<head>
<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
<title>상품관리 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/product_adm.css" />
</head>


<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-lg-2">
				<%@ include file="/WEB-INF/views/inc/product_adm_left.jsp"%>
			</div>

			<div class="col-lg-10">
				<div class="title-menu clearfix">
					<h4>상품목록</h4>
					<select class="form-control" id="align-number">
						<option value="10" <c:if test="${pageData.listCount==10}">selected</c:if>>10개씩보기</option>
						<option value="20" <c:if test="${pageData.listCount==20}">selected</c:if>>20개씩보기</option>
					</select>
					<select class="form-control" id="align-menu">
						<option value="default" <c:if test="${orderby=='default'}">selected</c:if>>기본정렬</option>
						<option value="payAsc" <c:if test="${orderby=='payAsc'}">selected</c:if>>구매액(낮음)</option>
						<option value="payDesc" <c:if test="${orderby=='payDesc'}">selected</c:if>>구매액(높음)</option>
						<option value="J" <c:if test="${orderby=='J'}">selected</c:if>>직거래</option>
						<option value="T" <c:if test="${orderby=='T'}">selected</c:if>>택배</option>
						<option value="tradeconJ" <c:if test="${orderby=='tradeconJ'}">selected</c:if>>판매중</option>
						<option value="tradeconW" <c:if test="${orderby=='tradeconW'}">selected</c:if>>판매완료</option>
					</select>
				</div>

				<table class="table table-hover">
					<thead>
						<tr>
							<th>
								<input id="all-check" type="checkbox">
							</th>
							<th class="text-center">번호</th>
							<th class="text-center">상품제목</th>
							<th class="text-center">카테고리</th>
							<th class="text-center">상품가격</th>
							<th class="text-center">거래방법</th>
							<th class="text-center">등록일</th>
							<th class="text-center">상태</th>
						</tr>
					</thead>


					<tbody id="board_body">
	 					<c:forEach var="item" items="${output}" varStatus="status">
							<c:url var="viewUrl" value="/item_index.cider">
								<c:param name="prodno" value="${item.prodno}" />
							</c:url>
							<c:set var="num" value="${pageData.totalCount-pageData.listCount*(pageData.nowPage-1)-status.count+1}" />
							
							
							<tr>
								<td class="text-center">
									<input type="checkbox" class="prod_chk" name="prodno" data-prodno="${item.prodno}" data-tradecon="${item.tradecon}" value="${item.prodno}">
								</td>
								<td class="text-center board-group-item">${num}</td>
								<td class="text-center board-group-item">
									<a href="${viewUrl}" target="_blank">${item.subject}</a>
								</td>
								<td class="text-center board-group-item">${item.catename}</td>
								<td class="text-center board-group-item">
									<fmt:formatNumber value="${item.price}" pattern="#,###" />
									원
								</td>
								<td class="text-center board-group-item">
								<c:choose>
									<c:when test="${item.how =='J'}">
										<span class="label label-info info-white">직거래</span>
									</c:when>
									<c:when test="${item.how =='T'}">
										<span class="label label-info info-white">택배</span>
									</c:when>
									<c:when test="${item.how =='X'}">
										<span class="label label-info info-white">상관없음</span>
									</c:when>
								</c:choose>
								</td>
								<td class="text-center board-group-item">${item.regdate}</td>

								<td class="text-center board-group-item">
								<c:choose>
									<c:when test="${item.tradecon =='J'}">
										<span class="label label-info">거래중</span>
									</c:when>
									<c:when test="${item.tradecon =='W'}">
										<span class="label label-success">거래완료</span>
									</c:when>
									<c:when test="${item.tradecon =='S'}">
										<span class="label label-danger">숨김</span>
									</c:when>
									<c:when test="${item.tradecon =='X'}">
										<span class="label label-warning">거래중지</span>
									</c:when>
								</c:choose>
								</td>

							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				
					<div class="input-group">
						<div class="input-group-btn">
							<button class="btn btn-default" type="submit" id="search_memb">
								<span class="glyphicon glyphicon-search"></span>
							</button>
						</div>
						<input type="search" class="form-control searchInput" name="keyword" id="keyword" placeholder="키워드를 입력하세요" value="${keyword}">
					</div>
					<button class="btn btn-danger" type="submit" id="delete">삭제</button>

					<button class="btn btn-primary" type="submit" id="re-start">거래재개</button>
					<input type="hidden" value="J" />

					<button class="btn btn-warning" type="submit" id="stop">거래정지</button>
					<input type="hidden" value="S" />
				
		
			</div>
		</div>

		<!-- 페이지네이션 -->
		<div class="clearfix text-center pagination">
			<ul class="pagination">
				<%-- 이전 그룹에 대한 링크 --%>
				<c:choose>
					<%-- 이전 그룹으로 이동 가능하다면? --%>
					<c:when test="${pageData.prevPage > 0}">
						<%-- 이동할 URL 생성 --%>
						<c:url value="/admin/product_adm.cider" var="prevPageUrl">
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
					<c:url value="/admin/product_adm.cider" var="pageUrl">
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
						<c:url value="/admin/product_adm.cider" var="nextPageUrl">
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



	<!--/row-->
	<hr>
	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>


	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
	<!-- 유효성검사 -->
	<script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
	<script type="text/javascript">

        $(function () {
        	
            //   n개씩 보기 드롭다운의 변경이벤트
    	    $("#align-number").change(function(){
                let listCount = $(this).val(); //사용자선택값 가져오기
                let orderby = "${orderby}";
                let keyword = "${keyword}";
                window.location = "${pageContext.request.contextPath}/admin/product_adm.cider?"+
                		"orderby="+orderby+"&listCount="+listCount+"&keyword="+keyword;
    	    });
            
    	    //   정렬 드롭다운의 변경이벤트
    	    $("#align-menu").change(function(){
                let orderby = $(this).val(); //사용자선택값 가져오기
                let listCount = "${pageData.listCount}";
                let keyword = "${keyword}";
                window.location = "${pageContext.request.contextPath}/admin/product_adm.cider?"+
                		"orderby="+orderby+"&listCount="+listCount+"&keyword="+keyword;
    	    });
       
     	    //   검색 입력의 이벤트
    	    $("#search_memb").click(function(){
                let keyword = $("#keyword").val(); //사용자선택값 가져오기
                let orderby = "${orderby}";
                let listCount = "${pageData.listCount}";
                window.location = "${pageContext.request.contextPath}/admin/product_adm.cider?"+
                		"orderby="+orderby+"&listCount="+listCount+"&keyword="+keyword;
    	    });
     	
        	/* 정렬하기 기능 value 값 가져오기 */   		
 
            //체크박스 전체선택
            $("#all-check").change(function () {
                $(".prod_chk").prop('checked', $(this).prop('checked'));
            });
            
            
			// 거래정지 눌렀을때
            $("#stop").click(function () {
            	var chkArray = new Array();
            	var chkTradecon = new Array();
            	$(".prod_chk:checked").each(function(){
            		var prodno = $(this).data('prodno');
            		chkArray.push(prodno);
            		var trade = $(this).data('tradecon');
            		chkTradecon.push(trade);
            	});
            	
    	        swal({ 
    		          title: '확인',
    		          text: "선택한 상품을 거래정지 시키시겠습니까?" ,
    		          type:'warning', //종류
    		          confirmButtonText:'네', //확인버튼 표시문구
    		          showCancelButton:true, //취소버튼 표시여부
    		          cancelButtonText:'아니오', //취소버튼 표시문구 
    		        }).then(function(result){
    		           if(result.value) {   //확인버튼이 눌러진 경우 
    		        	   $.put("${pageContext.request.contextPath}/adm/product",
    		        			   {"chkArray": chkArray,"chkTradecon": chkTradecon,"tradecon": "X"}, function(json){
    		              	  if(json.rt=="OK"){
     		              		swal('거래정지 완료', '거래정지 처리 되었습니다.', 'success').then(function(result){
    	 	 	              		//처리완료후 새로고침
    	 	 	              		window.location.reload();
    	 	              		});
    		              	  }
    		            });
    		           } else if(result.dismiss==='cancel') {  //취소버튼 눌러진경우 
    		             swal('취소', '취소하였습니다.', 'error');
    		           }
    		         });
            });		
			//거래 재개 눌렀을 때 
            $("#re-start").click(function () {
            	
            	var chkArray = new Array();
            	var chkTradecon = new Array();
            	$(".prod_chk:checked").each(function(){
            		var prodno = $(this).data('prodno');
            		chkArray.push(prodno);
            		var trade = $(this).data('tradecon');
            		chkTradecon.push(trade);
            	});
            	
    	        swal({ 
    		          title: '확인',
    		          text: "선택한 상품을 거래재개 시키시겠습니까?" ,
    		          type:'warning', //종류
    		          confirmButtonText:'네', //확인버튼 표시문구
    		          showCancelButton:true, //취소버튼 표시여부
    		          cancelButtonText:'아니오', //취소버튼 표시문구 
    		        }).then(function(result){
    		           if(result.value) {   //확인버튼이 눌러진 경우 
    		        	   $.put("${pageContext.request.contextPath}/adm/product",{
    		              	 "chkArray": chkArray,
    		              	 "chkTradecon": chkTradecon,
    		              	 "tradecon": "J"
    		                }, function(json){
    		              	  if(json.rt=="OK"){
     		              		swal('거래재개 완료', '거래재개 처리 되었습니다.', 'success').then(function(result){
    	 	 	              		//처리완료후 새로고침
    	 	 	              		window.location.reload();
    	 	              		});
    		              	  }
    		            });
    		           } else if(result.dismiss==='cancel') {  //취소버튼 눌러진경우 
    		             swal('취소', '취소하였습니다.', 'error');
    		           }
    		         });
            });
			
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
                      if($("input").is(":checked") == true) { //체크된 요소가 있으면               
                    	  let count = $("input[name='prodno']:checked").length;   // 갯수만큼 삭제 실행
                    	  let arr1 = new Array();	// 체크박스를 담을 배열 객체 생성
                    	  let arr2 = new Array();	// 체크박스를 담을 배열 객체 생성
                    	  $("input:checked").each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
                              arr1.push($(this).data('prodno'));
                              arr2.push($(this).data('tradecon'));
                          });
                    	  
                    	  $.ajaxSettings.traditional = true;  // Ajax로 배열을 넘겨줄 때 필요한 설정                                        	  
                          $.ajax({
    	          				type : 'DELETE',
    	          				url : '${pageContext.request.contextPath}/adm/product',
    	          				data : {"prodno" : arr1, "tradecon" : arr2, "count" : count},
    	          				success: function(json) {
    	    	      	              if (json.rt == "OK") {
    	    	      	                  alert("삭제되었습니다.");
    	    	      	                  // 삭제 완료 후 목록 페이지로 이동
    	    	      	                  window.location = "${pageContext.request.contextPath}/admin/product_adm.cider";
    	    	      	              }
    	          				}
              				});
                  	  	}
    	                  
                      } else {
                          swal("삭제할 항목을 선택해주세요!")
                     }
                   });
                });


        });
        
    </script>

</body>

</html>