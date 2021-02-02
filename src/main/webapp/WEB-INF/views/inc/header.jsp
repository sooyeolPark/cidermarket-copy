<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<div class="navbar navbar-fixed-top" role="navigation">
  <div class="container">
    <div id="logo" class="text-center">
      <a href="index.jsp"
        ><img src="assets/img/logo.png" width="100%" alt="사이다마켓 로고"
      /></a>
    </div>
    <div class="ico-wrap">
      <div id="btnNav">
        <a href="#" onclick="$('.aside').asidebar('open'); return false;"
          ><span class="glyphicon glyphicon-menu-hamburger"></span
        ></a>
      </div>
      <div id="btnAlarm">
        <a href="alarm.html"
          ><span class="newAlarm"></span
          ><img src="assets/img/ico_bell.png" width="100%" alt="알림"
        /></a>
      </div>
      <div id="btnSearch">
        <a href="#"><span class="glyphicon glyphicon-search"></span></a>
      </div>
    </div>
  </div>
  <div id="searchBox" class="container">
    <input
      type="text"
      class="form-control"
      placeholder="키워드를 입력해 주세요."
    />
    <button class="btn btnSearch-s" type="button">
      <i class="glyphicon glyphicon-search"></i>
    </button>
    <div class="interest col-xs-6">
      <h5 class="label label-warning">인기 키워드</h5>
      <ul id="i-key"></ul>
    </div>
    <div class="latest col-xs-6">
      <h5 class="label label-default">최근 검색</h5>
      <ul id="l-key"></ul>
    </div>
    <div id="searchClose" class="col-xs-12 text-center">닫기</div>
  </div>
</div>
<!-- 사이드바 시작 -->
<div class="aside">
  <div class="aside-header">
    <img src="assets/img/logo2.png" alt="로고" width="100%" />
    <div>
      <h5 class="btnn-login view-none">
        <span id="username">happykim</span>님 안녕하세요.
      </h5>
    </div>
    <span class="close" data-dismiss="aside" aria-hidden="true">&times;</span>
  </div>
  <div class="aside-contents">
    <div class="btnn-logout view-block">
      <a href="login.html" class="btn btn-primary">로그인</a>
      <a href="join.html" class="btn btn-info">회원가입</a>
			<div class="btnn-temp">
				<a href="login_adm.html" class="btn btn-danger templogin">임시관리자</a>
				<a href="#" class="btn btn-danger templogin">임시로그인</a>
			</div>
		</div>
    </div>
    <div class="btnn-login view-none">
      <a href="msgbox.html" class="btn btn-info">쪽지함</a>
      <a href="record_sell.html?selected=selling" class="btn btn-info"
        >거래내역</a
      >
      <a href="mystore.html" class="btn btn-info">내상점</a>
    </div>
    <div class="gory_title">CATEGORY</div>
    <div class="category">
      <ul>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hba0000.png" />핸드메이드</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hak0000.png" />휴대폰/태블릿</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_haf0000.png" />가 구</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_haw0000.png" />문 구</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_har0000.png" />자동차용품</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hae0000.png" />유아용/완구</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hai0000.png" />컴퓨터/주변기기</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hag0000.png" />생활</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hax0000.png" />스타굿즈</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_pet_goods.png" />반려동물용품</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_had0000.png" />뷰티</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_haj0000.png" />카메라</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_haa0000.png" />여성의류</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hah0000.png" />디지털/가전</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hav0000.png" />피규어/키덜트</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hao0000.png" />스포츠/레저</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hab0000.png" />남성의류</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_haq0000.png" />티켓</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_has0000.png" />예술/미술</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_han0000.png" />게임</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hac0000.png" />신발/가방/잡화</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_ham0000.png" />음향기기/악기</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hap0000.png" />도서</span></a
          >
        </li>
        <li>
          <a href="item_list.html"
            ><span><img src="assets/img/cate_hzz0000.png" />기타</span></a
          >
        </li>
      </ul>
    </div>
    <div class="nav_bar"><a href="event_list.html">이벤트</a></div>
    <div class="nav_bar"><a href="notice_list.html">공지사항</a></div>
    <div class="nav_bar"><a href="help.html?selected=faq">헬프센터</a></div>
    <div class="nav_bar"><a href="protection.html">개인정보처리방침</a></div>
    <div class="btnn-login view-none">
      <a href="#" class="btn btn-danger logout">로그아웃</a>
    </div>
    <address class="sb_address">
      &copy;(주)사이다마켓. ALL RIGHTS RESERVED.
    </address>
  </div>
</div>
<div class="aside-backdrop"></div>

<!-- template -->
<script id="key_tmpl" type="text/x-handlebars-template">
  {{#each i-key}}
    <li>
      <a href="{{khref}}">
        <span>
          {{knum}}
        </span>

        <span>
          {{ktitle}}
        </span>
      </a>
    </li>
  {{/each}}
</script>

<!-- // 사이드바 시작 -->
<!-- <script src="assets/js/searchbox.js"></script> -->
<script src="assets/js/headerScroll.js"></script>
<!-- ajax-helper -->
<link rel="stylesheet" href="assets/plugins/ajax/ajax_helper.css" />
<script src="assets/plugins/ajax/ajax_helper.js"></script>
<!-- handlebar plugin -->
<script src="assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
<!-- 사용자 정의 스크립트 -->
<script type="text/javascript">
  /** AJAX로 JSON데이터를 가져와서 화면에 출력하는 함수 */
  function get_key_list() {
    $.get("assets/plugins/ajax/interest_keyword.json", function (req) {
      // 미리 준비한 HTML틀을 읽어온다.
      var template = Handlebars.compile($("#key_tmpl").html());
      // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
      var html = template(req);
      // #dept_list_body 읽어온 내용을 추가한다.
      $("#i-key").append(html);
    });
  }

  $(function () {
    get_key_list();

    $(".templogin, .logout").click(function () {
      $(".btnn-login, .btnn-logout").toggleClass("view-none");
      $(".btnn-logout").toggleClass("view-block");
    });
    
    $("#btnSearch, #searchClose").click(function(e) { 
      e.preventDefault();
      $("#searchBox").slideToggle(); 
    });
  });
</script>
