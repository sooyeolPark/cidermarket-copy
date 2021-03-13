<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>${nickname}님의 상점 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_common.css" />
 	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_who.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/mystore_review.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 화면에 표시될 원본 보기 영역 - 기본적으로 숨겨진 상태이다. -->
    <div class='gray_layer' id='background'></div>
    <div class='over_layer' id='front'>
      <div class="modal_name">쪽지보내기</div>
      <div class="modal_content">
        <form role="form">
          <div class="form-group">
            <span id="to_user"></span>
            <span class="help-block">님에게 쪽지보내기</span>
            <textarea rows="5" id="send_input" class="form-control" placeholder="내용을 입력해주세요."></textarea>
            <div class="modal_btn">
              <button id="send_ok" type="button" class="btn btn-primary">보내기</button>
              <button id="send_cancle" type="button" class="btn btn-info">취소</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

  <section>
    <div class="container">
      <!-- 유저 프로필 고정부분 -->
      <%@ include file="/WEB-INF/views/inc/user_profile.jsp"%>
    </div>
    <div class="div_blank"></div>
    <!--// 탭 메뉴 끝 -->
    <!-- 탭 화면 시작 -->
    <div id="mystore">
      <!-- 탭 메뉴 시작 -->
      <div class="tab">
        <ul class="tab-button clearfix">
          <li class="tab-button-item pull-left">
            <a class="tab-button-item-link selected" href="#tab-page-1">판매상품</a>
          </li>
          <li class="tab-button-item pull-left">
            <a class="tab-button-item-link" href="#tab-page-2">거래후기</a>
          </li>
        </ul>
        <!--// 탭 메뉴 끝 -->
        <!-- 탭 화면 시작 -->
        <div class="tab-panel">
          <div id="tab-page-1">
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
          <div id="tab-page-2" class="hide">
            <div id="myreview">
              <div id="myreview_subject">
                <h1>5.0</h1>
                <div id="user_star">
                  <img src="${pageContext.request.contextPath}/upload/star_full.png" alt="별점 1점">
                  <img src="${pageContext.request.contextPath}/upload/star_full.png" alt="별점 1점">
                  <img src="${pageContext.request.contextPath}/upload/star_full.png" alt="별점 1점">
                  <img src="${pageContext.request.contextPath}/upload/star_full.png" alt="별점 1점">
                  <img src="${pageContext.request.contextPath}/upload/star_blank.png" alt="별점 0점">
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
          </div>
        </div>
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
      <img src="${pageContext.request.contextPath}/assets/{{img1}}">
      <img src="${pageContext.request.contextPath}/assets/{{img2}}">
      <img src="${pageContext.request.contextPath}/assets/{{img3}}">
      <img src="${pageContext.request.contextPath}/assets/{{img4}}">
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
  <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
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
      get_list();
      get_review_list();
      // nav 바
      $(".tab-button-item-link").click(function (e) {
        e.preventDefault();

        $(".tab-button-item-link").not(this).removeClass("selected");

        $(this).addClass("selected");

        var target = $(this).attr('href');
        $(target).removeClass('hide');
        $(".tab-panel > div").not($(target)).addClass('hide');
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
      
     
     $("#myreview .pagination li").click(function (e) {
       e.preventDefault();
       $("#myreview .pagination li").not(this).removeClass("active");
       $(this).addClass("active");
       get_review_list();
     });

           /** 직거래 버튼 클릭한 경우  쪽지를 보내는 모달창이 열린다.*/
           $("#send_msg").click(function (e) {
        e.preventDefault();
        var user = $("#user_id").html();
        $("#to_user").html(user);
        $("#background").fadeIn(300);
        $("#front").fadeIn(200);

      });
      $("#send_cancle").click(function (e) {
        $("#send_input").val('');
        $("#background").fadeOut(300);
        $("#front").fadeOut(200);
      });
      $("#send_ok").click(function (e) {
        var input = $("#send_input").val();
      if (!input || input.trim() == "") {
        alert("쪽지 내용을 작성해 주세요.");
        $("#send_input").val('');
        $("#send_input").focus();
        return false;
      }
        $("#send_input").val('');
        $("#background").fadeOut(300);
        $("#front").fadeOut(200);
        swal({
          title: '쪽지를 보냈습니다.',
          text: "쪽지함으로 이동하시겠습니까?",
          confirmButtonText: '쪽지함으로 이동',
          showCancelButton: true,
          cancelButtonText: '이 페이지 계속 보기',
        }).then(function (result) {
          if (result.value) {
            window.open("msgbox.html", "_self");
          } else if (result.dismiss === 'cancel') {
          }
        });
      });
    });
  </script>
</body>

</html>