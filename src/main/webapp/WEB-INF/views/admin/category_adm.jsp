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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>

    <div class="container">
        <div class="row">
            <div class="col-lg-2">
                <%@ include file="/WEB-INF/views/inc/product_adm_left.jsp" %>
            </div>
            <div class="col-lg-10">

                <table class="table">
                    <thead>
                        <tr>
                            <th class="text-center">대분류</th>
                        </tr>
                    </thead>
                    <tbody>
   			
                     <tr id="cate_tr" class="clearfix" >
                        <c:forEach var="item" items="${output}" varStatus="status">	
                            <td class="cate_td">
                            	<input id="del" type="checkbox" name="chkRow" value="${item.cateno}">
                            	<img src="${pageContext.request.contextPath}/assets/img${item.filepath}" alt="${item.name}" />
                            	${item.name}
                            </td>
						</c:forEach>	
					</tr>   

                    </tbody>
                </table>
                
                    <div id="inputbox" >

                        <form id="addForm" class="clearfix" action ="${pageContext.request.contextPath}/Category">
                       		<h4>카테고리 추가</h4>
                        	<div class="item-img">
                                <input type="file" id="photo" name="photo" class="image_plus searchInput" accept="image/*" />
                                <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                            </div>
	                        <input type="text" name="name" class="" id="add_input">
	                        <button id="save"type="submit" class="btn btn-primary">추가</button>
							<button id="delete1" type="button" class="btn btn-warning">삭제</button>
                        </form>
                    </div>
                
        	</div>
    </div>
    </div>


	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

    <!--/.container-->
    <!-- Javascript -->

    <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
    <script type="text/javascript">
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
      
        $(function () {
        	// 카테고리 목록 체크박스 쉽게 하기 
        	$(".cate_td").click(function(){
        		let row = $(this).children("input[type='checkbox']")
        		let chk = row.prop("checked");
        		if (!chk) {
        			row.prop('checked', true);
        		} else {
        			row.prop('checked', false);        			
        		}
        	});

            $(".image_plus").on('change', function () {
                readInputFile(this);
                $(this).parent(".item-img").removeClass("glyphicon glyphicon-camera");
            });

            

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
            	 
            	 if (!confirm("정말 삭제하겠습니까?")) {
            		 return false; 
            	 }
            	 
            	 if($("input").is(":checked") == true) { //체크된 요소가 있으면               
                  	  let count = $("input[name='chkRow']:checked").length;   // 갯수만큼 삭제 실행
                  	  let arr = new Array();	// 체크박스를 담을 배열 객체 생성
                  	  $("input:checked").each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
                            arr.push($(this).val());
                 	  });
						
                  	 $.ajaxSettings.traditional = true;
	            	 //delete 메서드로 Ajax 요청 <form> 전송이 아니므로 직접 구현한다. 
	            	 $.delete("${pageContext.request.contextPath}/Category", {
	            		 "cateno" : arr, "count" : count
	            	 }, function(json) {
	            		 if(json.rt == "OK") {
	            			 alert("삭제되었습니다.");
	            			 //삭제 완료 후 목록 페이지로 이동 
	            			 window.location="${pageContext.request.contextPath}/admin/category_adm.cider";
	            		 }
	            	 });
            	 }
             }); 
             

	});
    </script>

</body>

</html>