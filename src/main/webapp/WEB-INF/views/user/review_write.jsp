<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>거래후기 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                <h3 class="text-center">거래후기</h3>

                <!-- 탭의 전체 박스 -->
                <div class="clearfix">
                    <!-- view -->
                    <div class="panel panel-default user-write">
                        <!-- Default panel contents -->
                        <div class="panel-heading boardTitle-view" id="user-write">
                          <a href="${pageContext.request.contextPath}/user/item_index.cider" class="clearfix">
                            <span class="boardImg"><img src="${pageContext.request.contextPath}/assets/img/item.png" alt="디올 조던 팝니다"></span>
                            <span class="boardTitle">디올 조던 팝니다</span>
                            <span class="boardDate">1,000,000원</span>
                          </a>                            
                        </div>
                        <div class="panel-body">
                          <div class="foryou">To. <b>귀염티거</b>님과 거래가 어떠셨나요?</div>
                          <form id="review-form" role="form" enctype="multipart/form-data">
                            <div class="reviewStar text-center">
                              <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점" data-star="1">
                              <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점" data-star="2">
                              <img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점" data-star="3">
                              <img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점" data-star="4">
                              <img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점" data-star="5">
                            </div>
                            <div class="form-group">
                              <label for="content" class="sr-only">내용</label>
                              <textarea name="content" id="content" maxlength="200" class="form-control" placeholder="내용을 입력해 주세요."></textarea>
                              <span class="help-block">* 200자 이내</span>
                            </div>
                            <!-- 사진첨부 -->
                            <div class="form-group">
                              <label for="file" class="sr-only">사진첨부</label>
                              <div class="col-xs-3 item-img glyphicon glyphicon-camera">
                                <input type="file" id="file1" name="file1" class="image_plus" accept="image/*" />
                                <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                              </div>
                              <div class="col-xs-3 item-img glyphicon glyphicon-camera">
                                <input type="file" id="file2" name="file2" class="image_plus" accept="image/*" />
                                <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                              </div>
                              <div class="col-xs-3 item-img glyphicon glyphicon-camera">
                                <input type="file" id="file3" name="file3" class="image_plus" accept="image/*" />
                                <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                              </div>
                              <div class="col-xs-3 item-img glyphicon glyphicon-camera">
                                <input type="file" id="file4" name="file4" class="image_plus" accept="image/*" />
                                <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                              </div>
                            </div>
                            <!-- button -->
                            <div class="text-center">
                                <button
                                    type="button"
                                    class="btn btn-lg btn-danger"
                                    onclick="javascript:history.back()">돌아가기</button>
                                <button
                                    type="submit"
                                    class="btn btn-lg btn-primary">등록하기</button>
                            </div>
                          </form>
                        </div>
                    </div>
                </div>

            </div>
        </section>

        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

        <!-- Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
        <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>
        <script type="text/javascript">
            $(function () {
                /** sorting */
                $(".recordSort > .btn").click(function (e) {
                    e.preventDefault();
                    if ($(this).hasClass("btn-info")) {
                        $(this)
                            .addClass("btn-primary")
                            .removeClass("btn-info");
                        $(".recordSort > .btn")
                            .not(this)
                            .removeClass("btn-primary")
                            .addClass("btn-info");
                    }
                });

                // 별점
                $(".reviewStar > img").click(function(){
                  $(this).parent().children('img').attr('src', '${pageContext.request.contextPath}/assets/img/star_blank.png');
                  $(this).attr('src', '${pageContext.request.contextPath}/assets/img/star_full.png').prevAll('img').attr('src', '${pageContext.request.contextPath}/assets/img/star_full.png');
                  return false;
                });
                
                // 유효성 검사
                $("#review-form").submit(function(e) {
                  e.preventDefault();
                  if (!regex.value('#content', '내용을 입력하세요.')) { return false; }
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
                    $(this).parent(".item-img").removeClass("glyphicon glyphicon-camera");
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
            });
        </script>
</body>

</html>