<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>

<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>신고게시판 - 사이다마켓</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/singo_adm.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header&footer_adm.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.23/datatables.min.css"/>
    <!-- 반응형 웹을 지원하지 않을 경우 -->
    <!-- <link rel="stylesheet" href="assets/css/non-responsive.css" /> -->
    <!-- IE8 이하 버전 지원 -->
    <!--[if lt IE 9]>
<script type="text/javascript" src="assets/js/html5shiv.js"></script>
<script type="text/javascript" src="assets/js/respond.min.js"></script>
<![endif]-->
    <!-- IE10 반응형 웹 버그 보완 -->
    <!--[if gt IE 9]>
<link rel="stylesheet" type="text/css" href="assets/css/ie10.css" />
<script type="text/javascript" src="assets/js/ie10.js"></script>
<![endif]-->
</head>

<body>
    <!-- 헤더 영역 -->
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
                        <p>신고상품<span class="badge"> 10</span></p>
                    </a>

                </nav>


            </div>
            <div class="col-lg-10">

                <div class="title-menu clearfix">
                    <h4>신고상품</h4>
                    <select class="form-control" id="align-number">
                        <option value="10" <c:if test="${pageData.listCount==10}">selected</c:if>>10개씩보기</option>
                        <option value="20" <c:if test="${pageData.listCount==20}">selected</c:if>>20개씩보기</option>
                    </select>
                    <select class="form-control" id="align-type">
                        <option value ="A" <c:if test="${type=='A'}">selected</c:if>>신고사유</option>
                        <option value ="P" <c:if test="${type=='P'}">selected</c:if>>판매금지 품목이에요</option>
            			<option value ="G" <c:if test="${type=='G'}">selected</c:if>>거래 게시글이 아니에요</option>
            			<option value ="S" <c:if test="${type=='S'}">selected</c:if>>사기글 같아요</option>
            			<option value ="E" <c:if test="${type=='E'}">selected</c:if>>기타 사유</option>
                    </select>
                    <select class="form-control" id="align-order">
                        <option value="desc" <c:if test="${orderby=='desc'}">selected</c:if>>작성일순(최신)</option>
                        <option value="asc" <c:if test="${orderby=='asc'}">selected</c:if>>작성일순(오래됨)</option>
                    </select>
                </div>

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input id="all-check" type="checkbox"></th>
                            <th class="text-center">번호</th>
                            <th class="text-center">상품번호</th>
                            <th class="text-center">내용</th>
                            <th class="text-center">작성자</th>
                            <th class="text-center">신고사유</th>
                            <th class="text-center">작성일</th>
                            <th class="text-center">상태</th>
                        </tr>
                    </thead>
                    <tbody id="board_body">
                    <c:forEach var="item" items="${output}" varStatus="status">
                    	<!-- 넘버링 -->
                    	<c:set var="num" value="${pageData.totalCount-pageData.listCount*(pageData.nowPage-1)-status.count+1}" />
                    	<%-- 출력을 위해 준비한 email, nickname 변수 --%>
                        <c:set var="prodno" value="${item.prodno}" />
                        <c:set var="nickname" value="${item.nickname}" />
                        
                        <%-- 검색어가 있다면? --%>
                        <c:if test="${search != ''}">
                            <%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
                            <c:set var="mark" value="<mark>${search}</mark>" />
                            <%-- 출력을 위해 준비한 email과 nickname에서 에서 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
                            <c:set var="prodno" value="${fn:replace(prodno, search, mark)}" />
                            <c:set var="nickname" value="${fn:replace(nickname, search, mark)}" />
                        </c:if>
						<tr>
							<td class="text-center"><input type="checkbox" class="prod_chk" name="prodno" 
							data-prodno="${item.prodno}"  data-tradecon="${item.tradecon}" value="${item.singono}"></td>
							<td class="text-center">${num}</td>
							<td class="text-center"><a href="${pageContext.request.contextPath}/item_index.cider?prodno=${item.prodno}">
							${prodno}</a></td>
                            <td class="text-center clk_tr">${item.content}</td>
                            <td class="text-center">${nickname}</td>
                            <td class="text-center">
                            <c:choose>
                            	<c:when test="${item.type=='P'}">
                            	판매금지 품목이에요
                            	</c:when>
                            	<c:when test="${item.type=='G'}">
                            	거래 게시글이 아니에요
                            	</c:when>
                            	<c:when test="${item.type=='S'}">
                            	사기글 같아요
                            	</c:when>
                            	<c:when test="${item.type=='E'}">
                            	기타 사유
                            	</c:when>
                            </c:choose>
							</td>
                            <td class="text-center">${item.regdate}</td>
                            <td class="text-center">
                            <c:choose>
                            	<c:when test="${item.tradecon=='W'}">
                            	<font color="green">거래 완료</font>
                            	</c:when>
                            	<c:when test="${item.tradecon=='S'}">
                            	<font color="gray"><b>숨김</b></font>
                            	</c:when>
                            	<c:when test="${item.tradecon=='X'}">
                            	<font color="red"><b>거래 정지</b></font>
                            	</c:when>
                            	<c:otherwise>
                            	거래중
                            	</c:otherwise>
                            </c:choose>                            
                            </td>
						</tr>
						<tr class="singo_content">
							<td colspan="3"></td>
      						<td colspan="5">
        						${item.content}        						           
      						</td>
    					</tr>
    				</c:forEach>
                    </tbody>
                </table>
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="button" id="search_item"><span
                                class="glyphicon glyphicon-search"></span></button>
                    </div>
                    <input type="text" class="form-control" id="search_btn" placeholder="작성자나 상품 번호로 검색하세요." value="${search}">
                    <button class="btn btn-danger" type="button" id="delete">신고글 삭제</button>
                    <button class="btn btn-primary" type="button" id="re-start">거래 재개</button>
                    <button class="btn btn-warning" type="button" id="stop">거래 정지</button>
                </div>

                <ul class="pagination">
				<%-- 이전 그룹에 대한 링크 --%>
        		<c:choose>
            		<%-- 이전 그룹으로 이동 가능하다면? --%>
                	<c:when test="${pageData.prevPage > 0}">
                		<%-- 이동할 URL 생성 --%>
                    	<c:url value="/admin/singo_adm.cider" var="prevPageUrl">
                    		<c:param name="page" value="${pageData.prevPage}" />          
                    		<c:param name="orderby" value="${orderby}" />          
                    		<c:param name="search" value="${search}" />          
                    		<c:param name="type" value="${type}" />          
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
                  <c:url value="/admin/singo_adm.cider" var="pageUrl">
                    <c:param name="page" value="${i}" />
                    <c:param name="orderby" value="${orderby}" />          
                    <c:param name="search" value="${search}" />          
                    <c:param name="type" value="${type}" />          
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
                    <c:url value="/admin/singo_adm.cider" var="nextPageUrl">
                    	<c:param name="page" value="${pageData.nextPage}" />          
                    	<c:param name="orderby" value="${orderby}" />          
                    	<c:param name="search" value="${search}" />
                    	<c:param name="type" value="${type}" />          
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

    <!--/.container-->
    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
    <!-- 유효성검사 -->
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.23/datatables.min.js"></script>

    <!-- //게시판 -->
    <script id="board_tmpl2" type="x-handlebars-template">
    </script>
    <script type="text/javascript">
                $(function () {
               //   정렬 드롭다운의 변경이벤트
            	    $("#align-type").change(function(){
                        let type = $(this).val(); //사용자선택값 가져오기
                        let orderby = "${orderby}"
                        let listCount = "${pageData.listCount}";
                        let search = "${search}";
                        window.location = "${pageContext.request.contextPath}/admin/singo_adm.cider?"+
                        		"orderby="+orderby+"&listCount="+listCount+"&search="+search+"&type="+type;
            	    });
                	
               //   n개씩 보기 드롭다운의 변경이벤트
            	    $("#align-number").change(function(){
                        let type = "${type}"; //사용자선택값 가져오기
                        let orderby = "${orderby}"
                        let listCount = $(this).val();
                        let search = "${search}";
                        window.location = "${pageContext.request.contextPath}/admin/singo_adm.cider?"+
                        		"orderby="+orderby+"&listCount="+listCount+"&search="+search+"&type="+type;
            	    });             
               
               //   날짜정렬 드롭다운의 변경이벤트
            	    $("#align-order").change(function(){
                        let type = "${type}"; //사용자선택값 가져오기
                        let orderby = $(this).val();
                        let listCount = "${pageData.listCount}";
                        let search = "${search}";
                        window.location = "${pageContext.request.contextPath}/admin/singo_adm.cider?"+
                        		"orderby="+orderby+"&listCount="+listCount+"&search="+search+"&type="+type;
            	    });
               
             	//   검색 입력의 이벤트
            	    $("#search_item").click(function(){
                        let search = $("#search_btn").val(); //사용자선택값 가져오기
                        let type = "${type}";
                        let orderby = "${orderby}";
                        let listCount = "${pageData.listCount}";
                        window.location = "${pageContext.request.contextPath}/admin/singo_adm.cider?"+
                        		"orderby="+orderby+"&listCount="+listCount+"&search="+search+"&type="+type;
            	    });
             	
             		//내용 누르면 상세내용 나오기 
                    $(".clk_tr").click(function (e) {
                        e.preventDefault();
                        $(this).parents("tr").next().slideToggle(200);
                        $(".singo_content").not($(this).parents("tr").next()).css('display', 'none');       
                    });
                    
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
            		        	   $.put("${pageContext.request.contextPath}/admin/singo_adm_update",{
            		              	 "chkArray": chkArray,
            		              	 "chkTradecon": chkTradecon,
            		              	 "tradecon": "X"
            		                }, function(json){
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
            		        	   $.put("${pageContext.request.contextPath}/admin/singo_adm_update",{
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
					
					//삭제처리
                    $("#delete").click(function () {
                    	
                    	var chkArray = new Array();
                    	
                    	$(".prod_chk:checked").each(function(){
                    		chkArray.push(this.value);
                    	});
                    	
            	        swal({ 
            		          title: '확인',
            		          text: "선택한 신고글을 삭제 시키시겠습니까?" ,
            		          type:'warning', //종류
            		          confirmButtonText:'네', //확인버튼 표시문구
            		          showCancelButton:true, //취소버튼 표시여부
            		          cancelButtonText:'아니오', //취소버튼 표시문구 
            		        }).then(function(result){
            		           if(result.value) {   //확인버튼이 눌러진 경우 
            		        	   $.delete("${pageContext.request.contextPath}/admin/singo_adm_delete",{
            		              	 "chkArray": chkArray,
            		                }, function(json){
            		              	  if(json.rt=="OK"){
	         		              		swal('삭제 완료', '신고글 삭제가 완료 되었습니다.', 'success').then(function(result){
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



});


    </script>

</body>

</html>