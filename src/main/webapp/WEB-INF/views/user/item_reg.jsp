<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>상품등록 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/item_reg.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <div class='gray_layer' id='background'>
        <div id="modal_name">태그입력</div>
        <div id="modal_content">
            <form role="form">
                <div class="form-group">
                    <span class="help-block">- 특수문자와 공백은 입력하실 수 없습니다.</span>
                    <span class="help-block">- 각 태그는 최대 10자까지 입력할 수 있습니다.</span>
                    <span class="help-block">- 판매하는 상품과 연관없는 태그 입력시 제재를 받을 수 있습니다.</span>
                    <div class="input-group">
                        <input type="text" maxlength="10" id="tag_input" class="form-control"
                            placeholder="태그를 입력해 주세요" />
                    </div>
                    <div class="modal_btn">
                        <button id="tag_ok" type="button" class="btn btn-primary">확인</button>
                        <button id="tag_cancle" type="button" class="btn btn-info">취소</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

    <section>
        <div class="container">
            <div id="reg_subject">
                상품 등록
            </div>
            <div id="reg_cont">
                <div class="reg_name">상품사진</div>
                <form id="item_img_group" enctype=“multipart/form-data” role="form">
                <div id="item_img1" class="col-xs-3 item-img">
                    <div id=first_img>대표</div><input type="file" id="image0" class="image_plus " accept="image/*" />

                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>

                </div>
                <div id="item_img2" class="col-xs-3 item-img"><input type="file" id="image1" class="image_plus "
                        accept="image/*" />
                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                </div>
                <div id="item_img3" class="col-xs-3 item-img"><input type="file" id="image2" class="image_plus "
                        accept="image/*" />
                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                </div>
                <div id="item_img4" class="col-xs-3 item-img"><input type="file" id="image3" class="image_plus "
                        accept="image/*" />
                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                </div>
                <div id="item_img5" class="col-xs-3 item-img"><input type="file" id="image4" class="image_plus "
                        accept="image/*" />
                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                </div>
                <div id="item_img6" class="col-xs-3 item-img"><input type="file" id="image5" class="image_plus "
                        accept="image/*" />
                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                </div>
                <div id="item_img7" class="col-xs-3 item-img"><input type="file" id="image6" class="image_plus "
                        accept="image/*" />
                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                </div>
                <div id="item_img8" class="col-xs-3 item-img"><input type="file" id="image7" class="image_plus "
                        accept="image/*" />
                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                </div>
                </form>
            </div>


            <div id="reg_info">
                <div class="reg_name">상품정보</div>
                <form class="form-horizontal" role="form">
                    <fieldset>
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="item_subject" class="col-sm-2 control-label">제목</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="item_subject" placeholder="상품 제목을 입력해주세요.">
                            </div>
                        </div>
                        <!--// 입력양식 -->
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="item_categoty" class="col-sm-2 control-label">카테고리</label>
                            <div class="col-sm-5">
                                <select class="form-control" id="item_categoty">
                                    <option selected>카테고리</option>
                                    <option>핸드메이드</option>
                                    <option>휴대폰/태블릿</option>
                                    <option>가구</option>
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
                        <!--// 입력양식 -->
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="item_content" class="col-sm-2 control-label">설명</label>
                            <div class="col-sm-10">
                                <textarea id="item_content" class="form-control" rows="5"
                                    placeholder="상품 설명을 입력해주세요."></textarea>
                            </div>
                        </div>
                        <!--// 입력양식 -->
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="item_tag" class="col-sm-2 control-label">연관태그<small>(선택)</small></label>
                            <div class="col-sm-10">
                                <button id="item_tag" class="btn btn-info">태그입력</button>
                                <ul class="list-inline tag_list">

                                </ul>
                            </div>
                        </div>
                        <!--// 입력양식 -->
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="item_stat" class="col-sm-2 control-label">상태</label>
                            <div class="col-sm-10">
                                <button id="item_new" class="btn btn-info btn-list active">새상품</button>
                                <button id="item_alnew" class="btn btn-info btn-list">거의새것</button>
                                <button id="item_used" class="btn btn-info btn-list">중고</button>
                            </div>
                        </div>
                        <!--// 입력양식 -->
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="item_price" class="col-sm-2 control-label">가격</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="item_price" placeholder="가격을 입력해주세요.">
                                <div class="won">원</div>
                            </div>
                        </div>
                        <!-- //입력양식 -->
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="optionsRadios1" class="col-sm-2 control-label">거래방법</label>
                            <div class="col-sm-10">

                                <label class="radio-inline">
                                    <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1"
                                        checked>
                                    택배거래 </label>


                                <label class="radio-inline">
                                    <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                    직거래 </label>


                                <label class="radio-inline">
                                    <input type="radio" name="optionsRadios" id="optionsRadios3" value="option3">
                                    상관 없음 </label>

                            </div>
                        </div>
                        <!-- //입력양식 -->
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="item_delfee" class="col-sm-2 control-label">배송비</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="item_delfee" placeholder="가격을 입력해주세요.">
                                <div class="won">원</div>
                            </div>
                        </div>
                        <!-- //입력양식 -->
                    </fieldset>
                </form>
            </div>

            <div id="final">
                <form role="form">
                    <fieldset>
                        <button id="allow" type="button" class="btn btn-primary btn-block">
                            상 품 등 록
                        </button>
                    </fieldset>
                </form>
            </div>
        </div>

        <div id="anou">
            <p>(주)사이다마켓은 통신판매중개자로서 거래당사자가 아니며,
                <br /> 판매자가 등록한 상품정보 및 거래에 대해 (주)사이다마켓은 일체 책임을 지지 않습니다
            </p>
        </div>
    </section>
    
    <!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>
	
    <script id="tag_list_tmpl" type="text/x-handlebars-template">

	<li>{{content}}<a class="remove_tag" href="#"><i class="glyphicon glyphicon-remove"></i></a></li>
	
</script>
    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <!-- handlebar plugin -->
    <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#allow").click(function (e) {
                e.preventDefault();
                window.open("", "_self");
            });
            //사진 등록

            // 버튼 토글
            $(".btn-list").click(function (e) {
                e.preventDefault();
                $(".btn-list").not(this).removeClass('active');
                $(this).toggleClass('active');
            });
            // 등록 이미지 등록 미리보기
            function readInputFile(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(input).css('background-image', 'url(\"' + e.target.result + '\")');
                        $(input).next().css('display', 'block');
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }

            $(".image_plus").on('change', function () {
                readInputFile(this);
            });

            //등록 이미지 삭제
            function resetInputFile($input) {
                var agent = navigator.userAgent.toLowerCase();
                if ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1)) {
                    // ie 일때
                    $input.replaceWith($input.clone(true));

                } else {
                    //other
                    $input.val("");

                }
            }
            $(".remove_img").click(function (e) {
                e.preventDefault();
                var ok = confirm("사진을 삭제하시겠습니까?");
                if (ok) {
                    $(this).css('display', 'none');
                    $(this).prev().css('background-image', 'url("${pageContext.request.contextPath}/assets/img/img_plus.png")');
                    var $input = $(this).prev();
                    resetInputFile($input);
                }

            });
            $("#tag_input").keyup(function (e) {
                // 특수문자 정규식 변수(공백 포함)
                var replaceChar = /[~!@\#$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}\s]/gi;
                var input = $("#tag_input").val();
                if (input.match(replaceChar)) {
                    alert("특수문자 및 공백은 사용하실 수 없습니다.");
                    $("#tag_input").val(input.replace(replaceChar, ''));
                }
            });
            $("#tag_ok").click(function (e) {
                e.preventDefault();
                var input = $("#tag_input").val();
                if (!input) {
                    alert("태그를 입력해 주세요");
                    $("#tag_input").focus();
                    $("#tag_input").val('');
                    return false;
                }
                var replaceChar = /[~!@\#$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}\s]/gi;
                if (input.match(replaceChar)) {

                    alert("특수문자 및 공백은 사용하실 수 없습니다.");
                    $("#tag_input").focus();
                    $("#tag_input").val(input.replace(replaceChar, ''));
                    return false;
                }
                for (var i = 0; i < 5; i++) {
                    var tag_val = $(".tag_list>li").eq(i).html();
                    input_chk = input + "<a class=\"remove_tag\" href=\"#\"><i class=\"glyphicon glyphicon-remove\"></i></a>"
                    if (input_chk == tag_val) {
                        alert("중복된 태그입니다.");
                        $("#tag_input").focus();
                        $("#tag_input").val('');
                        return false;
                    }
                }
                if ($(".tag_list>li").length >= 5) {
                    alert("태그는 최대 5개까지만 입력 가능합니다.");
                    return false;
                }
                var li = { content: input };
                var template = Handlebars.compile($("#tag_list_tmpl").html());
                var html = template(li);
                $(".tag_list").append(html);
                $("#tag_input").val('');

                $("#background").fadeOut(300);
            });

            $(document).on("click", ".remove_tag", function (e) {
                e.preventDefault();
                $(this).parent().remove();
            });

            $("#item_tag").click(function (e) {
                e.preventDefault();
                $("#background").fadeIn(300);
                $("#tag_input").focus();

            });

            $("#tag_cancle").click(function (e) {
                $("#tag_input").val('');
                $("#background").fadeOut(300);
            });
        });
    </script>
</body>

</html>