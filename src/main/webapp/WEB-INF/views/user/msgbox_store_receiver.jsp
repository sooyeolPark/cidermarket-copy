<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>쪽지함 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/msgbox.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
  <!-- 헤더 영역 -->
  <%@ include file="/WEB-INF/views/inc/header.jsp"%>

  <section>
    <div class="container">
      <div id="msgbox_subject">
        쪽지함
      </div>
      <div id="msgbox_desc">
        *쪽지는 50일 후 자동삭제됩니다. 중요한 쪽지는 보관함에 보관하세요.
      </div>
    </div>
    <ul class="nav nav-tabs" id="msg_tabs">
      <li class="col-sm-4 in_msg"><a href="${pageContext.request.contextPath}/msgbox/receiver.cider">받은쪽지</a></li>
      <li class="col-sm-4 out_msg"><a href="${pageContext.request.contextPath}/msgbox/sender.cider">보낸쪽지</a></li>
      <li class="active col-sm-4 store_msg"><a href="${pageContext.request.contextPath}/msgbox/store_receiver.cider">쪽지보관함</a></li>
    </ul>
      <ul class="my_ctg">
        <li class="active"><a href="${pageContext.request.contextPath}/msgbox/store_receiver.cider">받은쪽지</a></li>
        <li><a href="${pageContext.request.contextPath}/msgbox/store_sender.cider">보낸쪽지</a></li>
      </ul>

    <!--// 탭 메뉴 끝 -->
    <!-- 탭 화면 시작 -->
    <div class="container">
      <div id="msgbox_index">
        <table id="msgbox_table">
        	<c:choose>
            	<%-- 조회결과가 없는 경우 --%>
           		<c:when test="${output == null || fn:length(output) == 0}">
                	<p class="alert alert-success" role="alert">조회결과가 없습니다.</p>
                </c:when>
                <%-- 조회결과가 있는 경우 --%>
                <c:otherwise>
                	<%-- 조회 결과에 따른 반복 처리 --%>
                    <c:forEach var="item" items="${output}" varStatus="status">
                    	<c:set var="num" value="${pageData.totalCount-pageData.listCount*(pageData.nowPage-1)-status.count+1}" />
   						 <tr>
  	    					<td class="msgbox_num">${num}</td>
      						<td class="msgbox_subject"><a href="#" class="clk_tr"><span class="user_id">${item.senderNickname}</span> 님이 <span class="msg_cont">[${item.subject}]</span> 상품에 대해 보낸 쪽지</a></td>
      						<td class="msg_date">${item.regdate}</td>
    					</tr>
    					<tr class="msgbox_content">
      						<td colspan="3" class="clearfix">
        						<p>
        						${item.content}
        						</p>
        						<a href="#" class="msg_btn_list pull-right delete" data-msgno="${item.msgno}">삭제</a>    
      						</td>
    					</tr>
                    </c:forEach>
                  </c:otherwise>
             </c:choose>
        </table>
      </div>
      <!-- 페이지 번호 구현 -->
      <div class="clearfix text-center pagination">
        <ul>
        	<%-- 이전 그룹에 대한 링크 --%>
        	<c:choose>
            	<%-- 이전 그룹으로 이동 가능하다면? --%>
                <c:when test="${pageData.prevPage > 0}">
                	<%-- 이동할 URL 생성 --%>
                    <c:url value="/msgbox/store_receiver.cider" var="prevPageUrl">
                    	<c:param name="page" value="${pageData.prevPage}" />          
                    </c:url>
                    <li class="arr"><a href="${prevPageUrl}">&laquo;</a></li>
                </c:when>
                <c:otherwise>
                	<li class="disabled"><a href="#">&laquo;</a></li>
                </c:otherwise>
            </c:choose>
            
            <%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
               <c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">
                  <%-- 이동할 URL 생성 --%>
                  <c:url value="/msgbox/store_receiver.cider" var="pageUrl">
                     <c:param name="page" value="${i}" />
                  </c:url>
                  <%-- 페이지 번호 출력 --%>
                  <c:choose>
                     <%-- 현재 머물고 있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
                     <c:when test="${pageData.nowPage == i}">
                              <li class="active"><span>${i} <span class="sr-only">(current)</span></span></li>
                     </c:when>
                     <c:otherwise>
                              <li><a href="${pageUrl}">${i}</a></li>                     
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
          
          	<%-- 이전 그룹에 대한 링크 --%>
        	<c:choose>
            	<%-- 다음 그룹으로 이동 가능하다면? --%>
                <c:when test="${pageData.nextPage > 0}">
                	<%-- 이동할 URL 생성 --%>
                    <c:url value="/msgbox/store_receiver.cider" var="nextPageUrl">
                    	<c:param name="page" value="${pageData.nextPage}" />          
                    </c:url>
                    <li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
                </c:when>
                <c:otherwise>
                	<li class="disabled"><a href="#">&raquo;</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
      </div>
    </div>
  </section>
  
  <!-- 푸터 영역 -->
  <%@ include file="/WEB-INF/views/inc/footer.jsp"%>
  <!-- Javascript -->
  <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
  <!-- ajax-helper -->
  <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
  <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
  <script type="text/javascript">
    $(function () {		
      $(".clk_tr").click(function (e) {
          e.preventDefault();
          $(this).parents("tr").next().slideToggle(200);
          $(".msgbox_content").not($(this).parents("tr").next()).css('display', 'none');       
      });

      /** 삭제 구현 */
      $(".delete").click(function (e) { 		//삭제 버튼을 눌렀을때
        e.preventDefault();
        let target = $(this);					//이벤트가 발생한 객체 자신
        let msgno = target.data("msgno");		//data-msgno값을 가져옴
        
        //삭제 확인
        if(!confirm("쪽지를 보관함에서 삭제하시겠습니까?")){
      	  return false;
        }
        
        $.put("${pageContext.request.contextPath}/msgbox/store_receiver",{
          	 "msgno": msgno
            }, function(json){
          	  if(json.rt=="OK"){
          		alert("삭제 완료되었습니다.");
          		//삭제 완료 후 목록 페이지로 이동
          		window.location = "${pageContext.request.contextPath}/msgbox/store_receiver.cider";
          	  }
        });
      });
    });
  </script>
</body>

</html>