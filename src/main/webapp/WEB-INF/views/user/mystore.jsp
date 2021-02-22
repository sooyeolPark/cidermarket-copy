<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
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
          <a class="pull-left" href="#"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img/user_jordan.jpg" width="110"
            height="110" alt="Generic placeholder image" />
            <img class="img-circle" src="${pageContext.request.contextPath}/assets/img/grade_3.png" width="40"
            height="40" id="user_grade" />
        </a>
          <div class="media-body">
            <div id="user_id">마이클조던</div>
            <div id="user_date">2020년 10월 가입</div>
            <div id="user_intro">
              신발 파는 신발 매니아입니다.<br />
              주로 거래하는 브랜드는 나이키입니다.
            </div>
          </div>
        </li>
      </ul>
      <!-- 탭 메뉴 시작 -->
      <ul class="my_ctg">
        <li class="active"><a href="${pageContext.request.contextPath}/user/mystore.cider">내상점</a></li>
        <li><a href="${pageContext.request.contextPath}/user/mystore_review.cider">거래후기</a></li>
        <li><a href="${pageContext.request.contextPath}/mystore_mygrade.cider">나의 등급</a></li>
        <li><a href="${pageContext.request.contextPath}/user/mystore_myinfo.cider">내정보 설정</a></li>
      </ul>
    </div>
    <div class="div_blank"></div>
    <!--// 탭 메뉴 끝 -->
    <!-- 탭 화면 시작 -->
    <div id="mystore">
      <!-- 탭 메뉴 시작 -->
      <ul class="nav nav-tabs">
        <li class="active col-sm-4"><a href="#">판매상품</a></li>
        <li class="col-sm-4"><a href="#">숨긴상품</a></li>
        <li class="col-sm-4"><a href="#">찜상품</a></li>
      </ul>
      <!--// 탭 메뉴 끝 -->
      <!-- 탭 화면 시작 -->
      <div class="container">
              <div id="si_top" class="clearfix">
                <div id="si_total" class="pull-left">전체 <b>20</b></div>
                <div id="si_ctg" class="pull-right">
                  <select class="form-control" id="item_categoty">
                    <option selected>카테고리 전체</option>
                    <option value="ctg01">핸드메이드</option>
                    <option value="ctg02">휴대폰/태블릭</option>
                    <option value="ctg03">가구</option>
                    <option>문구</option>
                    <option>자동차용품</option>
                    <option>유아용/완구</option>
                    <option>컴퓨터/주변기기</option>
                    <option>생활</option>
                    <option>스타굿즈</option>
                    <option>반려동품용품</option>
                    <option>뷰티</option>
                    <option>카메라</option>
                    <option>여성의류</option>
                    <option>디지털/가전</option>
                    <option>피규어/키덜트</option>
                    <option>스포츠/레저</option>
                    <option>남성의류</option>
                    <option>티켓</option>
                    <option>예술/미술</option>
                    <option>게임</option>
                    <option>신발/가방/잡화</option>
                    <option>음향기기/악기</option>
                    <option>도서</option>
                    <option>기타</option>
                  </select>
                </div>
              </div>
              <div class="item-row clearfix">
                <div id="searchbox1" class="input-group pull-left">
                  <span id="sbox_addon" class="input-group-addon"><a href="#"><i
                        class="glyphicon glyphicon-search"></i></a></span>
                  <input id="sbox_input" type="text" class="form-control" placeholder="상품 제목 검색">
                </div>
                <div class="btn-group pull-right">
                  <button id="sortList" type="button" class="btn btn-default btn-list"><span
                      class="glyphicon glyphicon glyphicon-th-list"></span><span class="sr-only">썸네일로
                      보기</span></button>
                  <button id="sortThumb" type="button" class="btn btn-default btn-list active"><span
                      class="glyphicon glyphicon glyphicon-th-large"></span><span class="sr-only">리스트로
                      보기</span></button>
                </div>
              </div>

              <div class="box" id="item-list">
                <!-- Ajax로 로드한 결과가 표시될 곳 -->
              </div>
            
      </div>
      <div class="clearfix text-center pagination">
        <ul>
          <li class="arr disabled"><a href="#">&laquo;</a></li>
          <li class="active"><span>1 <span class="sr-only">(current)</span></span></li>
          <li><a href="#">2</a></li>
          <li><a href="#">3</a></li>
          <li><a href="#">4</a></li>
          <li><a href="#">5</a></li>
          <li class="arr"><a href="#">&raquo;</a></li>
        </ul>
      </div>
    </div>
    
  </section>
  
  	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>
	
  <!-- template1 -->
  <script id="item_tmpl" type="text/x-handlebars-template">
  {{#each item}}
  <div class="col-xs-6 col-sm-4 col-lg-3 item-list">
            <a href="${pageContext.request.contextPath}/user/{{href}}">
                <div class="sorting thumbnail">
                    <img alt="{{title}}" class="img-rounded" src="${pageContext.request.contextPath}/assets/{{imgurl}}">
                    <div class="caption">
                        <h5>{{title}}</h5>
                        <h4>{{price}}원</h4>
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
    function get_list() {
      $.get("${pageContext.request.contextPath}/assets/plugins/ajax/item_01.json", function (req) {
        // 미리 준비한 HTML틀을 읽어온다.
        var template = Handlebars.compile($("#item_tmpl").html());
        // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
        var html = template(req);
        // #dept_list_body 읽어온 내용을 추가한다.
        $("#item-list").html(html);
      });
    }
    $(function () {
      get_list();
      // nav 바
      $(".nav-tabs li").click(function(e){
        $(this).addClass('active');
        $(".nav-tabs li").not(this).removeClass('active');
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


      $("#mystore .pagination li").click(function (e) {
        e.preventDefault();
        $("#mystore .pagination li").not(this).removeClass("active");
        $(this).addClass("active");
        get_list();
      });
    });
  </script>
</body>

</html>