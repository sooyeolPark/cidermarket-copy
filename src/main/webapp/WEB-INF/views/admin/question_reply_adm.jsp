<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>일반문의 - 사이다마켓</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/question_reply_adm.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>
	
	<div class="container">
        <div class="row">
            <div class="col-lg-2">
                <%@ include file="/WEB-INF/views/inc/board_adm_left.jsp"%>
            </div>
            <div class="col-lg-10">

                <div>
                    <div class="title_read clearfix">
                    	<div class="page-header">
	                    	<h3>${output.title} 
	                    	<small>작성일 ${output.regdate} | 
	                    	<c:choose>
								<c:when test="${empty output.reply}">답변대기중</c:when>
								<c:otherwise>답변완료</c:otherwise>
							</c:choose>
							</small></h3>
						</div>
                    </div>

                
                    <div class="row1 clearfix">
                    <p class="reply_info col-md-2">
                        <span>이름</span>
                        <span>연락처</span>
                        <span>이메일</span>
                        <span>유형</span>
                    </p>
                    
                    <p class="reply_info col-md-2">
                        <span class="name">${output.name}</span>
                        <span class="phone">${output.tel}</span>
                        <span class="email">${output.email}</span>
                        <span class="name">
                        	<c:if test="${output.category == 'M'}">회원관련</c:if>
                        	<c:if test="${output.category == 'P'}">상품관련</c:if>
                        	<c:if test="${output.category == 'T'}">거래관련</c:if>
                        	<c:if test="${output.category == 'D'}">택배관련</c:if>
                        	<c:if test="${output.category == 'E'}">기타</c:if>
                       	</span>
                    </p>
                </div>
                <div class="content_body col-md-12">
                   	<c:choose>
                   		<%-- 조회결과가 없는 경우 --%>
						<c:when test="${output.filepath == null || fn:length(output.filepath) == 0}">
							<div class="text-center alert alert-info" role="alert">등록된 이미지가 없습니다.</div>
						</c:when>	
						<c:otherwise>
	                    	<div class="text-center first_img"><img src="${pageContext.request.contextPath}/assets/img${output.filepath}" alt="${output.title}" /></div>
						</c:otherwise>
                   	</c:choose>
                   	${output.content}
                </div>
                <hr />
                <form id="editForm" action="${pageContext.request.contextPath}/admin/question">
                	<div class="form-group">
                   		<label for="content" class="control-label">답변 </label>
                    	<textarea id="content" class="form-control ckeditor" rows="3" placeholder="답변을 입력해주세요.">${output.reply}</textarea>
                  	</div>
                    <button id="regi"type="submit" class="btn btn-primary btn-lg">등록</button>
                  </form>

            </div>

            </div>
        </div>
    </div>



    <!--/row-->
    <hr>
	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <!-- jQeury Ajax Form plugin CDN -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
    <!-- CKEditor CDN -->
    <script src="//cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
    <script type="text/javascript">
 	
	$("#editForm").ajaxForm({
		let bbsno = "${output.bbsno}";
		beforeSerialize:function($Form, options){
	        /* Before serialize */
	        for ( instance in CKEDITOR.instances ) {
	            CKEDITOR.instances[instance].updateElement();
	        }
	        return true; 
	    },
		// 전송 메서드 지정
		method: "PUT",
		Data: {"bbsno":bbsno},
		// 서버에서 200 응답을 전달한 경우 실행됨
		success: function(json) {
			console.log(json);
			
			//var contents = CKEDITOR.instances.content.getData();
			
			// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
			if (json.rt == "OK") {
				window.location = "${pageContext.request.contextPath}/admin/question_adm_read.cider?bbsno=" + json.item.bbsno;
			}
		}
	});

    </script>

</body>

</html>