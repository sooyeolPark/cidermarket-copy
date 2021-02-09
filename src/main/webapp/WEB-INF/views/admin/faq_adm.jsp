<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
<title>관리자 자주묻는질문 - 사이다마켓</title>


    <!-- 나눔고딕 웹 폰트 적용 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/faq_adm.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header&footer_adm.css" />
    <link rel="stylesheet" href="plugins/sweetalert/sweetalert2.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />

</head>

<body>

<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>

    <div class="container">
        <div class="row">
            <div class="col-lg-2">
                <%@ include file="/WEB-INF/views/admin/board_adm_left.jsp"%>
            </div>
            <div class="col-lg-10">
 

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input id="all-check" type="checkbox"></th>
                            <th class="text-center">번호</th>
                            <th class="text-center">제목</th>
                            <th class="text-center">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input class="board"type="checkbox"></td>
                            <td class="text-center">1</td>
                            <td class="text-center"><a href="notice_read_adm.html">[택배] 사이다택배는 택배비가 무조건 2,000원인가요?</a></td>
                            <td class="text-center">2020.12.21</td>
                        </tr>
                        <tr>
                            <td><input class="board"type="checkbox"></td>
                            <td class="text-center">2</td>
                            <td class="text-center"><a href="notice_read_adm.html">[택배] 사이다택배 이용절차가 어떻게 되나요?</a></td>
                            <td class="text-center">2020.12.21</td>
                        </tr>
                        <tr>
                            <td><input class="board"type="checkbox"></td>
                            <td class="text-center">3</td>
                            <td class="text-center"><a href="notice_read_adm.html">[상품] 어떻게 하면 더 잘 팔릴 수 있나요?</a></td>
                            <td class="text-center">2020.12.21</td>
                        </tr>
                        <tr>
                            <td><input class="board"type="checkbox"></td>
                            <td class="text-center">4</td>
                            <td class="text-center"><a href="notice_read_adm.html">[상품] 판매할 물건은 어떻게 올리나요?</a></td>
                            <td class="text-center">2020.12.21</td>
                        </tr>
                        <tr>
                            <td><input class="board"type="checkbox"></td>
                            <td class="text-center">5</td>
                            <td class="text-center"><a href="notice_read_adm.html">[상품] 카테고리 종류를 알려주세요</a></td>
                            <td class="text-center">2020.12.21</td>
                        </tr>
                        <tr>
                            <td><input class="board"type="checkbox"></td>
                            <td class="text-center">6</td>
                            <td class="text-center"><a href="notice_read_adm.html">[상품] 판매금지 상품이 있나요?</a></td>
                            <td class="text-center">2020.12.21</td>
                        </tr>
                        <tr>
                            <td><input class="board"type="checkbox"></td>
                            <td class="text-center">7</td>
                            <td class="text-center"><a href="notice_read_adm.html">[상품] 반려동물 분양글을 등록해도 되나요?</a></td>
                            <td class="text-center">2020.12.21</td>
                        </tr>
                        <tr>
                            <td><input class="board"type="checkbox"></td>
                            <td class="text-center">8</td>
                            <td class="text-center"><a href="notice_read_adm.html">[상품] 상품을 수정/삭제 하고 싶어요</a></td>
                            <td class="text-center">2020.12.21</td>
                        </tr>
                        <tr>
                            <td><input class="board"type="checkbox"></td>
                            <td class="text-center">9</td>
                            <td class="text-center"><a href="notice_read_adm.html">[상품] 홈 화면에 보이는 상품은 어떻게 올리나요?</a></td>
                            <td class="text-center">2020.12.21</td>
                        </tr>
                        <tr>
                            <td><input class="board"type="checkbox"></td>
                            <td class="text-center">10</td>
                            <td class="text-center"><a href="notice_read_adm.html">[상품] 내 상품을 공유하고 싶어요</a></td>
                            <td class="text-center">2020.12.21</td>
                        </tr>



                        

                    </tbody>
                </table>
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="button"><span
                                class="glyphicon glyphicon-search"></span></button>
                    </div>
                    <input type="text" class="form-control" id="search_btn" placeholder="키워드를 입력하세요">
                    <button id="delete"class="btn btn-warning"  role="button">삭제</button>
                </div>
                <ul class="pagination">
                    <li class="disabled"><a href="#">&laquo;</a></li>
                    <!-- 활성화 버튼은 아래의 구조로 구성하시면 됩니다. sr-only는 스크린리더 전용 입니다 .-->
                    <li class="active"><span>1 <span class="sr-only">(current)</span></span></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li><a href="#">&raquo;</a></li>
                </ul>
            </div>
        </div>
    </div>


<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>


    <!--/.container-->
    <!-- Javascript -->

    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/searchbox.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
    <script type="text/javascript">
        $(function () {
  



            // 추가기능------------------------------------------------------------
         //필터 
            

        // 로그아웃
        $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('login_adm.html'); 
                }else{

                }
            });
      $("#delete").click(function () {
        swal({ 
          title: '확인',
          text: "정말 삭제 하시겠습니까?" ,
          type:'warning', //종류
          confirmButtonText:'네', //확인버튼 표시문구
          showCancelButton:true, //취소버튼 표시여부
          cancelButtonText:'아니오', //취소버튼 표시문구 
        });
        // .then(function(result){
        //   if(result.value) {   //확인버튼이 눌러진 경우 
        //     swal('로그아웃', '로그아웃 되었습니다.', 'success');
        //   } else if(result.dismiss==='cancel') {  //취소버튼 눌러진경우 
        //     swal('취소', '취소하였습니다.', 'error');
        //   }
        // });
      });

    //   전체선택
      $("#all-check").change(function(){
          $(".board").prop('checked',$(this).prop('checked'));
      });

    });

    </script>

</body>

</html>