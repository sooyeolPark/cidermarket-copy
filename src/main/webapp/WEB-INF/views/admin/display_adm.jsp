<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
<title>관리자 진열관리 - 사이다마켓</title>

    <!-- 나눔고딕 웹 폰트 적용 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/display_adm.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header&footer_adm.css" />
</head>

<body>
<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>


    <div class="container">
        <div class="row">
            <div class="col-lg-2">
                <nav class="list-group">
                    <!-- 목록의 아이템 -->
                    <p>상품관리</p>
                    <a href="${pageContext.request.contextPath}/admin/product_adm.cider" class="list-group-item">
                        <p>상품목록</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/category_adm.html" class="list-group-item">
                        <p>상품분류</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/display_adm.html" class="list-group-item">
                        <p>상품진열</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/singo_adm.html" class="list-group-item">
                        <p>신고상품<span class="badge"> 10</span></p>
                    </a>
                </nav>
            </div>
            <div class="col-lg-10">

                <div class="title-menu clearfix">
                    <h4>상품진열</h4>
                    <select class="form-control" id="align-number">
                        <option value="1">10개씩보기</option>
                        <option value="2">20개씩보기</option>
                    </select>
                    <select class="form-control" id="align-menu">
                        <option value>작성일순</option>
                        <option value="lowprice">조회수순</option>
                    </select>
                </div>


                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th class="text-center">번호</th>
                            <th class="text-center">상품제목</th>
                            <th class="text-center">판매자</th>
                            <th class="text-center">카테고리</th>
                            <th class="text-center">수정</th>
                        </tr>
                    </thead>
                    <tbody id="board_body">
                        <tbody id="result"></tbody>
                   </tbody>
                   
                </table>
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="button">
                            <span class="glyphicon glyphicon-search"></span></button>
                    </div>
                    <input type="text" class="form-control" id="search_btn" placeholder="키워드를 입력하세요">
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
    <!-- 유효성검사 -->
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>

    <script id="board_tmpl" type="x-handlebars-template">
        {{#boardlist}}
        <tr>
                <td class="text-center board-group-item">{{no}}</td>
                <td class="text-center"><a href="{{url}}"></a>{{subject}}</td>
                <td class="text-center board-group-item">{{id}}</td>
                <td class="text-center board-group-item">
                                <select class="form-control" id="category">
                                    <option >핸드메이드</option>
                                    <option >휴대폰/태블릿</option>
                                    <option >가구</option>
                                    <option >문구</option>
                                    <option >자동차용품</option>
                                    <option >유아용/완구</option>
                                    <option >컴퓨터/주변기기</option>
                                    <option >생활</option>
                                    <option >스타굿즈</option>
                                    <option >반려동물용품</option>
                                    <option >뷰티</option>
                                    <option >카메라</option>
                                    <option >여성의류</option>
                                    <option >디지털/가전</option>
                                    <option >피규어/키덜트</option>
                                    <option >스포츠/레저</option>
                                    <option >남성의류</option>
                                    <option >티켓</option>
                                    <option >예술/미술</option>
                                    <option >게임</option>
                                    <option >신발/가방/잡화</option>
                                    <option >음향기기/악기</option>
                                    <option >도서</option>
                                    <option >기타</option>
                                </select>
                            </td>
                <td class="text-center board-group-item ">
                <button type="submit" class="btn btn-primary">저장</button>
                </td>
        </tr>
        {{/boardlist}}
    </script>
     <script id="board_tmpl2" type="x-handlebars-template">
            {{#boardlist}}
            <tr>
                <td class="text-center">{{no}}</td>
                <td class="text-center"><a href="{{url}}"></a>{{subject}}</td>
                <td class="text-center">{{id}}</td>
                <td class="text-center">
                                <select class="form-control" id="category">
                                    <option >핸드메이드</option>
                                    <option >휴대폰/태블릿</option>
                                    <option >가구</option>
                                    <option >문구</option>
                                    <option >자동차용품</option>
                                    <option >유아용/완구</option>
                                    <option >컴퓨터/주변기기</option>
                                    <option >생활</option>
                                    <option >스타굿즈</option>
                                    <option >반려동물용품</option>
                                    <option >뷰티</option>
                                    <option >카메라</option>
                                    <option >여성의류</option>
                                    <option >디지털/가전</option>
                                    <option >피규어/키덜트</option>
                                    <option >스포츠/레저</option>
                                    <option >남성의류</option>
                                    <option >티켓</option>
                                    <option >예술/미술</option>
                                    <option >게임</option>
                                    <option >신발/가방/잡화</option>
                                    <option >음향기기/악기</option>
                                    <option >도서</option>
                                    <option >기타</option>
                                </select>
                            </td>
                <td class="text-center ">
                <button type="submit" class="btn btn-primary">저장</button>
                </td>
        </tr>
            {{/boardlist}}
        </script>
    <script type="text/javascript">

            $(document).on('click','.btn-primary', function(e){
               swal({ 
                title: '확인',
                text: "정말 저장 하시겠습니까?" ,
                type:'warning', //종류
                confirmButtonText:'네', //확인버튼 표시문구
                showCancelButton:true, //취소버튼 표시여부
                cancelButtonText:'아니오', //취소버튼 표시문구 
                });
            });

            
        $(function () {


           // 추가기능------------------------------------------------------------
         //필터 


        // 로그아웃
        $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('${pageContext.request.contextPath}/admin/login_adm.cider'); 
                }else{

                }
            });
      $(".btn-danger").click(function () {
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

      $(".rollback").click(function () {
        swal({ 
          title: '확인',
          text: "정말 복구 시키시겠습니까?" ,
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

                    // --------------------------------------------추가기능-------------------------------------

    //   드롭다운의 변경이벤트
    $("#align-number").change(function(){
            $("#result").empty(); //결과가 표시될 #result에 내용 지우기 
            var choice=$(this).find("option:selected").val(); //사용자선택값 가져오기
            if (!choice) {//선택값이 없다면 처리 중단 
                return false; 
            }

            //ajax요청
            else if (choice==2) {
            $.get('${pageContext.request.contextPath}/assets/plugins/ajax/display_adm.json', function(req){
                var template= Handlebars.compile($("#board_tmpl").html());
                var html = template(req);
                $("#result").append(html);
            });
            }else if(choice==1) {
                 $(".board-group-item").detach();
                } // class가 "hello"인 요소를 모두 삭제한다.

        });



            // --------게시글 불러오기-----
            $.get("${pageContext.request.contextPath}/assets/plugins/ajax/display_adm.json", function (req) {
                // 미리 준비한 HTML틀을 읽어온다.
                var template = Handlebars.compile($("#board_tmpl2").html());
                // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
                var html = template(req);
                // #dept_list_body 읽어온 내용을 추가한다.
                $("#board_body").html(html);
            });


      $(".btn-primary").click(function () {
        swal({ 
          title: '확인',
          text: "저장 하시겠습니까?" ,
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



    });

    </script>

</body>

</html>