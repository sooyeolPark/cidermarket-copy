<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>관리자 공지사항 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/notice_read_adm.css" />
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

                <div>
                    <div class="title_read clearfix">
                        <div class="page-header">
                        	<h3>${output.title} <small>작성일 ${output.editdate} | 조회수 ${output.hits}</small></h3>
                        </div>
                    </div>
                    <div class="content_body">
                    	<c:choose>
                    		<%-- 조회결과가 없는 경우 --%>
							<c:when test="${output.path == null || fn:length(output.path) == 0}">
								<div class="text-center alert alert-info" role="alert">등록된 이미지가 없습니다.</div>
							</c:when>	
							<c:otherwise>
		                    	<div class="text-center"><img src="${pageContext.request.contextPath}/assets/${output.path}" alt="${output.title}" /></div>
							</c:otherwise>
                    	</c:choose>
                    	${output.content}
                   	</div>
					<hr />
                    <form class="form-inline text-right">
                        <div class="regi_cancel">
                            <a class="btn btn-default" href="${pageContext.request.contextPath}/admin/notice/list.cider?bbsno=${output.bbsno}" role="button">목록</a>
                            <a class="btn btn-warning" href="${pageContext.request.contextPath}/admin/notice/edit.cider?bbsno=${output.bbsno}" role="button">수정</a>
                            <a href="#" id="deleteNotice" class="btn btn-danger" data-bbsno="${output.bbsno}" data-title="${output.title}">삭제</a>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>

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

	        // 게시글 삭제
	        $("#deleteNotice").click(function(e) {
				e.preventDefault();  // 링크 클릭에 대한 페이지 이동 방지
				
				let current = $(this);  // 이벤트가 발생한 객체 자신 ==> <a>태그
	            let bbsno = current.data('bbsno');     // data-bbsno 값을 가져옴
	            let title = current.data('title');       // data-title 값을 가져옴
	            let target = "[" + bbsno + "] " + title;
	            
	            // 삭제 확인
	            if (!confirm("정말 " + target + " 글을 삭제하시겠습니까?")) {
	                return false;
	            }
	            // delete 메서드로 Ajax 요청 --> <form> 전송이 아니므로 직접 구현한다.
	            $.delete("${pageContext.request.contextPath}/admin/notice.cider", {
	                "bbsno": bbsno
	            }, function(json) {
	                if (json.rt == "OK") {
	                    alert("삭제되었습니다.");
	                    // 삭제 완료 후 목록 페이지로 이동
	                    window.location = "${pageContext.request.contextPath}/admin/notice/list.cider";
	                }
	            });
			});
    	});
    </script>
</body>
</html>