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
      <%@ include file="/WEB-INF/views/inc/user_profile.jsp"%>
    </div>
    <div class="div_blank"></div>

    <!-- 탭 화면 시작 -->
    <div id="mystore">
      <!-- 탭 메뉴 시작 -->
      <ul class="nav nav-tabs">
        <li class="col-sm-4"><a href="${pageContext.request.contextPath}/mystore/${output.shopaddress}">판매상품</a></li>
        <li class="col-sm-4 active"><a href="${pageContext.request.contextPath}/mystore_s/${output.shopaddress}">숨긴상품</a></li>
        <li class="col-sm-4"><a href="${pageContext.request.contextPath}/mystore_mp/${output.shopaddress}">찜상품</a></li>
      </ul>
      <!--// 탭 메뉴 끝 -->
      <!-- 탭 화면 시작 -->
      <div class="container" id="tab1">
              <div class="item-row clearfix">
                <div id="si_total" class="pull-left">숨긴상품수 <b>${pageData.totalCount}</b></div>
                  <form action="${pageContext.request.contextPath}/mystore_s/${output.shopaddress}" method="get">
                      <div id="searchbox1" class="input-group pull-left">
                        <span id="sbox_addon" class="input-group-addon"><a href="#"><i class="glyphicon glyphicon-search"></i></a></span>
                        <input id="sbox_input" type="search" name="smallKeyword" class="form-control" placeholder="키워드 검색" value="${smallKeyword}">
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
                        <c:when test="${product == null || fn:length(product) == 0}">
                            <div class="noSearch alert alert-success">등록된 상품이 없습니다.</div>
                        </c:when>
                        <%-- 조회결과가 있는 경우 --%>
                        <c:otherwise>
                            <%-- 조회 결과에 따른 반복 처리 --%>
                            <c:forEach var="item" items="${product}" varStatus="status">
                                <div class="col-xs-6 col-sm-4 col-lg-3 item-list">

                                    <%-- 출력을 위해 준비한 학과이름 변수 --%>
                                    <c:set var="subject" value="${item.subject}" />
                                    <c:set var="sellerNick" value="${item.sellerNick}" />

                                    <%-- 검색어가 있다면? --%>
                                    <c:if test="${smallKeyword != ''}">
                                        <%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
                                        <c:set var="mark" value="<mark>${smallKeyword}</mark>" />
                                        <%-- 출력을 위해 준비한 이름에 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
                                        <c:set var="subject" value="${fn:replace(subject, smallKeyword, mark)}" />
                                        <c:set var="sellerNick" value="${fn:replace(sellerNick, smallKeyword, mark)}" />
                                    </c:if>

                                    <%-- 상세페이지로 이동하기 위한 URL --%>
                                    <c:url var="viewUrl" value="/item_index.cider">
                                        <c:param name="prodno" value="${item.prodno}" />
                                    </c:url>

                                    <a href="${viewUrl}">
                                        <div class="sorting thumbnail">
                                            <c:choose>
                                                <c:when test="${item.filepath == null && fn:length(item.filepath) == 0}">
                                                    <img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/upload/default_product.jpg" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/upload${item.thumbnailPath}" />
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
                        <c:when test="${pageData.prevPage > 0}">
                            <%-- 이동할 URL 생성 --%>
                            <c:url value="/mystore_s/${output.shopaddress}" var="prevPageUrl">
                                <c:param name="smallKeyword" value="${smallKeyword}" />
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
                        <c:url value="/mystore_s/${output.shopaddress}" var="pageUrl">
                            <c:param name="smallKeyword" value="${smallKeyword}" />
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
                            <c:url value="/mystore_s/${output.shopaddress}" var="nextPageUrl">
                                <c:param name="smallKeyword" value="${smallKeyword}" />
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

      </div> <!-- 탭1 마무리 -->


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
  	/* 서브메뉴버튼 활성화 */
	document.querySelector('.my_ctg li:nth-child(1)').className = 'active';
  	
    $(function () {
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