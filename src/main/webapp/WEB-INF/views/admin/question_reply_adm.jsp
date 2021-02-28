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
                    <p class="reply_info col-xs-2">
                        <span>이름</span>
                        <span>연락처</span>
                        <span>이메일</span>
                        <span>유형</span>
                    </p>
                    
                    <p class="reply_info col-xs-3">
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
						<c:when test="${files == null || fn:length(files) == 0}">
							<div class="text-center alert alert-info" role="alert">등록된 이미지가 없습니다.</div>
						</c:when>	
						<c:otherwise>
							<c:forEach var="item" items="${files}" varStatus="status">
	                    	<div class="text-center first_img"><img src="${pageContext.request.contextPath}/assets/img${item.filepath}" alt="${output.title}" /></div>
	                    	</c:forEach>
						</c:otherwise>
                   	</c:choose>
                   	<p>${output.content}</p>
                </div>
                <hr />
                <!-- reply -->
                <div class="panel panel-danger">
                  <div class="panel-heading" id="admin-write"><i class="glyphicon glyphicon-comment"></i> 관리자 답변입니다.</div>
                  <div class="panel-body">
                  <c:if test="${output.reply == null || fn:length(output.reply) == 0}">
                  	<p class="reply-gray">관리자 답변 전입니다.</p>
                  </c:if>
                   	${output.reply}
                  </div>
                </div>
                
                
                <c:choose>
                	<c:when test="${output.reply == null || fn:length(output.reply) == 0}">
	                  <form id="editForm" action="${pageContext.request.contextPath}/admin/question">
	                	<div class="form-group">
	                   		<label for="content" class="control-label">답변 등록</label>
	                   		<input type="hidden" name="bbsno" value="${output.bbsno}" />
	                    	<textarea id="content" class="form-control" name="reply" rows="3" placeholder="답변을 입력해주세요."></textarea>
	                  	</div>
	                  	<div class="text-center">
		                	<button id="regi" type="submit" class="btn btn-primary btn-lg">등록</button>
		                    <button type="button" class="btn btn-lg btn-info" onclick="location.href='${pageContext.request.contextPath}/admin/question_adm.cider'">목록</button>
		               </div>
	                  </form>
                  </c:when>
                  <c:otherwise>
	                  <form id="editForm_re" action="${pageContext.request.contextPath}/admin/question">
	                	<div class="form-group">
	                   		<label for="content" class="control-label">답변 수정</label>
	                   		<input type="hidden" name="bbsno" value="${output.bbsno}" />
	                    	<textarea id="content_re" class="form-control" name="reply" rows="3" placeholder="답변을 수정합니다."></textarea>
	                  	</div>
	                  	<div class="text-center">
		                	<button id="regi_re" type="submit" class="btn btn-warning btn-lg">수정</button>
		                    <button type="button" class="btn btn-lg btn-info" onclick="location.href='${pageContext.request.contextPath}/admin/question_adm.cider'">목록</button>
		               </div>
	                  </form>
                  </c:otherwise>
                 </c:choose>

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
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script type="text/javascript">
    
    $(function(){
    	
 	
    	$("#editForm").submit(function(e) {
         	  e.preventDefault();
		    /** Ajax 호출 */
	        const form = $(this);
	        const url = form.attr('action');
	        const bbsno = $('input[name=bbsno]').val();
	        const reply = $('textarea[name=reply]').val();
	        $.ajax({
	        	beforeSerialize:function($Form, options){
    		        /* Before serialize */
    		        for ( instance in CKEDITOR.instances ) {
    		            CKEDITOR.instances[instance].updateElement();
    		        }
    		        return true; 
    		    },
	            type: "PUT",
	            url: url,
	            data: {"bbsno": bbsno, "reply":reply},
	            success: function(json) {
	  				console.log(json);
	  				alert("답변 완료되었습니다.");
	  				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
	  				if (json.rt == "OK") {
	  					window.location = "${pageContext.request.contextPath}/admin/question_adm_read.cider?bbsno=" + json.item.bbsno;
	  				}
	  			}
	          });
		});
    	
    	
    	$("#editForm_re").submit(function(e) {
       	  e.preventDefault();
		    /** Ajax 호출 */
	        const form = $(this);
	        const url = form.attr('action');
	        const bbsno = $('input[name=bbsno]').val();
	        const reply = $('textarea[name=reply]').val();
	        $.ajax({
	        	beforeSerialize:function($Form, options){
  		        /* Before serialize */
  		        for ( instance in CKEDITOR.instances ) {
  		            CKEDITOR.instances[instance].updateElement();
  		        }
  		        return true; 
  		    },
	            type: "PUT",
	            url: url,
	            data: {"bbsno": bbsno, "reply":reply},
	            success: function(json) {
	  				console.log(json);
	  				alert("수정 완료되었습니다.");
	  				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
	  				if (json.rt == "OK") {
	  					window.location = "${pageContext.request.contextPath}/admin/question_adm_read.cider?bbsno=" + json.item.bbsno;
	  				}
	  			}
	          });
		});

    });
    </script>

</body>

</html>