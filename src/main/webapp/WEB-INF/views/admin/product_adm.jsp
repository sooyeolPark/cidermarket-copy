<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html>

<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>상품관리 - 사이다마켓</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/product_adm.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header&footer_adm.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.23/datatables.min.css"/>

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
                        <a href="${pageContext.request.contextPath}/assets/admin/product_adm.cider" class="list-group-item">
                            <p>상품목록</p>
                        </a>
                        <a href="${pageContext.request.contextPath}/assets/admin/category_adm.cider" class="list-group-item">
                            <p>상품분류</p>
                        </a>
                        <a href="${pageContext.request.contextPath}/assets/admin/display_adm.cider" class="list-group-item">
                            <p>상품진열</p>
                        </a>
                        <a href="${pageContext.request.contextPath}/assets/admin/singo_adm.cider" class="list-group-item">
                            <p>신고상품<span class="badge"> 10</span></p>
                        </a>
                   
                </nav>


            </div>
            
            <form id="restfulProduct" name="restfulProduct" action="${pageContext.request.contextPath}/adm/product">
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
							<option value="J" <c:if test="${orderby==''}">selected</c:if>>직거래</option>
							<option value="W" <c:if test="${orderby==''}">selected</c:if>>택배</option>
							<option value="editAsc" <c:if test="${orderby=='editAsc'}">selected</c:if>>반품완료</option>
						</select>                    
                    <select class="form-control" id="align-menu">
                        <option value="">기본정렬</option>
                        <option value="">상품명순</option>
                        <option value="">등록일순</option>
                        <option value="">거래정지순</option>

                    </select>
                </div>

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input type="checkbox"></th>
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
							    <td><input type="checkbox" class="board-group-item" value="${item.prodno }"></td>
							    <td class="text-center board-group-item">${num}</td>							    
							    <td class="text-center board-group-item"><a href="${viewUrl}">${item.subject}</a></td>
							    <td class="text-center board-group-item">{item.name}</td>
		      					<td class="text-center board-group-item"><fmt:formatNumber value="${item.price}" pattern="#,###" />원</td>
						        <c:choose>
						        <c:when test="${item.how =='J'}">
						        <td class="text-center board-group-item">직거래</td></c:when>
						        <c:when test="${item.how =='T'}">
						        <td class="text-center board-group-item">택배</td>
						    	</c:when>
						    	</c:choose>							    
	       					    <td class="text-center board-group-item">${item.regdate}</td>							    
								
						    	<c:choose>
						    	<c:when test="${item.tradecon =='J'}">
						        <td class="text-center board-group-item">거래중</td></c:when>
						        <c:when test="${item.tradecon =='W'}">
						        <td class="text-center board-group-item">거래완료</td></c:when>
								</c:choose>					    
							   
							</tr>
							</c:forEach>    		              	
                        </tbody>
                       
		                </table>
		                <div class="input-group">
		                    <div class="input-group-btn">
		                        <button class="btn btn-default" type="button"><span
		                                class="glyphicon glyphicon-search"></span></button>
		                    </div>
		                    <input type="text" class="form-control" id="search_btn" placeholder="키워드를 입력하세요">

		                    <button class="btn btn-danger" type="submit" id="delete">삭제</button>
		
		                    <button class="btn btn-primary" type="submit" id="re-start">거래재개</button>
		                    <input type="hidden" value="J"/>

		                    <button class="btn btn-warning" type="submit" id= "stop">거래정지</button>
		                	<input type="hidden" value="S"/>
 
		                </div>
		            </div>
		   			</form>
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
                    	<c:param name="search" value="${search}" />          
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
                    <c:url value="/admin/order_adm.cider/" var="nextPageUrl">
                    	<c:param name="page" value="${pageData.nextPage}" />
                  		<c:param name="orderby" value="${orderby}" />          
                    	<c:param name="search" value="${search}" />          
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
  <!-- handlebar plugin -->
  <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
  <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <script type="text/javascript">

        $(function () {
            get_list();
            $("thead input").change(function(){
                var chk = $(this).prop('checked');
                $("tbody input").prop('checked', chk);
            });
            $("#delete").click(function(e){
                e.preventDefault();
                var is_ok = confirm("선택하신 게시글을 삭제하시겠습니까?");
                if (is_ok) {
                    if($("input").is(":checked") == true){ //체크된 요소가 있으면               
                        var i = $("input:checked").parents("tr");
                       i.remove();
                    
                    }else {
                    alert("삭제할 항목을 선택해주세요!")

                    }
                }
            });

            $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('${pageContext.request.contextPath}/admin/login_adm.cider'); 
                }else{

                }
            });
            
            $("#all-check").change(function(){
                $(".board").prop('checked',$(this).prop('checked'));
            });
            
            
			$("#restfulProduct").submit(function(e) {
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


        });
        
    </script>

</body>

</html>