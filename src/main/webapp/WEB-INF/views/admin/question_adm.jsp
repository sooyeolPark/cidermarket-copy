<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>

<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>일반문의 - 사이다마켓</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/question_adm.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header_footer_adm.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.23/datatables.min.css"/>
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>
	
	<div class="container">
        <div class="row">
            <div class="col-lg-2">
                <%@ include file="/WEB-INF/views/inc/board_adm_left.jsp"%>
            </div>
            <div class="col-lg-10">
            
                <div class="title-menu clearfix">
                    <h4>일반문의</h4>
                    <select class="form-control" id="align-number">
                        <option value="10" <c:if test="${pageData.listCount == '10'}">selected</c:if>>10개씩보기</option>
                        <option value="20" <c:if test="${pageData.listCount == '20'}">selected</c:if>>20개씩보기</option>
                    </select>
                    <select class="form-control" id="align-menu">
                        <option value="">답변대기</option>
                        <option value="">답변완료</option>
                    </select>
                </div>            

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input id="all-check"type="checkbox"></th>
                            <th class="text-center">번호</th>
                            <th class="text-center">제목</th>
                            <th class="text-center">작성자</th>
                            <th class="text-center">작성일</th>
                            <th class="text-center">답변상태</th>
                        </tr>
                    </thead>
                    <tbody id="board_body">
                        <tbody id="result">
					<c:choose>
                        <%-- 조회결과가 없는 경우 --%>
                        <c:when test="${output == null || fn:length(output) == 0}">
                           <p class="alert alert-success" role="alert">조회결과가 없습니다.</p>
                        </c:when>
                        <%-- 조회결과가 있는 경우 --%>
                        <c:otherwise>
                           <%-- 조회 결과에 따른 반복 처리 --%>
                           <c:forEach var="item" items="${output}" varStatus="status">
                              <%-- 출력을 위해 준비한 제목 변수 --%>
                              <c:set var="title" value="${item.title}" />
                              
                              <%-- 검색어가 있다면? --%>
                              <c:if test="${keyword != ''}">
                                 <%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
                                 <c:set var="mark" value="<mark>${keyword}</mark>" />
                                 <%-- 출력을 위해 준비한 제목에 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
                                 <c:set var="title" value="${fn:replace(title, keyword, mark)}" />
                              </c:if>
                              
                              <%-- 상세페이지로 이동하기 위한 URL --%>
                              <c:url var="viewUrl" value="/admin/question_adm.cider">
                                 <c:param name="bbsno" value="${item.bbsno}" />                     
                              </c:url>
                              <%-- 글 번호 --%>
                              <c:set var="num" value="${pageData.totalCount-pageData.listCount*(pageData.nowPage-1)-status.count+1}" />
                              
                                <tr>
                                    <td><input type="checkbox" class="board" name="chkRow" value="${item.bbsno}" /></td>
                                    <td class="text-center">${num}</td>
                                    <td class="text-center"><a href="${viewUrl}">${title}</a></td>
                                    <td class="text-center">관리자</td>
                                    <td class="text-center">${item.regdate}</td>
                                    <td class="text-center">${item.hits}</td>
                                 </tr>
                           </c:forEach>
                        </c:otherwise>
                     </c:choose>
                         </tbody>                        
                        
                   </tbody>
   
                </table>
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="button"><span
                                class="glyphicon glyphicon-search"></span></button>
                    </div>
                    <input type="text" class="form-control" id="search_btn" placeholder="키워드를 입력하세요">
                    <button id="delete"class="btn btn-warning"  role="button">삭제</button>
                </div>
                
               <div class="clearfix text-center pagination">
                    <ul>
                   	<%-- 이전 그룹에 대한 링크 --%>
                   	<c:choose>
						<%-- 이전 그룹으로 이동 가능하다면? --%>
						<c:when test="${pageData.prevPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/notice/list.cider" var="prevPageUrl">
								<c:param name="page" value="${pageData.prevPage}" />
								<c:param name="keyword" value="${keyword}" />				
							</c:url>
                        	<li class="arr"><a href="${prevPageUrl}">&laquo;</a></li>
                       	</c:when>
                       	<c:otherwise>
                        	<li class="arr disabled"><a href="#">&laquo;</a></li>
						</c:otherwise>
					</c:choose>
					
					<%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
					<c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">
						<%-- 이동할 URL 생성 --%>
						<c:url value="/notice/list.cider" var="pageUrl">
							<c:param name="page" value="${i}" />
							<c:param name="keyword" value="${keyword}" />				
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
							<c:url value="/notice/list.cider" var="nextPageUrl">
								<c:param name="page" value="${pageData.nextPage}" />
								<c:param name="keyword" value="${keyword}" />				
							</c:url>
                        	<li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
                       	</c:when>
						<c:otherwise>
                        	<li class="arr disabled"><a href="#">&raquo;</a></li>
						</c:otherwise>
					</c:choose>
                    </ul>
                </div>
            </div>
        </div>
    </div>



    <!--/row-->
    <hr>
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

    <script type="text/javascript">
        $(function () {

        // 로그아웃
        $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('${pageContext.request.contextPath}/admin/login_adm.cider'); 
                }else{

                }
            });
      


    //   전체선택
      $("#all-check").change(function(){
          $(".board").prop('checked',$(this).prop('checked'));
      });
    
    
    //삭제 기능 
    
      $("#delete").click(function(e) {
     	 e.preventDefault(); //링크 클릭에 대한 페이지 이동 방지 
     	 
     	 if($("input").is(":checked") == true){ //체크된 요소가 있으면               
           var bbsno = $("input:checked").val();
          
     	 }

     	 if (!confirm("정말" + bbsno+"번 항목을 삭제하겠습니가?")) {
     		 return false; 
     	 }
     	 
     	 //delete 메서드로 Ajax 요청 <form> 전송이 아니므로 직접 구현한다. 
     	 $.delete("${pageContext.request.contextPath}/question", {
     		 "bbsno" : bbsno
     	 }, function(json) {
     		 if(json.rt == "OK") {
     			 alert("삭제되었습니다.");
     			 //삭제 완료 후 목록 페이지로 이동 
     			 window.location="${pageContext.request.contextPath}/admin/question_adm.cider";
     		 }
     	 });
      }); 
    




    });

    </script>

</body>

</html>