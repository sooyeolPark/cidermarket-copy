<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>거래내역 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                <h3 class="text-center">거래내역</h3>

                <!-- 탭의 전체 박스 -->
                <div class="tab clearfix">
                    
                    <!-- 탭 버튼 영역 -->
                    <ul class="row tab-button clearfix">
                        <li role="presentation" class="tab-button-item text-center">
                            <a href="${pageContext.request.contextPath}/member/record/selling.cider" class="tab-button-item-link pull-left selected">판매</a>
                        </li>
                        <li role="presentation" class="tab-button-item text-center">
                            <a href="${pageContext.request.contextPath}/member/record/buying.cider" class="tab-button-item-link pull-left">구매</a>
                        </li>
                    </ul>

                    <!-- 거래중/거래완료 sorting -->
                    <div class="recordSort text-center">
                        <a href="${pageContext.request.contextPath}/member/record/selling.cider" class="ing btn btn-lg btn-info" id="selling">거래중</a>
                        <a href="${pageContext.request.contextPath}/member/record/sellend.cider" class="ing btn btn-lg btn-primary" id="sellend">거래완료</a>
                    </div>
                    <!-- 내용영역 -->
                    <div class="tab-panel">
                    
                        <!-- 거래완료 탭 -->
                        <div id="tab-page-2">
                        
	                       	<c:choose>
	                        	<%-- 조회결과가 없는 경우 --%>
		                        <c:when test="${output == null || fn:length(output) == 0}">
		                           <p class="alert alert-success" role="alert">조회결과가 없습니다.</p>
		                        </c:when>
		                        <%-- 조회결과가 있는 경우 --%>
		                        <c:otherwise>
			                        <%-- 조회 결과에 따른 반복 처리 --%>
		                            <c:forEach var="item" items="${output}" varStatus="status">
			                            <div class="col-xs-12 col-sm-6 col-md-6 item-list">
							                <div class="sorting itemList">
							                    <img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img${item.filepath}">
							                    <div class="caption">
							                        <span class="label"><c:if test="${item.how == 'T'}">택배거래</c:if><c:if test="${item.how == 'J'}">직거래</c:if></span>
							                        <span class="temp-gray"><span>${item.prodno}</span><c:if test="${item.how == 'J'}"> | buyer(${item.buyer})</c:if></span>
							                        <h4><a href="${pageContext.request.contextPath}/item_index.cider?prodno=${item.prodno}">${item.subject}</a></h4>
							                        <h4><b><fmt:formatNumber value="${item.price}" pattern="#,###" />원</b></h4>
							                        <div class="resultBtn">
							                        	<c:if test="${item.tradecon == 'A'}">
							                            	<button type="button" class="ing btn btn-warning" disabled>정산중</button>
							                            </c:if>
						                        		<c:if test="${item.tradecon == 'C'}">
							                            	<button type="button" class="ing btn btn-warning" disabled>정산완료</button>
							                            </c:if>
					                            		<c:if test="${item.refund == 'W' && item.how == 'T'}">
						                            		<button type="button" class="ing btn btn-warning recordReturn" data-prodno="${item.prodno}" data-recono="${item.recono}" data-refund="${item.refund}" disabled>반품완료</button>
					                            		</c:if>
					                            		<c:if test="${item.refund == 'X' && item.how == 'T'}">
						                            		<button type="button" class="ing btn btn-warning recordReturn" data-prodno="${item.prodno}" data-recono="${item.recono}" data-refund="${item.refund}" disabled>반품거절</button>
					                            		</c:if>
						                            	<c:choose>
															<c:when test="${item.revino == 0}">
								                            	<button type="button" class="ing btn btn-primary review-write" data-recono="${item.recono}" data-receiver="${item.buyer}" data-prodno="${item.prodno}">후기 남기기</button>
								                            </c:when>
								                            <c:otherwise>
									                            <button type="button" class="ing btn btn-danger review-view" data-recono="${item.recono}" data-revino="${item.revino}" data-receiver="${item.buyer}">후기 작성완료</button>
								                            </c:otherwise>
							                            </c:choose>
							                        </div>
							                    </div>
							                </div>
							            </div>
					            	</c:forEach>
		                        </c:otherwise>
	                        </c:choose>
				            
				            <!-- 페이지 번호 구현 -->
			                <div class="clearfix text-center pagination">
			                    <ul>
			                   	<%-- 이전 그룹에 대한 링크 --%>
			                   	<c:choose>
									<%-- 이전 그룹으로 이동 가능하다면? --%>
									<c:when test="${pageData.prevPage > 0}">
										<%-- 이동할 URL 생성 --%>
										<c:url value="/member/record/sellend.cider" var="prevPageUrl">
											<c:param name="page" value="${pageData.prevPage}" />
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
									<c:url value="/member/record/sellend.cider" var="pageUrl">
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
			                    
			                    <%-- 다음 그룹에 대한 링크 --%>
								<c:choose>
									<%-- 다음 그룹으로 이동 가능하다면? --%>
									<c:when test="${pageData.nextPage > 0}">
										<%-- 이동할 URL 생성 --%>
										<c:url value="/member/record/sellend.cider" var="nextPageUrl">
											<c:param name="page" value="${pageData.nextPage}" />
										</c:url>
			                        	<li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
			                       	</c:when>
									<c:otherwise>
			                        	<li class="arr disabled"><a href="#">&raquo;</a></li>
									</c:otherwise>
								</c:choose>
			                    </ul>
			                </div> <!-- 페이지 번호 구현 끝 -->
				            
                        </div> <!-- 거래완료 탭 종료 -->
                        
                    </div>
                </div>
                
                
            </div>
        </section>
        
        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>
		
        <!-- Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
        <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
        <!-- ajax-helper -->
        <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
        <script type="text/javascript">

            /****************************** 후기 남기기 *****************************/
            $(document).on("click", ".review-write", function(e) {
                e.preventDefault();
                var ts = $(this)
                
             	// data를 통해 거래 정보 가져오기
	            let receiver = ts.data("receiver");
	            let prodno = ts.data("prodno");
	            let recono = ts.data("recono");
	            
	         	// Ajax 호출
                $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/record/sell/end/review",
                    data: {"receiver":receiver, "prodno":prodno, "recono":recono},
                    success: function(json) {
  	    				console.log(json);
  	    				window.location = "${pageContext.request.contextPath}/review_write.cider?recono=" + json.item.recono;
  	    			}
                });
                
            });
            
            /****************************** 후기 작성완료 보러가기 *****************************/
            $(document).on("click", ".review-view", function(e) {
                e.preventDefault();
                var ts = $(this)
                
             	// data를 통해 거래 정보 가져오기
	            let revino = ts.data("revino");
	            
	            window.location = "${pageContext.request.contextPath}/review_view.cider?revino="+revino;
                
            });

         
        </script>
</body>

</html>