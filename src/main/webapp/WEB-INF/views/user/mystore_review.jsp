<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>내상점-거래후기 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_common.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_review.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

  <section>
    <div class="container">
      <!-- 유저 프로필 고정부분 -->
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
        <li><a href="${pageContext.request.contextPath}/user/mystore.cider">내상점</a></li>
        <li class="active"><a href="${pageContext.request.contextPath}/user/mystore_review.cider">거래후기</a></li>
        <li><a href="${pageContext.request.contextPath}/user/mystore_mygrade.cider">나의 등급</a></li>
        <li><a href="${pageContext.request.contextPath}/user/mystore_myinfo.cider">내정보 설정</a></li>
      </ul>
    </div>
    <div class="div_blank"></div>
    <!--// 탭 메뉴 끝 -->
    <!-- 탭 화면 시작 -->
      <div id="myreview">
        <div id="myreview_subject">
          <h1>5.0</h1>
          <div id="user_star">
            <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
            <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
            <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
            <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
            <img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
            <span class="badge">3</span>
          </div>
        </div>
        <div class="container">
          <div class="review2u">
            <ul class="review_list">
              <!-- 리뷰 리스트 로드 -->
            </ul>
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
  
<!-- tmeplate2 -->
<script id="review_tmpl" type="text/x-handlebars-template">
  {{#each review}}
  <li class="media">
  <a class="pull-left" href="#"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/{{thumb}}" width="50"
      height="50"> </a>
  <div class="media-body">
    <div class="clearfix">
      <div class="pull-right">
        <div class="how_trade">{{how}}</div>
      </div>
      <h4 class="media-heading review_user_name">{{id}} <small>{{date}}</small></h4>
      <p class="review_item_subject">{{subject}}</p>
    </div>
    <div class="clearfix review_user_rpl">
      <a href="#">
      <p>{{content}}
      </p>
    </a>
    </div>
    <div class="review_img">
      <a href="#">
      {{#if img1}}
      <img src="${pageContext.request.contextPath}/assets/{{img1}}">
      {{/if}}
	  {{#if img2}}
      <img src="${pageContext.request.contextPath}/assets/{{img2}}">
      {{/if}}
      {{#if img3}}
      <img src="${pageContext.request.contextPath}/assets/{{img3}}">
      {{/if}}
      {{#if img4}}
      <img src="${pageContext.request.contextPath}/assets/{{img4}}">
      {{/if}}
    </a>
    </div>
	
  </div>
</li>
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
      function get_review_list() {
  $.get("${pageContext.request.contextPath}/assets/plugins/ajax/review.json", function (req) {
          // 미리 준비한 HTML틀을 읽어온다.
          var template = Handlebars.compile($("#review_tmpl").html());
          // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
          var html = template(req);
          // #dept_list_body 읽어온 내용을 추가한다.
          $(".review_list").html(html);
        });
      }
    $(function () {
      get_review_list();
     
      $("#myreview .pagination li").click(function (e) {
        e.preventDefault();
        $("#myreview .pagination li").not(this).removeClass("active");
        $(this).addClass("active");
        get_review_list();
      });
    });
  </script>
</body>

</html>