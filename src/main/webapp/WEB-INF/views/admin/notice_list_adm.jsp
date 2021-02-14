<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
	<title>관리자 게시판 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/notice_list_adm.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
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
                    <h4>공지사항</h4>
                    <select class="form-control" id="align-number">
                        <option value="1">10개씩보기</option>
                        <option value="2">20개씩보기</option>
                    </select>
                    <select class="form-control" id="align-menu">
                        <option value>작성일순</option>
                        <option value="lowprice">조회수순</option>
                    </select>
                </div>


                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="all-check"></th>
                            <th class="text-center">번호</th>
                            <th class="text-center">제목</th>
                            <th class="text-center">작성자</th>
                            <th class="text-center">작성일</th>
                            <th class="text-center">조회수</th>
                        </tr>
                    </thead>
                    <tbody id="board_body">
                         <tbody id="result">
                         	<!-- Ajax로 로드한 결과가 표시될 곳 -->
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
										<c:url var="viewUrl" value="/admin/notice/view.cider">
											<c:param name="bbsno" value="${item.bbsno}" />							
										</c:url>
										
								        <tr>
								            <td><input type="checkbox" class="board "/></td>
								            <td class="text-center ">${item.bbsno}</td>
								            <td class="text-center "><a href="${viewUrl}">${title}</a></td>
								            <td class="text-center ">관리자</td>
								            <td class="text-center ">${item.regdate}</td>
								            <td class="text-center ">${item.hits}</td>
							            </tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
                         </tbody>
                    </tbody>
                </table>
                <form method="get" action="${pageContext.request.contextPath}/admin/notice/list.cider" id="searchBox_help">
	                <div class="input-group">
	                    <div class="input-group-btn">
	                        <button class="btn btn-default" type="submit">
	                        	<span class="glyphicon glyphicon-search"></span>
	                        </button>
	                    </div>
	                    <input type="search" class="form-control" name="keyword" id="keyword" placeholder="키워드를 입력하세요" value="${keyword}">
                    	<a class="btn btn-primary" id="write-btn" href="${pageContext.request.contextPath}/admin/notice/write.cider" role="button">글쓰기</a>
                    	<button id="delete" class="btn btn-warning" role="button">삭제</button>
	                </div>
                </form>
                
                <!-- 페이지 번호 구현 -->
                <ul class="pagination">
	            	<%-- 이전 그룹에 대한 링크 --%>
                  	<c:choose>
						<%-- 이전 그룹으로 이동 가능하다면? --%>
						<c:when test="${pageData.prevPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/admin/notice/list.cider" var="prevPageUrl">
								<c:param name="page" value="${pageData.prevPage}" />
								<c:param name="keyword" value="${keyword}" />				
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

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>
	
	<script id="board_tmpl" type="x-handlebars-template">
        {{#boardlist}}
        <tr>
        <td><input type="checkbox" class="board board-group-item"/></td>
        <td class="text-center board-group-item">{{bbsno}}</td>
        <td class="text-center board-group-item"><a href="{{url}}">{{title}}</a></td>
        <td class="text-center board-group-item">관리자</td>
        <td class="text-center board-group-item">{{regdate}}</td>
        <td class="text-center board-group-item">{{hits}}</td>
        </tr>
        {{/boardlist}}
    </script>
    
    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <!-- ajax-helper -->
 	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
 	<!-- handlebar plugin -->
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

    	// 전체선택
        $("#all-check").change(function(){
            $(".board").prop('checked',$(this).prop('checked'));
        });

		// --------------------------------------------추가기능-------------------------------------

    	// 드롭다운의 변경이벤트
        $("#align-number").change(function(){
        	let nowPage = 1;	// 현재 페이지의 기본값
        	
            $("#result").empty(); //결과가 표시될 #result에 내용 지우기 
            var choice=$(this).find("option:selected").val(); //사용자선택값 가져오기
            if (!choice) {//선택값이 없다면 처리 중단 
                return false; 
            }
            // ajax 요청
  	        else if (choice==2) {
  	       		// 다음 페이지를 요청하기 위해 페이지 변수 1 증가
  	        	nowPage++;
            $.get('${pageContext.request.contextPath}/admin/notice/list.cider', {
            	"page": nowPage
            }, function(req){
                var template= Handlebars.compile($("#board_tmpl").html());
                var html = template(req);
                $("#result").append(html);
            });
            } else if (choice==1) {
                 $(".board-group-item").detach();
            } // class가 "hello"인 요소를 모두 삭제한다.

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
	                	var i = $("input:checked").parents("tr");
	                	i.remove();
	            	} else {
	            		swal("삭제할 항목을 선택해주세요!")
	        		}
            	}
            });
        });


    });

    </script>

</body>

</html>