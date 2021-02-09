<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
<title>관리자 카테고리 - 사이다마켓</title>
    <!-- 나눔고딕 웹 폰트 적용 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/category_adm.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header&footer_adm.css" />
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
                    <a href="${pageContext.request.contextPath}/admincategory_adm.cider" class="list-group-item">
                        <p>상품분류</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/display_adm.cider" class="list-group-item">
                        <p>상품진열</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/singo_adm.html" class="list-group-item">
                        <p>신고상품<span class="badge"> 10</span></p>
                    </a>
                </nav>


            </div>
            <div class="col-lg-10">




                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th class="text-center">대분류</th>
                     
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="cate_tr" class="clearfix" >
                            <td class="text-center cate_td"><input type="checkbox">핸드메이드</td>
                            <td class="text-center cate_td"><input type="checkbox">휴대폰/태블릿</td>
                            <td class="text-center cate_td"><input type="checkbox">가구</td>
                            <td class="text-center cate_td"><input type="checkbox">문구</td>
                            <td class="text-center cate_td"><input type="checkbox">자동차용품</td>
                            <td class="text-center cate_td"><input type="checkbox">유아용/완구</td>
                            <td class="text-center cate_td"><input type="checkbox">컴퓨터/주변기기</td>
                            <td class="text-center cate_td"><input type="checkbox">생활</td>
                            <td class="text-center cate_td"><input type="checkbox">스타굿즈</td>
                            <td class="text-center cate_td"><input type="checkbox">반려동물용품</td>
                            <td class="text-center cate_td"><input type="checkbox">뷰티</td>
                            <td class="text-center cate_td"><input type="checkbox">카메라</td>
                            <td class="text-center cate_td"><input type="checkbox">여성의류</td>
                            <td class="text-center cate_td"><input type="checkbox">디지털/가전</td>
                            <td class="text-center cate_td"><input type="checkbox">피규어/키덜트</td>
                            <td class="text-center cate_td"><input type="checkbox">스포츠/레저</td>
                            <td class="text-center cate_td"><input type="checkbox">남성의류</td>
                            <td class="text-center cate_td"><input type="checkbox">티켓</td>
                            <td class="text-center cate_td"><input type="checkbox">예술/미술</td>
                            <td class="text-center cate_td"><input type="checkbox">게임</td>
                            <td class="text-center cate_td"><input type="checkbox">신발/가방/잡화</td>
                            <td class="text-center cate_td"><input type="checkbox">음향기기/악기</td>
                            <td class="text-center cate_td"><input type="checkbox">도서</td>
                            <td class="text-center cate_td"><input type="checkbox">기타</td>
                            
                        </tr>    


                    </tbody>
                </table>
                
                    <div id="inputbox" >
                        <input type="file" id="image0" class="image_plus " accept="image/*"/>
                        <input type="text" class="form-control" id="revise">
                    </div>
                
                    <div class="regi_cancel">
                        <button id="delete1"type="button" class="btn btn-danger">삭제</button>
                        <button id="revise1"type="button" class="btn btn-warning">수정</button>
                        <button id="add1"type="button" class="btn btn-primary">추가</button>

                    </div>
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
    <link rel="stylesheet" href="vplugins/ajax/ajax_helper.css" />
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script id="category_tmpl" type/x-handlebars-template">
    


    </script>
    <script type="text/javascript">
        $(function () {
            // 등록 이미지 등록 미리보기
            function readInputFile(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(input).css('background-image', 'url(\"' + e.target.result + '\")');
                        $(input).next().css('display', 'inline');
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }

            $(".image_plus").on('change', function () {
                readInputFile(this);
            });

            $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('login_adm.html'); 
                }else{

                }
            });

    //   추가,수정,삭제 ajax 기능 넣기 핸들바 아마
    //추가
    $("#add1").click(function(){
            var td_new = $('<td>');
            td_new.addClass("text-center cate_td");
            //input은 input에 있는 텍스트 내용 
            var input = $("#revise").val()
            //<td cate_td> </td> 태그안에 input val값을 쓰기한다. 
            td_new.html(input);
            //<td cate_td> 태그앞에 체크박스 추가한다. 
            td_new.prepend('<input type=checkbox>');
            
            // cate table row 마지막에 td_new를 추가한다. 
            $("#cate_tr").append(td_new);
        });

        //클릭시 포커스 
        $(".cate_td").click(function(e){
            $("#revise").focus();
        });

        // 클릭시 내용 보여줌 
        $(".cate_td").click(function(e){
            // var idx = $(this).index();
            // var td = '"td"+idx';
            var cate = $(this).html();
            var cate2=cate.substring(23);
         
            
        $("#revise").val(cate2);
        });

        
  
        
        // 버튼삭제이벤트
        $("#delete1").click(function(e){
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
                        var i = $("input:checked").parent("td");
                       i.remove();
                    
                    }else {
                    swal("삭제할 항목을 선택해주세요!")
                  }
                        }

                });
                
            });

            //수정하기
            $("#revise1").click(function(e){
                e.preventDefault();
                swal({ 
                title: '확인',
                text: "정말 수정 하시겠습니까?" ,
                type:'warning', //종류
                confirmButtonText:'네', //확인버튼 표시문구
                showCancelButton:true, //취소버튼 표시여부
                cancelButtonText:'아니오', //취소버튼 표시문구 
                }).then(function(result){
                    if(result.value) {
                        var parent_td = $("input:checked").parent("td");
                        var i = $("#revise").val();
                        parent_td.html(i);
                        parent_td.prepend('<input type=checkbox>');
                    
                    }else {
                    swal("수정할 항목을 선택해주세요!")
                  }

                });
                
             });



});
    </script>

</body>

</html>