<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
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
                            <a href="${pageContext.request.contextPath}/user/record_sell.cider?selected=selling" class="tab-button-item-link pull-left selected">판매</a>
                        </li>
                        <li role="presentation" class="tab-button-item text-center">
                            <a href="${pageContext.request.contextPath}/user/record_buy.cider?selected=selling" class="tab-button-item-link pull-left">구매</a>
                        </li>
                    </ul>

                    <!-- 거래중/거래완료 sorting -->
                    <div class="recordSort text-center">
                        <a href="#tab-page-1" class="ing btn btn-lg btn-primary" id="selling">거래중</a>
                        <a href="#tab-page-2" class="ing btn btn-lg btn-info" id="sellend">거래완료</a>
                    </div>
                    <!-- 내용영역 -->
                    <div class="tab-panel">
                        <!-- 탭1 -->
                        <div id="tab-page-1">
                            <!-- Ajax 구현 -->
                        </div>
                        <!-- 탭2 -->
                        <div id="tab-page-2" class="hide">
                            <!-- Ajax 구현 -->
                        </div>
                    </div>
                </div>
                
                
            </div>
        </section>
        
        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>
		
		<!-- 직거래시 구매자 선택 모달창 -->
        <a data-toggle="modal" href="#myModal" class="myModal"></a>
        <div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">구매자를 선택해 주세요.</h4>
                    </div>
                    <div class="modal-body">
                        <select name="buy_user" id="buy_user" class="form-control">
                            <option value="">귀염티거</option>
                            <option value="">역삼동그놈</option>
                            <option value="">보리멸치</option>
                        </select>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary btn-block">확인</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- template -->
		<script id="ing_item_tmpl" type="text/x-handlebars-template">
			{{#each ing_item}}
			<div class="col-xs-12 col-sm-6 col-md-6 item-list">
                <div class="sorting itemList">
                    <img alt="{{title}}" class="img-rounded" src="${pageContext.request.contextPath}/assets/{{imgurl}}">
                    <div class="caption">
                        <span class="label {{hidden1}}">{{label1}}</span>
                        <h4><a href="${pageContext.request.contextPath}/user/{{href}}">{{title}}</a></h4>
                        <h4><b>{{price}}</b></h4>
                        <div class="resultBtn">
                            <button type="button" class="ing btn btn-warning recordReturn {{hidden1}}" data-return="{{hidden1}}">반품승인</button>
                            <button type="button" class="ing btn btn-primary recordConfirm" data-decide="{{decide}}">거래확정</button>
                            <button type="button" class="ing btn btn-danger recordReturn {{hidden1}}" data-return="{{hidden1}}">거래취소</button>
                        </div>
                    </div>
                </div>
            </div>
			{{/each}}
        </script>
        <!-- template -->
		<script id="end_item_tmpl" type="text/x-handlebars-template">
			{{#each end_item}}
			<div class="col-xs-12 col-sm-6 col-md-6 item-list">
                <div class="sorting itemList">
                    <img alt="{{title}}" class="img-rounded" src="${pageContext.request.contextPath}/assets/{{imgurl}}">
                    <div class="caption">
                        <span class="label">{{label}}</span>
                        <h4><a href="${pageContext.request.contextPath}/user/{{href}}">{{title}}</a></h4>
                        <h4><b>{{price}}</b></h4>
                        <div class="resultBtn">
                            <button type="button" class="ing btn btn-warning {{hidden1}}" disabled>정산완료</button>
                            <button onclick="location.href='review_write.html'" type="button" class="ing btn btn-primary {{hidden2}}">후기 남기기</button>
                            <button type="button" onclick="location.href='review_view.html'" class="ing btn btn-danger {{hidden3}}">후기 작성완료</button>
                        </div>
                    </div>
                </div>
            </div>
			{{/each}}
		</script>

        <!-- Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
        <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
        <!-- ajax-helper -->
        <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
        <!-- handlebar plugin -->
        <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
        <script type="text/javascript">
            /** AJAX로 JSON데이터를 가져와서 화면에 출력하는 함수 */
            function get_ing_list() {
                $.get("${pageContext.request.contextPath}/assets/plugins/ajax/record_sell_ing.json", function(req) {
                    console.log(req);
                    if (!req) {
                    $("#tab-page-1").append("<p>거래중인 상품이 없습니다.</p>");
                    } else {
                    // 미리 준비한 HTML틀을 읽어온다.
                    var template = Handlebars.compile($("#ing_item_tmpl").html());
                    // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
                    var html = template(req);
                    // #dept_list_body 읽어온 내용을 추가한다.
                    $("#tab-page-1").append(html);
                    }
                });
            }
            function get_end_list() {
                $.get("${pageContext.request.contextPath}/assets/plugins/ajax/record_sell_end.json", function(req) {
                    console.log(req);
                    if (!req) {
                    $("#tab-page-2").append("<p>거래중인 상품이 없습니다.</p>");
                    } else {
                    // 미리 준비한 HTML틀을 읽어온다.
                    var template = Handlebars.compile($("#end_item_tmpl").html());
                    // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
                    var html = template(req);
                    // #dept_list_body 읽어온 내용을 추가한다.
                    $("#tab-page-2").append(html);
                    }
                });
            }

            $(function() {
                get_ing_list();
                get_end_list();
                /** selected 파라미터 받아와서 1차 탭 선택함 */
                var url = new URL(window.location.href);
                var selector = url.searchParams.get("selected");
                $("#"+selector).addClass("btn-primary").removeClass("btn-info");
                $(".recordSort > .btn").not("#"+selector).removeClass("btn-primary").addClass("btn-info");
                /** 선택된 1차 탭의 href값으로 탭 패널 열기 */
                var target = $("#"+selector).attr('href');
                $(target).removeClass('hide');
                $(".tab-panel > div").not($(target)).addClass('hide');

                /** 거래중/거래완료 탭 */
                $(".recordSort > .btn").click(function(e) {
                    e.preventDefault();
                    if ($(this).hasClass("btn-info")) {
                        $(this).addClass("btn-primary").removeClass("btn-info");
                        $(".recordSort > .btn").not(this).removeClass("btn-primary").addClass("btn-info");

                        var target = $(this).attr('href');
                        $(target).removeClass('hide');
                        $(".tab-panel > div").not($(target)).addClass('hide');
                    }
                });
            });

            /** 거래확정 모달 */
            $(document).on("click", ".recordConfirm", function(e) {
                e.preventDefault();
                var ts = $(this)
                var dis = ts.prev('.recordReturn').prop('disabled');
                // 확인, 취소버튼에 따른 후속 처리 구현
                swal({
                    title: '확정',                // 제목
                    text: "거래를 확정 하시겠습니까?",  // 내용
                    type: 'warning',              // 종류
                    confirmButtonText: '예',     // 확인버튼 표시 문구
                    showCancelButton: true,       // 취소버튼 표시 여부
                    cancelButtonText: '아니오',       // 취소버튼 표시 문구
                }).then(function(result) {        // 버튼이 눌러졌을 경우의 콜백 연결
                    if (result.value) {           // 확인 버튼이 눌러진 경우
                        if (ts.prev().data('return') != 'hidden') {
                            if (!dis) {
                                swal('잠깐', '반품요청이 있습니다. 반품 승인/거절 여부 먼저 결정해 주세요.', 'error');
                            } else {
                                ts.parents('.item-list').remove();
                                swal('확정', '성공적으로 확정되었습니다.', 'success');
                            }
                        } else if (ts.data('decide') == 'contact') {
                            $('.myModal').trigger('click');
                        }
                    } else if (result.dismiss === 'cancel') {   // 취소버튼이 눌러진 경우
                        swal('취소', '확정이 취소되었습니다.', 'error');
                    }
                });
            });

            /** 반품확정 */
            $(document).on("click", ".recordReturn", function(e) {
                e.preventDefault();
                var ts = $(this);
                // 확인, 취소버튼에 따른 후속 처리 구현
                swal({
                    title: '반품',                // 제목
                    text: "반품을 승인 하시겠습니까?",  // 내용
                    type: 'warning',              // 종류
                    confirmButtonText: '승인',     // 확인버튼 표시 문구
                    showCancelButton: true,       // 취소버튼 표시 여부
                    cancelButtonText: '거절',       // 취소버튼 표시 문구
                }).then(function(result) {        // 버튼이 눌러졌을 경우의 콜백 연결
                    if (result.value) {           // 확인 버튼이 눌러진 경우
                        swal('승인', '반품을 승인 하셨습니다.', 'success');
                        ts.prop('disabled', true);
                    } else if (result.dismiss === 'cancel') {   // 취소버튼이 눌러진 경우
                        swal('거절', '반품을 거절 하셨습니다.', 'error');
                        ts.prop('disabled', true).html('반품거절');
                    }
                });
            });
        </script>
</body>

</html>