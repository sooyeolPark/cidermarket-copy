<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>관리자 공지사항 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/notice_write_adm.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>
	
    <div class="container">
        <div class="row">
            <div class="col-lg-2">
                <!-- 목록의 아이템 -->
        		<%@ include file="/WEB-INF/views/inc/board_adm_left.jsp"%>
            </div>
            
            <div class="col-lg-10">

                <form class="form-horizontal" id="editForm" role="form" enctype=“multipart/form-data” action="${pageContext.request.contextPath}/admin/notice.cider">
      	        	<% /* action 페이지에서 사용할 WHERE 조건값을 hidden 필드로 숨겨서 전송한다. */ %>
	   				<input type="hidden" name="bbsno" value="${output.bbsno}" />
                    <fieldset>
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="subject" class="col-md-2 control-label">게시판유형</label>
                            <div class="col-md-2">
                                <select class="form-control clearfix">
                                    <option value="N" <c:if test="${output.type == 'N'}">selected</c:if>>공지사항</option>
                                    <option value="Q" <c:if test="${output.type == 'Q'}">selected</c:if>>일반문의</option>
                                    <option value="E" <c:if test="${output.type == 'E'}">selected</c:if>>이벤트</option>
                                </select>
                            </div>
                        </div>
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="title" class="col-md-2 control-label">글 제목</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" name="title" id="title" value="${output.title}" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="content" class="col-md-2 control-label">내용</label>
                            <div class="col-md-10">
                                <textarea id="content" name="content" class="ckeditor">${output.content}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="file" class="col-md-2 control-label">파일첨부</label>
                            <div class="col-md-2">
                                <input type="file" id="file" name="file" accept="image/png, image/jpeg">
                            </div>
                        </div>
                        <hr />
                        <div class="text-right">
	                        <a href="${pageContext.request.contextPath}/admin/notice/list.cider" class="btn btn-default">목록</a>
	                        <button id="regi" type="submit" class="btn btn-warning">수정</button>
	                        <button id="cancel" type="reset" class="btn btn-danger">취소</button>
                        </div>
                        <!--// 입력양식 -->
                    </fieldset>
                </form>

            </div>
        </div>
    </div>

    <!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <!-- jQeury Ajax Form plugin CDN -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
    <!-- CKEditor CDN -->
    <script src="//cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
    <script type="text/javascript">
        $(function () {
            //로그아웃
            $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result == true) {
                    location.replace('${pageContext.request.contextPath}/admin/login_adm.cider'); 
                }
            });

            $("#cancel").click(function(e){
                e.preventDefault();
                swal({ 
                title: '취소',
                text: "취소 하시겠습니까?" ,
                type:'warning', //종류
                confirmButtonText:'네', //확인버튼 표시문구
                showCancelButton:true, //취소버튼 표시여부
                cancelButtonText:'아니오', //취소버튼 표시문구 
                }).then(function(result){
                    if(result.value) {
                        window.open("${pageContext.request.contextPath}/admin/notice/list.cider", "_self");
                    } else {
                     swal("취소하였습니다.")
                    }
                 });
             });
                        
        	// #addForm에 대한 submit이벤트를 가로채서 Ajax요청을 전송한다.
    		$("#editForm").ajaxForm({
    			beforeSerialize:function($Form, options){
    		        /* Before serialize */
    		        for ( instance in CKEDITOR.instances ) {
    		            CKEDITOR.instances[instance].updateElement();
    		        }
    		        return true; 
    		    },
    			// 전송 메서드 지정
    			method: "PUT",
    			// 서버에서 200 응답을 전달한 경우 실행됨
    			success: function(json) {
    				console.log(json);
    				
    				var contents = CKEDITOR.instances.content.getData();
    				alert(contents);
    				
    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
    				if (json.rt == "OK") {
    					window.location = "${pageContext.request.contextPath}/admin/notice/view.cider?bbsno=" + json.item.bbsno;
    				}
    			}
    		});
    	});
    </script>
</body>
</html>