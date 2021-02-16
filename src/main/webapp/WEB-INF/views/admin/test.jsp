<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
<title>관리자 카테고리 - 사이다마켓</title>
    <!-- 나눔고딕 웹 폰트 적용 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/category_adm.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header&footer_adm.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
    

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
                        <c:forEach var="item" items="${output}" varStatus="status">   
                            <td id="deleteCategory" class="text-center cate_td" ><input type="checkbox">${item.name}</td>
                  		</c:forEach>   
               		 </tr>   
                    </tbody>
                </table>
                </div>
                
                    <div>
                       <!--  <input type="file" id="image0" class="image_plus " accept="image/*"> -->
        
                        <form id="addForm" action ="${pageContext.request.contextPath}/Category">
                           <input type="text" name="name" class="form-control" id="add">
                           <button id="save"type="submit" class="btn btn-primary">추가</button>
                        </form>
                    </div>
                        
                     <div>
                   
                         <form id="editForm" action ="${pageContext.request.contextPath}/Category">
                           <input type="text" name="name" class="form-control" id="revise">
                           <button id="save"type="submit" class="btn btn-warning">수정</button>
                        </form>
                     </div> 
                    
           
       </div>
    </div>


   <%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

    <!--/.container-->
    <!-- Javascript -->

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
    <script type="text/javascript">
        $(function () {
    // 등록 이미지 등록 미리보기
/*           function readInputFile(input) {
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
 */
    //   추가,수정,삭제 ajax 기능 넣기 핸들바 아마
    //추가
/*     $("#add1").click(function(){
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
            
            $.ajax({
               url: '/Category' //서버에 전달할 파일명 
               dataType:'text',
               type:'post',
               data: {
                  'input'
               }
            });
            
        });  */
    
       //addForm에 대한 submit 이벤트를 가로채서 Ajax 요청을 전송ㅎㄴ다. 
        $("#addForm").ajaxForm({
            // 전송 메서드 지정
            method: "POST",
            // 서버에서 200 응답을 전달한 경우 실행됨
            success: function(json) {
                console.log(json);
                
                // json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
                if (json.rt == "OK") {
                    window.location = "${pageContext.request.contextPath}/admin/category_adm.cider";
                }
            }
        });
       
/*         $("#editForm").ajaxForm({
            // 전송 메서드 지정
            method: "PUT",
            // 서버에서 200 응답을 전달한 경우 실행됨
            success: function(json) {
                console.log(json);
                alert("테스트");
                
                // json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
                if (json.rt == "OK") {
                    window.location = "${pageContext.request.contextPath}/admin/category_adm.cider";
                }
            }
        }); */
        
      //클릭시 포커스 
        $(".cate_td").click(function(e){
            $("#revise").focus();
        });

        // 클릭시 내용 보여줌 
        $(".cate_td").click(function(e){
            // var idx = $(this).index();
            // var td = '"td"+idx';
            var cate = $(this).html();
     //       var cate2=cate.substring(23);
         
            
        $("#revise").val(cate2);
        });
        
        
       //삭제기능
/*        $("#deleteCategory").click(function(e){
           e.preventDefault(); //링크 클릭에 대한 이동방지 
           
           let current = $(this); //이벤트가 발생한 객체 자신 
           let cateno = current.val();
        
           
           //삭제 확인 
           if (!confirm("정말" + cateno "을 삭제하겠습니까?")){
              return false; 
           }
           
           $.delete("${pageContext.request.contextPath}/Category", {
              "cateno" : cateno
           }, function(json) {
              if(json.rt =="OK") {
                 alert("삭제되었습니다.");
                 //삭제 완료 후 목록 페이지로 이동 
                 window.location = "${pageContext.request.contextpath}/admin/category_adm.cider";
              }
           });
        });
  */
        
  
        
 /*        // 버튼삭제이벤트
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
                
             }); */
            
  



});
    </script>

</body>

</html>