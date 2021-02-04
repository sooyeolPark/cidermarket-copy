<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
	<title>상품상세 - 사이다마켓</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/item_index.css" />
	<!-- 캐러셀 jqeury plugin 참조 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/swiper/swiper-bundle.css">
	<script src="${pageContext.request.contextPath}/assets/plugins/swiper/swiper-bundle.js"></script>
	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/searchbox.js"></script>
	<!-- ligthbox pulgin 참조 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/lightbox/css/lightbox.css" />
	<script src="${pageContext.request.contextPath}/assets/plugins/lightbox/js/lightbox.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
</head>

<body>
	<!-- 헤더 영역 -->
    <%@ include file="/WEB-INF/views/inc/header.jsp"%>    
    
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
  <div class='over_layer' id="singo">
    <div class="modal_name">신고하기</div>
    <div class="modal_content">
      <form role="form">
        <div class="form-group">
          <span id="singo_name"></span>
          <span class="help-block">게시글을 신고하는 이유를 선택해주세요.</span>
          <select class="form-control" id="singo_category">
            <option selected>신고 이유를 선택해주세요</option>
            <option>판매금지 품목이에요</option>
            <option>거래 게시글이 아니에요</option>
            <option>사기글 같아요</option>
            <option>기타 사유</option>
          </select>
          <textarea rows="2" id="singo_input" class="form-control" placeholder="신고사유를 입력해주세요."></textarea>
          <div class="modal_btn">
            <button id="singo_ok" type="button" class="btn btn-primary">신고하기</button>
            <button id="singo_cancle" type="button" class="btn btn-info">취소</button>
          </div>
        </div>
      </form>
    </div>
  </div>
  <!-- nav 시작 -->
  <header></header>
  <!-- // nav 끝 -->

  <!-- content 시작 -->
  <section>
      <!-- Slider main container -->
      <div class="swiper-container">
        <!-- Additional required wrapper -->
        <div class="swiper-wrapper">
          <!-- Slides -->
          <div class="swiper-slide"><a href="${pageContext.request.contextPath}/assets/img/item.png" data-lightbox="my-gallery">
              <img src="${pageContext.request.contextPath}/assets/img/item.png" width="100%" /></a></div>
          <div class="swiper-slide"><a href="${pageContext.request.contextPath}/assets/img/item.png" data-lightbox="my-gallery">
              <img src="${pageContext.request.contextPath}/assets/img/item.png" width="100%" /></a></div>
          <div class="swiper-slide"><a href="${pageContext.request.contextPath}/assets/img/item.png" data-lightbox="my-gallery">
              <img src="${pageContext.request.contextPath}/assets/img/item.png" width="100%" /></a></div>

        </div>
        <!-- If we need pagination -->
        <div class="swiper-pagination"></div>
      </div>
      <div class="item_title clearfix">
        <span class="label">거의새것</span>
        <span class="label">배송비 미포함</span>
        <a href="#" id="like_this" class="pull-right"><i class="glyphicon glyphicon-heart"></i>32</a>
        <a href="#" id="flag_this" class="pull-right"><i class="glyphicon glyphicon-flag"></i></a>
        <h3>디올 조던 새상품 270 팔아요요리요이료요요요요요오롤로로요로로리이히</h3>
        <h1><b>1,000,000원</b></h1>
      </div>
      <div class="div_blank1"></div>
      <div class="item_info">
        <!-- 탭의 전체 박스 -->
        <div class="tab">
          <!-- 탭 버튼 영역 -->
          <ul class="tab-button clearfix">
            <li class="tab-button-item pull-left">
              <a class="tab-button-item-link selected" href="#tab-page-1">상세설명</a>
            </li>
            <li class="tab-button-item pull-left">
              <a class="tab-button-item-link" href="#tab-page-2">판매자 다른상품</a>
            </li>
          </ul>
          <!-- 내용영역 -->
          <div class="tab-panel">
            <div id="tab-page-1">
              <div class="row how_trade">
                <div class="col-xs-3"><b>거래방법</b></div>
                <div class="col-xs-9"><b>택배거래</b></div>
              </div>
              <div class="row how_trade">
                <div class="col-xs-3"><b>배송비</b></div>
                <div class="col-xs-9"><b>3,000원</b></div>
              </div>
              <div class="info_desc">
                <p>
                  디올 조던 운동화<br />
                  사이즈 270
                  <br />
                  <br />
                  다들 아시는 유명한 디올X조던 콜라보 신발입니다.<br />
                  사이즈는 정사이즈 이고 볼이 좁은편이에요.<br />
                  바닥도 깨끗하고 몇번 신지도 않아서 깔창도 깨끗 무결점 하자 없음<br />
                  <br />
                  ★ 선입금 우선판매하고 예민한 분은 사절<br />
                  ★ 서로 시간낭비없이 살분만 쪽지주세요<br />
                  ★ 거래중 잠수, 무리한네고, 비매너 차단<br />
                  ★ 중고제품이라 작은 오염은 있을 수 있으니 참고하세요. (교환X, 환불X)
                </p>
              </div>
              <div class="info_etc">
                <div class="row">
                  <div class="col-xs-1"><i class="glyphicon glyphicon-time"></i></div>
                  <div class="col-xs-11"><span id="reg_time">38분 전</span></div>
                </div>
                <div class="row">
                  <div class="col-xs-1"><i class="glyphicon glyphicon-link"></i></div>
                  <div class="col-xs-11"><a href="#"><span>#디올조던</span></a><a href="#"><span>#270</span></a><a
                      href="#"><span>#나이키신발</span></a></div>
                </div>
                <div class="row">
                  <div class="col-xs-1"><i class="glyphicon glyphicon-tag"></i></div>
                  <div class="col-xs-11"><a href="#"><span>신발/가방/잡화</span></a>
                  </div>
                </div>
              </div>
              <div class="user_info clearfix">
                <a class="pull-left" href="#"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img/user_thumb1.jpg" width="50"
                    height="50" alt="Generic placeholder image"> </a>
                <div class="user_info_detail clearfix">

                  <div id="user_id"><a href="#">귀염티거</a></div>
                  <div id="user_info_item" class="pull-right">상품 <span>258</span></div>
                  <div id="user_lv">Lv 2 블루</div>
                  <div id="user_star">
                    <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
                    <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
                    <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
                    <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
                    <img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
                  </div>
                  <div id="user_string">6</div>

                </div>

              </div>

              <div class="item-repl">
                <form role="form">
                  <fieldset>
                    <!-- 입력양식 -->
                    <div class="form-group">
                      <label for="content" class="control-label">댓글 <span>(<span
                            id="reply_count">2</span>)</span></label>
                      <textarea id="content" class="form-control" rows="3" placeholder="댓글을 입력해주세요."></textarea>
                    </div>
                    <!--// 입력양식 -->

                    <!-- 입력양식 -->
                    <div class="form-group clearfix">
                      <button type="submit" id="reply_submit" class="btn btn-primary pull-right">등록</button>
                    </div>
                    <!--// 입력양식 -->
                  </fieldset>
                </form>
                <ul class="media-list" id="reply_box">
                  <!-- 목록의 개별 항목이 웹진 박스로 구성됩니다. -->
                  <li class="media">
                    <a class="pull-left" href="#"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img/user_jordan.jpg"
                        width="60" height="60" alt="Generic placeholder image"> </a>
                    <div class="media-body">
                      <!-- 제목영역의 float 처리를 위한 마감제 박스 -->
                      <div class="clearfix">
                        <!-- 제목에 float: left 적용 - pull-left -->
                        <h4 class="media-heading pull-left re_user_name">마이클조던 <small>5분전</small></h4>
                        <!-- 제목에 float: right 적용 - pull-right -->
                        <div class="pull-right">
                          <a class="re_remove" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                        </div>
                      </div>
                      <div class="clearfix re_user_rpl">
                        <p>팔렸나요?</p>
                        <button type="submit" class="btn btn-danger pull-right reply">답글</button>
                        <div class=" repl_form">
                          <form role="form repl_form">
                            <fieldset>
                              <!-- 입력양식 -->
                              <div class="form-group">
                                <textarea class="form-control re_reply" rows="3" placeholder="댓글을 입력해주세요."></textarea>
                              </div>
                              <div class="form-group clearfix">
                                <button type="submit" class="btn btn-default pull-right reply_submit1">등록</button>
                              </div>
                              <!--// 입력양식 -->
                            </fieldset>
                          </form>
                        </div>
                      </div>
                      <div id="reply_div">
                        <div class="media">
                          <a class="pull-left" href="#"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img/user_thumb1.jpg"
                              width="60" height="60" alt="Generic placeholder image"> </a>
                          <div class="media-body">
                            <div class="clearfix">
                              <h4 class="media-heading pull-left re_user_name">귀염티커 <small>1분전</small></h4>
                              <div class="pull-right">
                                <a class="re_remove" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                              </div>
                            </div>
                            <div class="clearfix re_user_rpl">
                              <p>아직이용~</p>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                  <!-- 목록의 개별 항목이 웹진 박스로 구성됩니다. -->
                  <li class="media">
                    <a class="pull-left" href="#"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img/user_adidas.jpg"
                        width="60" height="60" alt="Generic placeholder image"> </a>
                    <div class="media-body">
                      <div class="clearfix">
                        <h4 class="media-heading pull-left re_user_name">아디다스 <small>방금 전</small></h4>
                        <div class="pull-right">
                          <a class="re_remove" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                        </div>
                      </div>
                      <div class="clearfix re_user_rpl">
                        <p>디자인이 좀 아쉽네요...</p>
                        <button type="submit" class="btn btn-danger pull-right reply">답글</button>
                        <div class=" repl_form">
                          <form role="form">
                            <fieldset>
                              <!-- 입력양식 -->
                              <div class="form-group">
                                <textarea class="form-control re_reply" rows="3" placeholder="댓글을 입력해주세요."></textarea>
                              </div>
                              <div class="form-group clearfix">
                                <button type="submit" class="btn btn-default pull-right reply_submit1">등록</button>
                              </div>
                              <!--// 입력양식 -->
                            </fieldset>
                          </form>
                        </div>
                      </div>
                      <div class="reply_div">
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
              <div class="div_blank"></div>
              <div class="item_more ">
                <h3>이런 상품은 어때요?</h3>
                <div class="box clearfix" id="center">
                  <!--handlebars 2 -->
                </div>
              </div>
            </div>
            <div id="tab-page-2" class="hide">
              <h3>귀염티거 님의 다른 상품</h3>
              <div class="box clearfix" id="others">
                <!--handlebars 2 -->
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="anou">
        <p>(주)사이다마켓은 통신판매중개자로서 거래당사자가 아니며,
          <br /> 판매자가 등록한 상품정보 및 거래에 대해 (주)사이다마켓은 일체 책임을 지지 않습니다
        </p>
      </div>
  </section>
  <div class="fixed-btn">
    <div class="col-xs-2 zzim"><a href="#"><i class="glyphicon glyphicon-heart-empty"></i></a></div>
    <div class="col-xs-5"><button type="submit" class="btn btn-warning" id="dir_trade"><span
          class="cool">쿨하게</span><span class="trade">직거래</span></button></div>
    <div class="col-xs-5"><button type="submit" class="btn btn-primary" id="dir_pay"><span class="cool">쿨하게</span><span
          class="trade">바로결제</span></button></div>
  </div>

  <!-- 댓글 템플릿 -->
  <script id="reply_tmpl" type="text/x-handlebars-template">
    <li class="media">
      <a class="pull-left" href="#"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/{{imgurl}}"
          width="60" height="60" alt="Generic placeholder image"> </a>
      <div class="media-body">
        <div class="clearfix">
          <h4 class="media-heading pull-left re_user_name">{{id}} <small>{{time}}</small></h4>
          <div class="pull-right">
            <a class="re_remove" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
          </div>
        </div>
        <div class="clearfix re_user_rpl">
          <p>{{content}}</p>
          <button type="submit" class="btn btn-danger pull-right reply">답글</button>
          <div class=" repl_form">
            <form role="form repl_form">
              <fieldset>
                <div class="form-group">
                  <textarea class="form-control re_reply" rows="3" placeholder="댓글을 입력해주세요."></textarea>
                </div>
                <div class="form-group clearfix">
                  <button type="submit" class="btn btn-default pull-right reply_submit1">등록</button>
                </div>
              </fieldset>
            </form>
          </div>
        </div>
        <div class="reply_div">
        </div>
      </div>
    </li>
  </script>
  <!-- 대댓글 템플릿 -->
  <script id="rereply_tmpl" type="text/x-handlebars-template">
    <div class="media">
      <a class="pull-left" href="#"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/{{imgurl}}"
          width="60" height="60" alt="Generic placeholder image"> </a>
      <div class="media-body">
        <div class="clearfix">
          <h4 class="media-heading pull-left re_user_name">{{id}} <small>{{time}}</small></h4>
          <div class="pull-right">
            <a class="re_remove" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
          </div>
        </div>
        <div class="clearfix re_user_rpl">
          <p>{{content}}</p>
        </div>
      </div>
    </div>
  </script>
  <!-- 상품 리스트 템플릿 -->
  <script id="item_tmpl" type="text/x-handlebars-template">
      {{#each item}}
      <div class="col-xs-6 col-sm-4 col-lg-3 item-list">
                <a href="{{href}}">
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
  <script type="text/javascript">
    //캐러셀 플러그인
    var mySwiper = new Swiper('.swiper-container', {
      loop: true,
      pagination: {
        el: '.swiper-pagination',
        dynamicBullets: 'true'
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
    //라이트박스 플러그인
    lightbox.option({
      albumLabel: ""
    });
    //상품 리스트를 불러오는 함수
    function get_list() {
      $.get("${pageContext.request.contextPath}/assets/plugins/ajax/item_01.json", function (req) {
        // 미리 준비한 HTML틀을 읽어온다.
        var template = Handlebars.compile($("#item_tmpl").html());
        // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
        var html = template(req);
        // #dept_list_body 읽어온 내용을 추가한다.
        $("#center").html(html);
      });
    }
    //현재 시간을 담는 함수
    function get_time() {
      var today = new Date();

      var yy = String(today.getFullYear());
      var mm = String(today.getMonth() + 1);
      var dd = String(today.getDate());
      var hh = String(today.getHours());
      var mi = String(today.getMinutes());
      var ss = String(today.getSeconds());
      if (mm.length == 1) {
        mm = "0" + mm;
      }
      if (dd.length == 1) {
        dd = "0" + dd;
      }
      if (hh.length == 1) {
        hh = "0" + hh;
      }
      if (mi.length == 1) {
        mi = "0" + mi;
      }
      if (ss.length == 1) {
        ss = "0" + ss;
      }
      var now = yy + "." + mm + "." + dd + " " + hh + ":" + mi + ":" + ss;
      return now;
    }


    //현재 접속한 사람의 정보가 담긴 데이터
    var re_content = {
      imgurl: "img/user_jordan.jpg",
      id: "마이클조단",
      time: "",
      content: ""
    };

    $(function () {
      get_list();
      /** 신고하기 링크를 클릭한 경우 */
      $("#flag_this").click(function (e) {
        e.preventDefault();
        var user = $(".item_title>h3").html();
        $("#singo_name").html(user);
        $("#background").fadeIn(300);   // 배경 레이어를 화면에 표시한다.
        $("#singo").fadeIn(200);
      });
      $("#singo_cancle").click(function (e) {
        $("#background").fadeOut(300);
        $("#singo").fadeOut(200);
        $("#singo_input").val('');
        $("#singo_category> option:eq(0)").prop('selected', true);
      });
      $("#singo_ok").click(function (e) {
        swal("신고가 접수되었습니다.");
        $("#background").fadeOut(300);
        $("#singo").fadeOut(200);
        $("#singo_category> option:eq(0)").prop('selected', true);
        $("#singo_input").val('');
      });

      /** 탭 버튼의 클릭 처리 */
      $(".tab-button-item-link").click(function (e) {
        e.preventDefault();

        $(".tab-button-item-link").not(this).removeClass("selected");

        $(this).addClass("selected");

        var target = $(this).attr('href');
        $(target).removeClass('hide');
        $(".tab-panel > div").not($(target)).addClass('hide');

        $.get("${pageContext.request.contextPath}/assets/plugins/ajax/item_01.json", function (req) {
          var template = Handlebars.compile($("#item_tmpl").html());
          var html = template(req);
          $("#others").html(html);
        });

      });

      //찜하기 버튼 누를 시 하트버튼 토글
      $(".zzim>a").click(function (e) {
        e.preventDefault();
        var heart = $(this).find("i").hasClass("glyphicon-heart");
        if (heart) {
          $(this).find("i").removeClass("glyphicon-heart").addClass("glyphicon-heart-empty");
        } else {
          $(this).find("i").removeClass("glyphicon-heart-empty").addClass("glyphicon-heart");
        }
      });

      /** 직거래 버튼 클릭한 경우  쪽지를 보내는 모달창이 열린다.*/
      $("#dir_trade").click(function (e) {
        e.preventDefault();
        var user = $("#user_id>a").html();
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
            window.open("${pageContext.request.contextPath}/user/msgbox.cider", "_self");
          } else if (result.dismiss === 'cancel') {
          }
        });
      });
      // 바로 결제 누를때 주문서 화면으로 이동
      $("#dir_pay").click(function (e) {
        e.preventDefault();
        window.open("${pageContext.request.contextPath}/user/order_sheet.cider", "_self");
      });

      // 답글 달기
      $("#reply_submit").click(function (e) {
        e.preventDefault();
        var input = $("#content").val();
        if (!input || input.trim() == "") {
          swal("댓글 내용을 작성해 주세요.");
          $("#content").val("");
          $("#content").focus();
          return false;
        }
        re_content.content = input;
        swal({
          title: '댓글을 등록하시겠습니까?',
          text: re_content.content,
          confirmButtonText: '등록',
          showCancelButton: true,
          cancelButtonText: '취소',
        }).then(function (result) {
          if (result.value) {
            re_content.time = get_time();

            var template = Handlebars.compile($("#reply_tmpl").html());
            var html = template(re_content);
            $("#reply_box").append(html);
            $("#content").val('');
            //댓글 개수를 다시 세어 표시
            var re_count = $("#reply_box>li").length;
            $("#reply_count").html(re_count);
          } else if (result.dismiss === 'cancel') {
          }
        });

      });
    }); //온로드 제이쿼리 끝
    //답글 버튼 클릭시 입력창 토글
    $(document).on('click', '.reply', function (e) {
      e.preventDefault();
      $(this).next().slideToggle(300);
    });
    //대댓글 달기
    $(document).on('click', '.reply_submit1', function (e) {
      e.preventDefault();
      var input = $(this).parent().prev().find(".re_reply").val();
      if (!input || input.trim() == "") {
        swal("댓글 내용을 작성해 주세요.");
        $(this).parent().prev().find(".re_reply").val("");
        $(this).parent().prev().find(".re_reply").focus();
        return false;
      }
      re_content.content = input;
      var is_ok = confirm("댓글을 등록하시겠습니까?");
      if (is_ok) {
        re_content.time = get_time();
        var template = Handlebars.compile($("#rereply_tmpl").html());
        var html = template(re_content);
        $(this).parents(".re_user_rpl").next().append(html);
        $(this).parent().prev().find(".re_reply").val('');
      } else {
        $(this).parent().prev().find(".re_reply").val('');
      }


    });
    // 댓글 삭제
    $(document).on('click', '.re_remove', function (e) {
      e.preventDefault();
      var is_ok = confirm("댓글을 삭제하시겠습니까?");
      if (is_ok) {
        $(this).parent().parent().parent().parent().remove();
        //댓글 개수를 다시 세어 표시
        var re_count = $("#reply_box>li").length;
        $("#reply_count").html(re_count);
      } else {

      }
    });
  </script>
</body>

</html>