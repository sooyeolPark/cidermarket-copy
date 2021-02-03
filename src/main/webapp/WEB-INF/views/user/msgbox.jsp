<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>쪽지함 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/msgbox.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
  <!-- 헤더 영역 -->
  <%@ include file="/WEB-INF/views/inc/header.jsp"%>

  <section>
      <!-- 화면에 표시될 원본 보기 영역 - 기본적으로 숨겨진 상태이다. -->
  <div class='gray_layer' id='background'></div>
  <div class='over_layer' id='front'>
    <div id="modal_name">쪽지보내기</div>
        <div id="modal_content">
            <form role="form">
                <div class="form-group">
                    <span id="to_user">고양이</span>
                    <span class="help-block">님에게 쪽지보내기</span>
                    <textarea rows="5" id="send_input" class="form-control" placeholder="내용을 입력해주세요."></textarea>
                    <div class="modal_btn">
                        <button id="send_ok" type="button" class="btn btn-primary">확인</button>
                        <button id="send_cancle" type="button" class="btn btn-info">취소</button>
                    </div>
                </div>
            </form>
        </div>
  </div>
    <div class="container">
      <div id="msgbox_subject">
        쪽지함
      </div>
      <div id="msgbox_desc">
        *쪽지는 50일 후 자동삭제됩니다. 중요한 쪽지는 보관함에 보관하세요.
      </div>
    </div>
    <ul class="nav nav-tabs" id="msg_tabs">
      <li class="active col-sm-4 in_msg"><a href="#">받은쪽지</a></li>
      <li class="col-sm-4 out_msg"><a href="#">보낸쪽지</a></li>
      <li class="col-sm-4 store_msg"><a href="#">쪽지보관함</a></li>
    </ul>
    <!--// 탭 메뉴 끝 -->
    <!-- 탭 화면 시작 -->
    <div class="container">
      <div id="msgbox_index">
        <table id="msgbox_table">
        </table>
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
  <script id="msgbox_tmpl01" type="text/x-handlebars-template">
    {{#each msg}}
    <tr>
      <td class="msgbox_num">{{@key}}</td>
      <td class="msgbox_subject"><a href="#" class="clk_tr"><span class="user_id">{{id}}</span> 님이 <span class="msg_cont">[{{subject}}]</span> 상품에 대해 보낸 쪽지</a></td>
      <td class="msg_date">{{date}}</td>
    </tr>
    <tr class="msgbox_content">
      <td colspan="3" class="clearfix">
        <p>
        {{content}}
        </p>
        <a href=# class="msg_btn_list pull-right delete">삭제</a>
        <a href=#  class="msg_btn_list pull-right reply">답장</a>
        <a href=#  class="msg_btn_list pull-right store">보관</a>              
      </td>
    </tr>
    {{/each}}
  </script>
  <!-- template 2 -->
  <script id="msgbox_tmpl02" type="text/x-handlebars-template">
    {{#each msg}}
    <tr>
      <td class="msgbox_num">{{@key}}</td>
      <td class="msgbox_subject"><a href="#" class="clk_tr"><div class="user_id">{{id}}</div> 님에게 <div class="msg_cont">[{{subject}}]</div> 상품에 대해 보낸 쪽지</a></td>
      <td class="msg_date">{{date}}</td>
    </tr>
    <tr class="msgbox_content">
      <td colspan="3" class="clearfix">
        <p>
        {{content}}
        </p>
        <a href=# class="msg_btn_list pull-right delete">삭제</a>
        <a href=# class="msg_btn_list pull-right store">보관</a>              
      </td>
    </tr>
    {{/each}}
  </script>
  <!-- template 3 -->
  <script id="msgbox_tmpl03" type="text/x-handlebars-template">
      {{#each msg}}
      <tr>
        <td class="msgbox_num">{{@key}}</td>
        <td class="msgbox_subject"><a href="#" class="clk_tr">{{{store}}}</a></td>
        <td class="msg_date">{{date}}</td>
      </tr>
      <tr class="msgbox_content">
        <td colspan="3" class="clearfix">
          <p>
          {{content}}
          </p>
          <a href=# class="msg_btn_list pull-right delete">삭제</a>             
        </td>
      </tr>
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
    function get_list_01() {
      $.get("${pageContext.request.contextPath}/assets/plugins/ajax/msgbox01.json", function (req) {
        // 미리 준비한 HTML틀을 읽어온다.
        var template = Handlebars.compile($("#msgbox_tmpl01").html());
        // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
        var html = template(req);
        // #dept_list_body 읽어온 내용을 추가한다.
        $("#msgbox_table").html(html);
      });
    }
    function get_list_02() {
      $.get("${pageContext.request.contextPath}/assets/plugins/ajax/msgbox02.json", function (req) {
        // 미리 준비한 HTML틀을 읽어온다.
        var template = Handlebars.compile($("#msgbox_tmpl02").html());
        // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
        var html = template(req);
        // #dept_list_body 읽어온 내용을 추가한다.
        $("#msgbox_table").html(html);
      });
    }
    function get_list_03() {
      $.get("${pageContext.request.contextPath}/assets/plugins/ajax/msgbox03.json", function (req) {
        // 미리 준비한 HTML틀을 읽어온다.
        var template = Handlebars.compile($("#msgbox_tmpl03").html());
        // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
        var html = template(req);
        // #dept_list_body 읽어온 내용을 추가한다.
        $("#msgbox_table").html(html);
      });
    }
    $(function () {
      get_list_01();
      $(".in_msg").click(function (e) {
        $(this).addClass('active');
        $(".nav-tabs li").not(this).removeClass('active');
        get_list_01();
      });
      $(".out_msg").click(function (e) {
        $(this).addClass('active');
        $(".nav-tabs li").not(this).removeClass('active');
        get_list_02();
      });
      $(".store_msg").click(function (e) {
        $(this).addClass('active');
        $(".nav-tabs li").not(this).removeClass('active');
        get_list_03();
      });

      $(".pagination li").click(function (e) {
        e.preventDefault();
        $(".pagination li").not(this).removeClass("active");
        $(this).addClass("active");
      });

      $("#send_cancle").click(function (e) {
                $("#send_input").val('');
                $("#background").fadeOut(300);
                $("#front").fadeOut(200);
            });
      $("#send_ok").click(function (e) {
                swal("쪽지를 보냈습니다.");
                $("#send_input").val('');
                $("#background").fadeOut(300);
                $("#front").fadeOut(200);
            });
    });
    $(document).on('click', '.clk_tr', function (e) {
      e.preventDefault();
      $(this).parents("tr").next().slideToggle(200);
      $(".msgbox_content").not($(this).parents("tr").next()).css('display', 'none');
    });
    $(document).on('click', '.delete', function (e) {
      e.preventDefault();
      var target = $(this);
      swal({
        title: '삭제',                // 제목
        text: "쪽지를 삭제 하시겠습니까?",  // 내용
        type: 'warning',              // 종류
        confirmButtonText: '예',     // 확인버튼 표시 문구
        showCancelButton: true,       // 취소버튼 표시 여부
        cancelButtonText: '아니오',       // 취소버튼 표시 문구
      }).then(function (result) {        // 버튼이 눌러졌을 경우의 콜백 연결
        if (result.value) {           // 확인 버튼이 눌러진 경우
          target.parents("tr").prev().remove();
          target.parents("tr").remove();
          swal('확정', '성공적으로 삭제되었습니다.', 'success');
        } else if (result.dismiss === 'cancel') {   // 취소버튼이 눌러진 경우
          swal('취소', '삭제가 취소되었습니다.', 'error');
        }
      });

    });
    $(document).on('click', '.reply', function (e) {
      var user = $(this).parents("tr").prev().find(".user_id").html();
      $("#to_user").html(user);
      $("#background").fadeIn(300);
      $("#front").fadeIn(200);
    });
  </script>
</body>

</html>