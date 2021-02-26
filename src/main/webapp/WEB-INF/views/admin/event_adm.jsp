<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
<title>관리자 이벤트관리 - 사이다마켓</title>


    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/event_adm.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header_footer_adm.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />

</head>

<body>
<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>


    <div class="container">
        <div class="row">
            <div class="col-lg-2">
                <%@ include file="/WEB-INF/views/inc/board_adm_left.jsp"%>
            </div>
            <div class="col-lg-10">
            
                <div class="title-menu clearfix">
                    <h4>이벤트 게시판</h4>
                    <select class="form-control" id="align-number">
                        <option value="1">10개씩보기</option>
                        <option value="2">20개씩보기</option>
                    </select>
                    <select class="form-control" id="align-menu">
                        <option >작성일순</option>
                        <option value="lowprice">조회수순</option>
                    </select>
                </div>


                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input id="all-check" type="checkbox"></th>
                            <th class="text-center">번호</th>
                            <th class="text-center">제목</th>
                            <th class="text-center">작성자</th>
                            <th class="text-center">작성일</th>
                            <th class="text-center">조회수</th>
                        </tr>
                    </thead>
                    <tbody id="board_body">
                        <tbody id="result"></tbody>
                   </tbody>
                </table>
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="button"><span
                                class="glyphicon glyphicon-search"></span></button>
                    </div>
                    <input type="text" class="form-control searchInput" id="search_btn" placeholder="키워드를 입력하세요">
                    <a class="btn btn-primary" href="notice_write_adm.html" role="button">글쓰기</a>
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



    <!--/row-->
    <hr>
    <footer class="footer">

        <!-- <a href="#" class="btn btn-primary btn-sm">
                    <span class="glyphicon glyphicon-triangle-left"></span> 이전
                  </a>
                  <a href="#" class="btn btn-primary btn-sm">
                    <span class="glyphicon glyphicon-triangle-right"></span> 다음
                  </a> -->

        <address>
            <strong>&copy; (주)사이다마켓.All right reserved</strong><br>
        </address>
    </footer>

    <!--/.container-->
    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
    <!-- 유효성검사 -->
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>

    <script id="board_tmpl" type="x-handlebars-template">
        {{#boardlist}}
        <tr>
        <td><input type="checkbox" class="board board-group-item"/></td>
        <td class="text-center board-group-item">{{number}}</td>
        <td class="text-center board-group-item"><a href="{{url}}">{{title}}</a></td>
        <td class="text-center board-group-item">{{writer}}</td>
        <td class="text-center board-group-item">{{date}}</td>
        <td class="text-center board-group-item">{{hit}}</td>
        </tr>
        {{/boardlist}}
    </script>
      <script id="board_tmpl2" type="x-handlebars-template">
            {{#boardlist}}
            <tr>
            <td><input type="checkbox" class="board "/></td>
            <td class="text-center ">{{number}}</td>
            <td class="text-center "><a href="{{url}}">{{title}}</a></td>
            <td class="text-center ">{{writer}}</td>
            <td class="text-center ">{{date}}</td>
            <td class="text-center ">{{hit}}</td>
            </tr>
            {{/boardlist}}
        </script>
    <script type="text/javascript">
        $(function () {

        // 로그아웃
        $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('${pageContext.request.contextPath}/admin/login_adm.cider'); 
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
            $.get('${pageContext.request.contextPath}/assets/plugins/ajax/board_list.json', function(req){
                var template= Handlebars.compile($("#board_tmpl").html());
                var html = template(req);
                $("#result").append(html);
            });
            }else if(choice==1) {
                 $(".board-group-item").detach();
                } // class가 "hello"인 요소를 모두 삭제한다.

        });



        // 버튼삭제이벤트
        $("#delete").click(function(e){
                e.preventDefault();
                swal({ 
                title: '확인',
                text: "정말 삭제 하시겠습니까?" ,
                type:'warning', //종류
                confirmButtonText:'네', //확인버튼 표시문구
                showCancelButton:true, //취소버튼 표시여부
                cancelButtonText:'아니오', //취소버튼 표시문구 
                }).then(function(result){
                    if(result.value) {

                        if($("input").is(":checked") == true){ //체크된 요소가 있으면               
                        var i = $("input:checked").parents("tr");
                       i.remove();
                    
                    }else {
                    swal("삭제할 항목을 선택해주세요!")
                }
                        }

                });
                
            });

            // --------게시글 불러오기-----
            $.get("${pageContext.request.contextPath}/assets/plugins/ajax/board_list.json", function (req) {
                // 미리 준비한 HTML틀을 읽어온다.
                var template = Handlebars.compile($("#board_tmpl2").html());
                // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
                var html = template(req);
                // #dept_list_body 읽어온 내용을 추가한다.
                $("#board_body").html(html);
            });


    });

    </script>


</body>

</html>