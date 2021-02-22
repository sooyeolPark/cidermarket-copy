<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>내상점 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_common.css" />
 	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore.css" />
 	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

  <section>
    <div class="container">
      <!-- 유저 프로필 고정부분입니다. -->
      <ul class="media-list" id="user_profile">
        <li class="media clearfix">
          <a class="pull-left" href="#"> 
	        <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img${output.filepath}" width="110" height="110" alt="Generic placeholder image" />
	        <img class="img-circle" src="${pageContext.request.contextPath}/assets/img/grade_3.png" width="40" height="40" id="user_grade" />
	      </a>
          <div class="media-body">
            <div id="user_id">${output.nickname}</div>
            <div id="user_date">
	            <fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss" value="${output.joindate }"/>
            	<fmt:formatDate var="dateTempParse" pattern="yyyy년 MM월 dd일" value="${dateFmt }" /> 
            	<c:out value="${dateTempParse }" /> 가입
           	</div>
            <div id="user_intro">${output.intro}</div>
          </div>
        </li>
      </ul>
      <!-- 탭 메뉴 시작 -->
      <ul class="my_ctg">
        <li class="active"><a href="${pageContext.request.contextPath}/mystore.cider">내상점</a></li>
        <li><a href="${pageContext.request.contextPath}/mystore_review.cider">거래후기</a></li>
        <li><a href="${pageContext.request.contextPath}/mystore_mygrade.cider">나의 등급</a></li>
        <li><a href="${pageContext.request.contextPath}/mystore_myinfo.cider">내정보 설정</a></li>
      </ul>
    </div>
    <div class="div_blank"></div>
    <!--// 탭 메뉴 끝 -->
    <!-- 탭 화면 시작 -->
    <div id="mystore">
      <!-- 탭 메뉴 시작 -->
      <ul class="nav nav-tabs">
        <li class="col-sm-4 J" data-tab="tab1"><a href="#">판매상품</a></li>
        <li class="col-sm-4 S" data-tab="tab2"><a href="#">숨긴상품</a></li>
        <li class="col-sm-4 MP" data-tab="tab3"><a href="#">찜상품</a></li>
      </ul>
      <!--// 탭 메뉴 끝 -->
      <!-- 탭 화면 시작 -->
      <div class="container" id="tab1">
              <div class="item-row clearfix">
              	<div id="si_total" class="pull-left">판매상품수 <b>${pageData1.totalCount}</b></div>
                  <form action="${pageContext.request.contextPath}/mystore.cider" method="get">
	                  <div id="searchbox1" class="input-group pull-left">
	                    <span id="sbox_addon" class="input-group-addon"><a href="#"><i class="glyphicon glyphicon-search"></i></a></span>
	                    <input type="hidden" name="tradecon" value="J">
	                    <input id="sbox_input" type="search" name="smallKeyword1" class="form-control" placeholder="키워드 검색" value="${smallKeyword1}">
	                  </div>
	       		  </form>
                <div class="btn-group pull-right">
                  <button id="sortList" type="button" class="btn btn-default btn-list">
                  <span class="glyphicon glyphicon glyphicon-th-list"></span><span class="sr-only">썸네일로 보기</span></button>
                  <button id="sortThumb" type="button" class="btn btn-default btn-list active">
                  <span class="glyphicon glyphicon glyphicon-th-large"></span><span class="sr-only">리스트로 보기</span></button>
                </div>
              </div>

              <div class="box" id="item-list">
              		<!-- Ajax로 로드한 결과가 표시될 곳 -->
                	<c:choose>
						<%-- 조회결과가 없는 경우 --%>
						<c:when test="${product1 == null || fn:length(product1) == 0}">
							<div class="noSearch alert alert-success">등록된 상품이 없습니다.</div>
						</c:when>
						<%-- 조회결과가 있는 경우 --%>
						<c:otherwise>
							<%-- 조회 결과에 따른 반복 처리 --%>
							<c:forEach var="item" items="${product1}" varStatus="status">
								<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
								
									<%-- 출력을 위해 준비한 학과이름 변수 --%>
									<c:set var="subject" value="${item.subject}" />
									<c:set var="sellerNick" value="${item.sellerNick}" />
									
									<%-- 검색어가 있다면? --%>
									<c:if test="${smallKeyword1 != ''}">
										<%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
										<c:set var="mark" value="<mark>${smallKeyword1}</mark>" />
										<%-- 출력을 위해 준비한 이름에 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
										<c:set var="subject" value="${fn:replace(subject, smallKeyword1, mark)}" />
										<c:set var="sellerNick" value="${fn:replace(sellerNick, smallKeyword1, mark)}" />
									</c:if>
									
									<%-- 상세페이지로 이동하기 위한 URL --%>
									<c:url var="viewUrl" value="/item_index.cider">
										<c:param name="prodno" value="${item.prodno}" />
									</c:url>
									
					                <a href="${viewUrl}">
					                    <div class="sorting thumbnail">
				                        	<c:choose>
					                        	<c:when test="${item.filepath == null && fn:length(item.filepath) == 0}">
					                        		<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img/default_product.jpg" />
					                        	</c:when>
				                        		<c:otherwise>
				                        			<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img${item.filepath}" />
				                        		</c:otherwise>
				                        	</c:choose>
					                        <div class="caption">
					                            <h5>${subject}</h5>
					                            <h4><fmt:formatNumber value="${item.price}" pattern="#,###" />원</h4>
					                            <h6>${sellerNick} 님의 상품</h6>
					                        </div>
					                    </div>
					                </a>
					            </div>
				            </c:forEach>
			            </c:otherwise>
		            </c:choose>
		        
              </div>
              
              <!-- 페이지 번호 구현 -->
		      <div class="clearfix text-center pagination">
		          <ul>
		         	<%-- 이전 그룹에 대한 링크 --%>
		         	<c:choose>
						<%-- 이전 그룹으로 이동 가능하다면? --%>
						<c:when test="${pageData1.prevPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/mystore.cider" var="prevPageUrl">
								<c:param name="tradecon" value="J" />
								<c:param name="page1" value="${pageData1.prevPage}" />
							</c:url>
				              	<li class="arr"><a href="${prevPageUrl}">&laquo;</a></li>
				             	</c:when>
				             	<c:otherwise>
				              	<li class="arr disabled"><a href="#">&laquo;</a></li>
						</c:otherwise>
					</c:choose>
					
					<%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
					<c:forEach var="i" begin="${pageData1.startPage}" end="${pageData1.endPage}" varStatus="status">
						<%-- 이동할 URL 생성 --%>
						<c:url value="/mystore.cider" var="pageUrl">
							<c:param name="tradecon" value="J" />
							<c:param name="page1" value="${i}" />
						</c:url>
						
						<%-- 페이지 번호 출력 --%>
						<c:choose>
							<%-- 현재 머물고 있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
							<c:when test="${pageData1.nowPage == i}">
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
						<c:when test="${pageData1.nextPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/mystore.cider" var="nextPageUrl">
								<c:param name="tradecon" value="J" />
								<c:param name="page1" value="${pageData1.nextPage}" />
							</c:url>
				              	<li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
				             	</c:when>
						<c:otherwise>
				              	<li class="arr disabled"><a href="#">&raquo;</a></li>
						</c:otherwise>
					</c:choose>
		          </ul>
		      </div> <!-- 페이지 번호 구현 끝 -->
            
      </div> <!-- 탭1 마무리 -->
      
      <!-- 탭 화면 시작 -->
      <div class="container hide" id="tab2">
              <div class="item-row clearfix">
              	<div id="si_total" class="pull-left">숨긴상품수 <b>${pageData2.totalCount}</b></div>
              	<form action="${pageContext.request.contextPath}/mystore.cider" method="get">
	                  <div id="searchbox2" class="input-group pull-left">
	                    <span id="sbox_addon" class="input-group-addon"><a href="#"><i class="glyphicon glyphicon-search"></i></a></span>
	                    <input type="hidden" name="tradecon" value="S">
	                    <input id="sbox_input" type="search" name="smallKeyword2" class="form-control" placeholder="키워드 검색" value="${smallKeyword2}">
	                  </div>
	       		  </form>
                <div class="btn-group pull-right">
                  <button id="sortList" type="button" class="btn btn-default btn-list"><span class="glyphicon glyphicon glyphicon-th-list"></span><span class="sr-only">썸네일로 보기</span></button>
                  <button id="sortThumb" type="button" class="btn btn-default btn-list active"><span class="glyphicon glyphicon glyphicon-th-large"></span><span class="sr-only">리스트로 보기</span></button>
                </div>
              </div>

              <div class="box" id="item-list">
              		<!-- Ajax로 로드한 결과가 표시될 곳 -->
                	<c:choose>
						<%-- 조회결과가 없는 경우 --%>
						<c:when test="${product2 == null || fn:length(product2) == 0}">
							<div class="noSearch alert alert-success">등록된 상품이 없습니다.</div>
						</c:when>
						<%-- 조회결과가 있는 경우 --%>
						<c:otherwise>
							<%-- 조회 결과에 따른 반복 처리 --%>
							<c:forEach var="item" items="${product2}" varStatus="status">
								<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
								
									<%-- 출력을 위해 준비한 학과이름 변수 --%>
									<c:set var="subject" value="${item.subject}" />
									<c:set var="sellerNick" value="${item.sellerNick}" />
									
									<%-- 검색어가 있다면? --%>
									<c:if test="${smallKeyword2 != ''}">
										<%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
										<c:set var="mark" value="<mark>${smallKeyword2}</mark>" />
										<%-- 출력을 위해 준비한 이름에 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
										<c:set var="subject" value="${fn:replace(subject, smallKeyword2, mark)}" />
										<c:set var="sellerNick" value="${fn:replace(sellerNick, smallKeyword2, mark)}" />
									</c:if>
									
									<%-- 상세페이지로 이동하기 위한 URL --%>
									<c:url var="viewUrl" value="/item_index.cider">
										<c:param name="prodno" value="${item.prodno}" />
									</c:url>
									
					                <a href="${viewUrl}">
					                    <div class="sorting thumbnail">
				                        	<c:choose>
					                        	<c:when test="${item.filepath == null && fn:length(item.filepath) == 0}">
					                        		<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img/default_product.jpg" />
					                        	</c:when>
				                        		<c:otherwise>
				                        			<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img${item.filepath}" />
				                        		</c:otherwise>
				                        	</c:choose>
					                        <div class="caption">
					                            <h5>${subject}</h5>
					                            <h4><fmt:formatNumber value="${item.price}" pattern="#,###" />원</h4>
					                            <h6>${sellerNick} 님의 상품</h6>
					                        </div>
					                    </div>
					                </a>
					            </div>
				            </c:forEach>
			            </c:otherwise>
		            </c:choose>
		        
              </div>
              
              <!-- 페이지 번호 구현 -->
		      <div class="clearfix text-center pagination">
		          <ul>
		         	<%-- 이전 그룹에 대한 링크 --%>
		         	<c:choose>
						<%-- 이전 그룹으로 이동 가능하다면? --%>
						<c:when test="${pageData2.prevPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/mystore.cider" var="prevPageUrl">
								<c:param name="tradecon" value="S" />
								<c:param name="page2" value="${pageData2.prevPage}" />
							</c:url>
				              	<li class="arr"><a href="${prevPageUrl}">&laquo;</a></li>
				             	</c:when>
				             	<c:otherwise>
				              	<li class="arr disabled"><a href="#">&laquo;</a></li>
						</c:otherwise>
					</c:choose>
					
					<%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
					<c:forEach var="i" begin="${pageData2.startPage}" end="${pageData2.endPage}" varStatus="status">
						<%-- 이동할 URL 생성 --%>
						<c:url value="/mystore.cider" var="pageUrl">
							<c:param name="tradecon" value="S" />
							<c:param name="page2" value="${i}" />
						</c:url>
						
						<%-- 페이지 번호 출력 --%>
						<c:choose>
							<%-- 현재 머물고 있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
							<c:when test="${pageData2.nowPage == i}">
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
						<c:when test="${pageData2.nextPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/mystore.cider" var="nextPageUrl">
								<c:param name="tradecon" value="S" />
								<c:param name="page2" value="${pageData2.nextPage}" />
							</c:url>
				              	<li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
				             	</c:when>
						<c:otherwise>
				              	<li class="arr disabled"><a href="#">&raquo;</a></li>
						</c:otherwise>
					</c:choose>
		          </ul>
		      </div> <!-- 페이지 번호 구현 끝 -->
            
      </div> <!-- 탭2 마무리 -->
      
      <!-- 탭 화면 시작 -->
      <div class="container hide" id="tab3">
              <div class="item-row clearfix">
              	<div id="si_total" class="pull-left">찜상품수 <b>${pageData3.totalCount}</b></div>
                  <form action="${pageContext.request.contextPath}/mystore.cider" method="get">
	                  <div id="searchbox3" class="input-group pull-left">
	                    <span id="sbox_addon" class="input-group-addon"><a href="#"><i class="glyphicon glyphicon-search"></i></a></span>
	                    <input type="hidden" name="tradecon" value="MP">
	                    <input id="sbox_input" type="search" name="smallKeyword3" class="form-control" placeholder="키워드 검색" value="${smallKeyword3}">
	                  </div>
	       		  </form>
                <div class="btn-group pull-right">
                  <button id="sortList" type="button" class="btn btn-default btn-list"><span class="glyphicon glyphicon glyphicon-th-list"></span><span class="sr-only">썸네일로 보기</span></button>
                  <button id="sortThumb" type="button" class="btn btn-default btn-list active"><span class="glyphicon glyphicon glyphicon-th-large"></span><span class="sr-only">리스트로 보기</span></button>
                </div>
              </div>

              <div class="box" id="item-list">
              		<!-- Ajax로 로드한 결과가 표시될 곳 -->
                	<c:choose>
						<%-- 조회결과가 없는 경우 --%>
						<c:when test="${product3 == null || fn:length(product3) == 0}">
							<div class="noSearch alert alert-success">등록된 상품이 없습니다.</div>
						</c:when>
						<%-- 조회결과가 있는 경우 --%>
						<c:otherwise>
							<%-- 조회 결과에 따른 반복 처리 --%>
							<c:forEach var="item" items="${product3}" varStatus="status">
								<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
								
									<%-- 출력을 위해 준비한 학과이름 변수 --%>
									<c:set var="subject" value="${item.subject}" />
									<c:set var="sellerNick" value="${item.sellerNick}" />
									
									<%-- 검색어가 있다면? --%>
									<c:if test="${smallKeyword3 != ''}">
										<%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
										<c:set var="mark" value="<mark>${smallKeyword3}</mark>" />
										<%-- 출력을 위해 준비한 이름에 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
										<c:set var="subject" value="${fn:replace(subject, smallKeyword3, mark)}" />
										<c:set var="sellerNick" value="${fn:replace(sellerNick, smallKeyword3, mark)}" />
									</c:if>
									
									<%-- 상세페이지로 이동하기 위한 URL --%>
									<c:url var="viewUrl" value="/item_index.cider">
										<c:param name="prodno" value="${item.prodno}" />
									</c:url>
									
					                <a href="${viewUrl}">
					                    <div class="sorting thumbnail">
				                        	<c:choose>
					                        	<c:when test="${item.filepath == null && fn:length(item.filepath) == 0}">
					                        		<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img/default_product.jpg" />
					                        	</c:when>
				                        		<c:otherwise>
				                        			<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img${item.filepath}" />
				                        		</c:otherwise>
				                        	</c:choose>
					                        <div class="caption">
					                            <h5>${subject}</h5>
					                            <h4><fmt:formatNumber value="${item.price}" pattern="#,###" />원</h4>
					                            <h6>${sellerNick} 님의 상품</h6>
					                        </div>
					                    </div>
					                </a>
					            </div>
				            </c:forEach>
			            </c:otherwise>
		            </c:choose>
		        
              </div>
              
              <!-- 페이지 번호 구현 -->
		      <div class="clearfix text-center pagination">
		          <ul>
		         	<%-- 이전 그룹에 대한 링크 --%>
		         	<c:choose>
						<%-- 이전 그룹으로 이동 가능하다면? --%>
						<c:when test="${pageData3.prevPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/mystore.cider" var="prevPageUrl">
								<c:param name="tradecon" value="MP" />
								<c:param name="page3" value="${pageData3.prevPage}" />
							</c:url>
				              	<li class="arr"><a href="${prevPageUrl}">&laquo;</a></li>
				             	</c:when>
				             	<c:otherwise>
				              	<li class="arr disabled"><a href="#">&laquo;</a></li>
						</c:otherwise>
					</c:choose>
					
					<%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
					<c:forEach var="i" begin="${pageData3.startPage}" end="${pageData3.endPage}" varStatus="status">
						<%-- 이동할 URL 생성 --%>
						<c:url value="/mystore.cider" var="pageUrl">
							<c:param name="tradecon" value="MP" />
							<c:param name="page3" value="${i}" />
						</c:url>
						
						<%-- 페이지 번호 출력 --%>
						<c:choose>
							<%-- 현재 머물고 있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
							<c:when test="${pageData3.nowPage == i}">
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
						<c:when test="${pageData3.nextPage > 0}">
							<%-- 이동할 URL 생성 --%>
							<c:url value="/mystore.cider" var="nextPageUrl">
								<c:param name="tradecon" value="MP" />
								<c:param name="page3" value="${pageData3.nextPage}" />
							</c:url>
				              	<li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
				             	</c:when>
						<c:otherwise>
				              	<li class="arr disabled"><a href="#">&raquo;</a></li>
						</c:otherwise>
					</c:choose>
		          </ul>
		      </div> <!-- 페이지 번호 구현 끝 -->
            
      </div> <!-- 탭3 마무리 -->
      
      
   </div>
  </section>
  
  	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>
  
  <!-- Javascript -->
  <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
  <!-- ajax-helper -->
  <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
  <script type="text/javascript">   
    $(function () {
    	/** 파라미터 받아와서 1차 탭 선택함 */
		let url = new URL(window.location.href);
		let tradecon = url.searchParams.get("tradecon");
		switch(tradecon) {
		case 'MP':
			$(".MP").addClass("active");
			break;
		case 'S':
			$(".S").addClass("active");
			break;
		default:
			$(".J").addClass("active");
			break;
		}
       
      // 상품탭 여닫기
      $(".nav-tabs li").click(function(e){
    	  $(this).addClass('active');
    	  $(".nav-tabs li").not(this).removeClass('active');
    	  
          let id = $(this).data("tab");
          switch(id) {
          	case 'tab1':
        	  $("#tab1").removeClass("hide");
        	  $("#tab2, #tab3").addClass("hide");
        	  break;
          	case 'tab2':  
        	  $("#tab2").removeClass("hide");
        	  $("#tab1, #tab3").addClass("hide");
        	  break;
          	default:
        	  $("#tab3").removeClass("hide");
          	  $("#tab1, #tab2").addClass("hide");
          	  break;
          }
      });
      /* 상품리스트형 */
      $(".btn-list").click(function () {
        $(".btn-list").not(this).removeClass('active');
        $(this).toggleClass('active');

        if ($("#sortList").hasClass("active")) {
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
      });

    });
  </script>
</body>

</html>