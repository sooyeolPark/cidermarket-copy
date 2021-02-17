<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>검색결과 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp" %>

        <section>
            <!-- Item 영역 -->
            <div class="container">
            	<!-- 검색박스 영역 -->
				<form action="${pageContext.request.contextPath}/search.cider" class="search-form">
				    <div class="input-group col-lg-6">
				      <input type="search" name="keyword" class="form-control" value="${keyword}" >
				      <span class="input-group-btn">
				        <button class="btn btn-default" type="submit">검색</button>
				      </span>
				    </div>
			    </form>
				
                <p class="category-name text-center">검색결과</p>
                <h3 id="category-title" class="text-center">${keyword}</h3>

                <div class="item-filter text-center">
                    <button type="button" class="btn btn-danger btn-lg" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-filter"></span> 상품필터</button>
                </div>

                <!-- Modal -->
                <div class="modal fade" id="myModal">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">상품필터</h4>
                        </div>
                        <div class="modal-body">
                            <div class="filter_category_sort">
                                <div class="filter_sort">
                                    <h5>상품상태</h5>
                                    <button class="btn btn-tag"><span class="glyphicon glyphicon-ok"></span> 새상품</button>
                                    <button class="btn btn-tag"><span class="glyphicon glyphicon-ok"></span> 거의새것</button>
                                    <button class="btn btn-tag"><span class="glyphicon glyphicon-ok"></span> 중고</button>
                                </div>
                                <div class="filter_sort">
                                    <h5>판매방법</h5>
                                    <button class="btn btn-tag"><span class="glyphicon glyphicon-ok"></span> 직거래</button>
                                    <button class="btn btn-tag"><span class="glyphicon glyphicon-ok"></span> 택배거래</button>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">선택적용</button>
                        </div>
                        </div>
                    </div>
                </div><!-- Modal -->

                <div class="item-row">
                    <select class="form-control" id="item-select">
                        <option value="fastest">최신순</option>
                        <option value="lowprice">저가순</option>
                        <option value="highprice">고가순</option>
                    </select>
                    <div class="btn-group">
                        <button id="sortList" type="button" class="btn btn-default btn-list"><span class="glyphicon glyphicon glyphicon-th-list"></span><span class="sr-only">썸네일로 보기</span></button>
                        <button id="sortThumb" type="button" class="btn btn-default btn-list active"><span class="glyphicon glyphicon glyphicon-th-large"></span><span class="sr-only">리스트로 보기</span></button>
                    </div>
                </div>

                <div class="box" id="item-list">
					<!-- Ajax로 로드한 결과가 표시될 곳 -->
					<c:choose>
						<%-- 조회결과가 없는 경우 --%>
						<c:when test="${output == null || fn:length(output) == 0}">
							<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
								<p>등록된 상품이 없습니다.</p>
							</div>
						</c:when>
						<%-- 조회결과가 있는 경우 --%>
						<c:otherwise>
							<%-- 조회 결과에 따른 반복 처리 --%>
							<c:forEach var="item" items="${output}" varStatus="status">
								<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
								
									<%-- 출력을 위해 준비한 학과이름 변수 --%>
									<c:set var="subject" value="${item.subject}" />
									<c:set var="sellerNick" value="${item.sellerNick}" />
									
									<%-- 검색어가 있다면? --%>
									<c:if test="${keyword != ''}">
										<%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
										<c:set var="mark" value="<mark>${keyword}</mark>" />
										<%-- 출력을 위해 준비한 이름에 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
										<c:set var="subject" value="${fn:replace(subject, keyword, mark)}" />
										<c:set var="sellerNick" value="${fn:replace(sellerNick, keyword, mark)}" />
									</c:if>
									
									<%-- 상세페이지로 이동하기 위한 URL --%>
									<c:url var="viewUrl" value="/product/item_index.cider">
										<c:param name="prodno" value="${item.prodno}" />
									</c:url>
									
					                <a href="${viewUrl}">
					                    <div class="sorting thumbnail">
				                        	<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img${item.filepath}">
					                        <div class="caption">
					                            <h5>${subject}</h5>
					                            <h4>${item.price}원</h4>
					                            <h6>${sellerNick} 님의 상품</h6>
					                        </div>
					                    </div>
					                </a>
					            </div>
				            </c:forEach>
			            </c:otherwise>
		            </c:choose>
				</div>
                <button type="button" id="more" class="btn btn-primary btn-block btn-lg">더보기</button>
                
            </div>
        </section>
        
        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

        <!-- template -->
        <script id="prod-item-tmpl" type="text/x-handlebars-template">
			{{#each item}}
			<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
             	<a href="${pageContext.request.contextPath}/product/item_index.cider?prodno={{prodno}}">
             		<div class="sorting thumbnail">
                		<img alt="{{subject}}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img{{filepath}}">
                    	<div class="caption">
                       		<h5>{{subject}}</h5>
                        	<h4>{{price}}원</h4>
                       		<h6>{{sellerNick}}</h6>
                    	</div>
                	</div>
            	</a>
        	</div>
			{{/each}}
		</script>

        <!-- Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
        <!-- ajax-helper -->
	    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	    <!-- handlebar plugin -->
	    <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
        <script type="text/javascript">
            /** AJAX로 JSON데이터를 가져와서 화면에 출력하는 함수 */
            function get_sort() {
                if($("#sortList").hasClass("active")) {
                    $(".item-list").removeClass("col-xs-6 col-sm-4 col-md-3");
                    $(".item-list").addClass("col-xs-12 col-sm-6 col-md-6");
                    $(".sorting").removeClass("thumbnail");
                    $(".sorting").addClass("itemList");
                } else if ($("#sortThumb").hasClass("active")) {
                    $(".item-list").removeClass("col-xs-12 col-sm-6 col-md-6");
                    $(".item-list").addClass("col-xs-6 col-sm-4 col-md-3");
                    $(".sorting").removeClass("itemList");
                    $(".sorting").addClass("thumbnail");
                };
            }
            
            
            let nowPage = 1;	// 현재 페이지의 기본값
            
            $(function() {
            	/** 더보기 버튼에 대한 이벤트 정의 */
        		$("#btnMore").click(function() {
        			
        			nowPage++;
        			
        			// Restful API에 GET 방식 요청
        			$.get("${pageContext.request.contextPath}/search.cider", {
        				"page": nowPage    // 페이지 번호는 GET 파라미터로 전송한다.
        			}, function(json) {
        				var source = $("#prod-item-tmpl").html();	// 템플릿 코드 가져오기
        				var template = Handlebars.compile(source);  // 템플릿 코드 컴파일
        				var result = template(json);	// 템플릿 컴파일 결과물에 json 전달
        				$("#list").append(result);		// 최종 결과물을 #list 요소에 추가한다.
        				
        				// 현재 페이지 번호가 전체 페이지 수에 도달했다면 더 보기 버튼을 숨긴다.
        				if (json.pageData.totalPage <= nowPage) {
        					$("#more").hide();
        				}
        				
        			});
        		});
            	
                /* 상품필터 */
                $(".btn-tag").click(function() {
                    $(this).toggleClass('active');
                });

                /* 상품리스트형 */
                $(".btn-list").click(function() {
                    $(".btn-list").not(this).removeClass('active');
                    $(this).toggleClass('active');
                    get_sort();
                });
                 
            });

		</script>
</body>

</html>