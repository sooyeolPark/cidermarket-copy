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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header_footer_adm.css" />
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
                            <td class="text-center cate_td"><input id="del" type="checkbox" value="${item.cateno}">${item.name}</td>
						</c:forEach>	
					</tr>   

                    </tbody>
                </table>
                
                    <div id="inputbox" >

                        <form id="addForm" class="clearfix" action ="${pageContext.request.contextPath}/Category">
                        	<input type="file" id="image0" class="image_plus " accept="image/*"/>	
	                        <input type="text" name="name" class="" id="add_input">
	                        <button id="save"type="submit" class="btn btn-primary">추가</button>
	                        
                        </form>
						<button id="delete1"type="submit" class="btn btn-danger">삭제</button>
                    </div>
                
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
/*   			function readInputFile(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(input).css('background-image', 'url(\"' + e.target.result + '\")');
                        $(input).next().css('display', 'inline');
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            });

            $(".image_plus").on('change', function () {
                readInputFile(this);
            }); 
            

            $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('login_adm.html'); 
                }else{

                }
            });   */

    
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
	    

             $("#delete1").click(function(e) {
            	 e.preventDefault(); //링크 클릭에 대한 페이지 이동 방지 
            	 
            	 if($("input").is(":checked") == true){ //체크된 요소가 있으면               
                  var cateno = $("input:checked").val();
                 
            	 }

            	 if (!confirm("정말" + cateno+"번 항목을 삭제하겠습니까?")) {
            		 return false; 
            	 }
            	 
            	 //delete 메서드로 Ajax 요청 <form> 전송이 아니므로 직접 구현한다. 
            	 $.delete("${pageContext.request.contextPath}/Category", {
            		 "cateno" : cateno
            	 }, function(json) {
            		 if(json.rt == "OK") {
            			 alert("삭제되었습니다.");
            			 //삭제 완료 후 목록 페이지로 이동 
            			 window.location="${pageContext.request.contextPath}/admin/category_adm.cider";
            		 }
            	 });
             }); 
             

});
    </script>

</body>

</html>