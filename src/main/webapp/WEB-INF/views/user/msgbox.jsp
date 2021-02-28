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
      <!-- 화면에 표시될 원본 보기 영역 - 기본적으로 숨겨진 상태이다. -->
  <div class='gray_layer' id='background'></div>
  <div class='over_layer' id='front'>
    <div id="modal_name">쪽지보내기</div>
        <div id="modal_content">
            <form id="sendmsg" action="${pageContext.request.contextPath}/msgbox/receiver" role="form">
                <div class="form-group">
                    <span id="to_user">고양이</span>
                    <span class="help-block">님에게 쪽지보내기</span>
                    <textarea rows="5" id="send_input" name="content" class="form-control" placeholder="내용을 입력해주세요."></textarea>
                    <input type="hidden" id="send_sender" name="sender" value="" />
                    <input type="hidden" id="send_receiver" name="receiver" value="" />
                    <input type="hidden" id="send_prodno" name="prodno" value="" />
                    <div class="modal_btn">
                        <button id="send_ok" type="submit" class="btn btn-primary">확인</button>
                        <button id="send_cancle" type="button" class="btn btn-info">취소</button>
                    </div>
                </div>
            </form>
        </div>
  </div>
    <div class="container">
      <div id="msgbox_subject">
        쪽지함
      </div>
      <div id="msgbox_desc">
        *쪽지는 50일 후 자동삭제됩니다. 중요한 쪽지는 보관함에 보관하세요.
      </div>
    </div>
    <ul class="nav nav-tabs" id="msg_tabs">
      <li class="active col-sm-4 in_msg"><a href="${pageContext.request.contextPath}/msgbox/receiver.cider">받은쪽지</a></li>
      <li class="col-sm-4 out_msg"><a href="${pageContext.request.contextPath}/msgbox/sender.cider">보낸쪽지</a></li>
      <li class="col-sm-4 store_msg"><a href="${pageContext.request.contextPath}/msgbox/store_receiver.cider">쪽지보관함</a></li>
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
      						<td class="msgbox_subject"><a href="#" class="clk_tr">
      						<c:choose>
      						<c:when test="${item.outmember=='N'}">
      						<span class="user_id">${item.senderNickname}</span>
      						</c:when>
      						<c:otherwise>
      						<span class="user_id" style="color:#ccc;">탈퇴한 회원</span>
      						</c:otherwise>
      						</c:choose>      						
      						 님이 <span class="msg_cont">[${item.subject}]</span> 상품에 대해 보낸 쪽지</a></td>
      						<td class="msg_date">${item.regdate}</td>
    					</tr>
    					<tr class="msgbox_content">
      						<td colspan="3" class="clearfix">
        						<p>
        						${item.content}
        						</p>
        						<a href="#" class="msg_btn_list pull-right delete" data-msgno="${item.msgno}">삭제</a>
        						<c:if test="${item.outmember=='N'}">
        						<a href="#" class="msg_btn_list pull-right reply" data-prodno="${item.prodno}" data-receiver="${item.receiver}" data-sender="${item.sender}">답장</a>
        						</c:if>
        						<a href="#" class="msg_btn_list pull-right store" data-msgno="${item.msgno}">보관</a>              
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
                    <c:url value="/msgbox/receiver.cider" var="prevPageUrl">
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
                  <c:url value="/msgbox/receiver.cider" var="pageUrl">
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
                    <c:url value="/msgbox/receiver.cider" var="nextPageUrl">
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
  <!-- jQeury Ajax Form plugin CDN -->
  <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
  <!-- ajax-helper -->
  <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
  <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
  <script type="text/javascript">
    $(function () {		
      //쪽지보내기 취소
      $("#send_cancle").click(function (e) {
                $("#send_input").val('');
                $("#background").fadeOut(300);
                $("#front").fadeOut(200);            
      });

      $(".clk_tr").click(function (e) {
          e.preventDefault();
          $(this).parents("tr").next().slideToggle(200);
          $(".msgbox_content").not($(this).parents("tr").next()).css('display', 'none');       
      });
      
      //답장 버튼 누를시 모달창 생성
      $(".reply").click(function (e) {
            var user = $(this).parents("tr").prev().find(".user_id").html();
            var sender = $(this).data("sender");
            var receiver = $(this).data("receiver");
            var prodno = $(this).data("prodno");
            $("#send_sender").val(receiver);
            $("#send_receiver").val(sender);
            $("#send_prodno").val(prodno);
            $("#to_user").html(user);
            $("#background").fadeIn(300);
            $("#front").fadeIn(200);        
      });
      
      /**쪽지 보내기 구현 */
      $("#sendmsg").submit(function(e) {
                e.preventDefault();
              const form = $(this);
              const url = form.attr('action');
              
              $.ajax({
                  type: "POST",
                  url: url,
                  data: form.serialize(),
                  success: function(json) {
                   console.log(json);
                   // json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
                   if (json.rt == "OK") {
                	   alert("쪽지를 보냈습니다.");
                       $("#send_input").val('');
                       $("#background").fadeOut(300);
                       $("#front").fadeOut(200);  
                   }
                }
                });
      });
       
      /** 삭제 구현 */
      $(".delete").click(function (e) { 		//삭제 버튼을 눌렀을때
        e.preventDefault();
        let target = $(this);					//이벤트가 발생한 객체 자신
        let msgno = target.data("msgno");		//data-msgno값을 가져옴
        
        //삭제 확인
        if(!confirm("쪽지를 삭제하시겠습니까?")){
      	  return false;
        }
        
        $.put("${pageContext.request.contextPath}/msgbox/receiver_delete",{
          	 "msgno": msgno
            }, function(json){
          	  if(json.rt=="OK"){
          		alert("삭제가 완료되었습니다.");
          		//삭제 완료 후 목록 페이지로 이동
          		window.location = "${pageContext.request.contextPath}/msgbox/receiver.cider";
          	  }
        });
      });
      
      /** 보관기능 구현 */
      $(".store").click(function (e) { 		//보관 버튼을 눌렀을때
          e.preventDefault();
          let target = $(this);					//이벤트가 발생한 객체 자신
          let msgno = target.data("msgno");		//data-msgno값을 가져옴
          
          //삭제 확인
          if(!confirm("쪽지를 보관하시겠습니까?")){
        	  return false;
          }
          
          $.put("${pageContext.request.contextPath}/msgbox/receiver_save",{
            	 "msgno": msgno
              }, function(json){
            	  if(json.rt=="OK"){
            		alert("쪽지가 보관되었습니다.");
            		//삭제 완료 후 목록 페이지로 이동
            		window.location = "${pageContext.request.contextPath}/msgbox/receiver.cider";
            	  }
          });
        });     
    });
    
    
  </script>
</body>

</html>