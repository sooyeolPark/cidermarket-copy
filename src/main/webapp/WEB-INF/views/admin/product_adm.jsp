<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html>

<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>상품관리 - 사이다마켓</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/product_adm.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header&footer_adm.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.23/datatables.min.css"/>
    <!-- 반응형 웹을 지원하지 않을 경우 -->
    <!-- <link rel="stylesheet" href="assets/css/non-responsive.css" /> -->
    <!-- IE8 이하 버전 지원 -->
    <!--[if lt IE 9]>
<script type="text/javascript" src="assets/js/html5shiv.js"></script>
<script type="text/javascript" src="assets/js/respond.min.js"></script>
<![endif]-->
    <!-- IE10 반응형 웹 버그 보완 -->
    <!--[if gt IE 9]>
<link rel="stylesheet" type="text/css" href="assets/css/ie10.css" />
<script type="text/javascript" src="assets/js/ie10.js"></script>
<![endif]-->
</head>


<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>

    <div class="container">
        <div class="row">
            <div class="col-lg-2">
                    <nav class="list-group">
                        <!-- 목록의 아이템 -->
                        <p>상품관리</p>
                        <a href="${pageContext.request.contextPath}/assets/admin/product_adm.cider" class="list-group-item">
                            <p>상품목록</p>
                        </a>
                        <a href="${pageContext.request.contextPath}/assets/admin/category_adm.cider" class="list-group-item">
                            <p>상품분류</p>
                        </a>
                        <a href="${pageContext.request.contextPath}/assets/admin/display_adm.cider" class="list-group-item">
                            <p>상품진열</p>
                        </a>
                        <a href="${pageContext.request.contextPath}/assets/admin/singo_adm.cider" class="list-group-item">
                            <p>신고상품<span class="badge"> 10</span></p>
                        </a>
                   
                </nav>


            </div>
            <div class="col-lg-10">
            
                <div class="title-menu clearfix">
                    <h4>상품목록</h4>
                    <select class="form-control" id="align-number">
                        <option value="1">10개씩보기</option>
                        <option value="2">20개씩보기</option>
                    </select>
                    <select class="form-control" id="align-menu">
                        <option value="">기본정렬</option>
                        <option value="">상품명순</option>
                        <option value="">등록일순</option>
                        <option value="">거래정지순</option>

                    </select>
                </div>


                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input type="checkbox"></th>
                            <th class="text-center">번호</th>
                            <th class="text-center">상품제목</th>
                            <th class="text-center">카테고리</th>
                            <th class="text-center">상품가격</th>
                            <th class="text-center">거래방법</th>
                            <th class="text-center">등록일</th>
                            <th class="text-center">상태</th>
                        </tr>
                    </thead>
                    <tbody id="board_body">
                        <tbody id="result">
                        </tbody>
                    </tbody>
                </table>
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="button"><span
                                class="glyphicon glyphicon-search"></span></button>
                    </div>
                    <input type="text" class="form-control" id="search_btn" placeholder="키워드를 입력하세요">
                    <button class="btn btn-danger" type="submit" id="delete">삭제</button>
                    <button class="btn btn-primary" type="submit" id="re-start">거래재개</button>
                    <button class="btn btn-warning" type="submit" id= "stop">거래정지</button>
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
	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

    <!--/.container-->
    <!-- handlebars template -->
    <script id="proadm_tmpl" type="text/x-handlebars-template">
        <!-- //게시판 -->
        {{#item}}
        <tr>
            <td class="text-center"><input type="checkbox"></td>
            <td class="text-center">{{plus @key}}</td>
            <td class="text-center"><a href="{{url}}">{{subject}}</a></td>
            <td class="text-center">{{ctg}}</td>
            <td class="text-center">{{price}}원</td>
            <td class="text-center">{{convertHow how}}</td>
            <td class="text-center">{{date}}</td>
            {{#if (clr state)}}<td class="text-center">{{convertStat state}}</td>
            {{else}}<td style="color:red;" class="text-center"><b>{{convertStat state}}</b></td>{{/if}}
        </tr>
        {{/item}}
      </script>

    <!-- //20개보기 -->
      <script id="proadm_tmpl2" type="text/x-handlebars-template">
        {{#item}}
        <tr>
            <td><input type="checkbox" class="board-group-item"></td>
            <td class="text-center board-group-item">{{plus @key}}</td>
            <td class="text-center board-group-item"><a href="{{url}}">{{subject}}</a></td>
            <td class="text-center board-group-item">{{ctg}}</td>
            <td class="text-center board-group-item">{{price}}원</td>
            <td class="text-center board-group-item">{{convertHow how}}</td>
            <td class="text-center board-group-item">{{date}}</td>
            {{#if (clr state)}}<td class="text-center board-group-item">{{convertStat state}}</td>
            {{else}}<td style="color:red;" class="text-center board-group-item"><b>{{convertStat state}}</b></td>{{/if}}
        </tr>
        {{/item}}
      </script>
    <!-- Javascript -->
  <!-- ajax-helper -->
  <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
  <!-- handlebar plugin -->
  <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
  <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <script type="text/javascript">
    Handlebars.registerHelper('plus', function(h) {
            return 1+h;
        });
    /** handlebars 플러그인 안에 convertHow라는 함수를 추가하기 */
    Handlebars.registerHelper('convertHow', function(h) {
            if (h == "t") {
                return "택배거래";
            } else {
                return "직거래";
            }
        });
         /** handlebars 플러그인 안에 convertStat라는 함수를 추가하기 */
    Handlebars.registerHelper('convertStat', function(s) {
            if (s == "y") {
                return "거래중";
            } else {
                return "거래정지";
            }
        });
        /** handlebars 플러그인 안에 convertStat라는 함수를 추가하기 */
    Handlebars.registerHelper('clr', function(s) {
            if (s=="y"){
                return true;
            } else{ return false;}
        });
        function get_list() {
      $.get("${pageContext.request.contextPath}/assets/plugins/ajax/proadm.json", function (req) {
        // 미리 준비한 HTML틀을 읽어온다.
        var template = Handlebars.compile($("#proadm_tmpl").html());
        // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
        var html = template(req);
        // #dept_list_body 읽어온 내용을 추가한다.
        $("#board_body").html(html);
      });
    }

    
        
        $(function () {
            get_list();
            $("thead input").change(function(){
                var chk = $(this).prop('checked');
                $("tbody input").prop('checked', chk);
            });
            $("#delete").click(function(e){
                e.preventDefault();
                var is_ok = confirm("선택하신 게시글을 삭제하시겠습니까?");
                if (is_ok) {
                    if($("input").is(":checked") == true){ //체크된 요소가 있으면               
                        var i = $("input:checked").parents("tr");
                       i.remove();
                    
                    }else {
                    alert("삭제할 항목을 선택해주세요!")

                    }
                }
            });

            $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('${pageContext.request.contextPath}/admin/login_adm.cider'); 
                }else{

                }
            });

      $("#re-start").click(function () {
        swal({ 
          title: '확인',
          text: "거래재개 하시겠습니까?" ,
          type:'warning', //종류
          confirmButtonText:'네', //확인버튼 표시문구
          showCancelButton:true, //취소버튼 표시여부
          cancelButtonText:'아니오', //취소버튼 표시문구 
        });
      });

      $("#stop").click(function () {
        swal({ 
          title: '확인',
          text: "거래정지 하시겠습니까?" ,
          type:'warning', //종류
          confirmButtonText:'네', //확인버튼 표시문구
          showCancelButton:true, //취소버튼 표시여부
          cancelButtonText:'아니오', //취소버튼 표시문구 
        });
      });

                  //   드롭다운의 변경이벤트
             $("#align-number").change(function(){
            $("#result").empty(); //결과가 표시될 #result에 내용 지우기 
            var choice=$(this).find("option:selected").val(); //사용자선택값 가져오기
            if (!choice) {//선택값이 없다면 처리 중단 
                return false; 
            }

            //ajax요청
            else if (choice==2) {
            $.get('${pageContext.request.contextPath}/assets/plugins/ajax/proadm.json', function(req){
                var template= Handlebars.compile($("#proadm_tmpl2").html());
                var html = template(req);
                $("#result").append(html);
            });
            }else if(choice==1) {
                 $(".board-group-item").detach();
                } // class가 "hello"인 요소를 모두 삭제한다.

              });
            
        });
        
    </script>

</body>

</html>