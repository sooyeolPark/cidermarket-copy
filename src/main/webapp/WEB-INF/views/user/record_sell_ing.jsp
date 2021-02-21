<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">

<head>
    <%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>거래내역 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                <h3 class="text-center">거래내역</h3>

                <!-- 탭의 전체 박스 -->
                <div class="tab clearfix">
                    
                    <!-- 탭 버튼 영역 -->
                    <ul class="row tab-button clearfix">
                        <li role="presentation" class="tab-button-item text-center">
                            <a href="${pageContext.request.contextPath}/member/record/selling.cider" class="tab-button-item-link pull-left selected">판매</a>
                        </li>
                        <li role="presentation" class="tab-button-item text-center">
                            <a href="${pageContext.request.contextPath}/member/record/buying.cider" class="tab-button-item-link pull-left">구매</a>
                        </li>
                    </ul>

                    <!-- 거래중/거래완료 sorting -->
                    <div class="recordSort text-center">
                        <a href="${pageContext.request.contextPath}/member/record/selling.cider" class="ing btn btn-lg btn-primary" id="selling">거래중</a>
                        <a href="${pageContext.request.contextPath}/member/record/sellend.cider" class="ing btn btn-lg btn-info" id="sellend">거래완료</a>
                    </div>
                    <!-- 내용영역 -->
                    <div class="tab-panel">
                    
                    <!-- 거래중 탭 -->
                   	<div id="tab-page-1">
                        <c:choose>
                        	<%-- 조회결과가 없는 경우 --%>
	                        <c:when test="${output == null || fn:length(output) == 0}">
	                           <p class="alert alert-success" role="alert">조회결과가 없습니다.</p>
	                        </c:when>
	                        <%-- 조회결과가 있는 경우 --%>
	                        <c:otherwise>
		                        <%-- 조회 결과에 따른 반복 처리 --%>
	                            <c:forEach var="item" items="${output}" varStatus="status">
			                            <div class="col-xs-12 col-sm-6 col-md-6 item-list">
							                <div class="sorting itemList">
							                    <img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img${item.filepath}">
							                    <div class="caption">
							                        <span class="label"><c:if test="${item.how == 'T'}">택배거래</c:if><c:if test="${item.how == 'J'}">직거래</c:if></span> 
							                        <span class="temp-gray"><span>${item.prodno}</span><c:if test="${item.how == 'J'}"> | seller(${item.seller})</c:if></span>
							                        <h4><a href="${pageContext.request.contextPath}/item_index.cider?prodno=${item.prodno}">${item.subject}</a></h4>
							                        <h4><b><fmt:formatNumber value="${item.price}" pattern="#,###" />원</b></h4>
							                        <div class="resultBtn">
														<c:choose>
															<c:when test="${item.how == 'T'}">
							                            		<c:choose>
							                            			<c:when test="${item.refund == 'N'}">
																		<button type="button" class="ing btn btn-danger recordCancel" data-prodno="${item.prodno}" data-recono="${item.recono}" data-refund="${item.refund}">거래취소</button>
																	</c:when>
								                            		<c:otherwise>
																		<c:if test="${item.refund == 'J'}">
										                            		<button type="button" class="ing btn btn-warning recordReturn" data-prodno="${item.prodno}" data-recono="${item.recono}">반품요청</button>
									                            		</c:if>
									                            		<c:if test="${item.refund == 'X'}">
										                            		<button type="button" class="ing btn btn-warning recordReturn" data-prodno="${item.prodno}" data-recono="${item.recono}" data-refund="${item.refund}" disabled>반품거절</button>
										                            		<button type="button" class="ing btn btn-danger recordCancel" data-prodno="${item.prodno}" data-recono="${item.recono}" data-refund="${item.refund}">거래취소</button>
									                            		</c:if>
								                            		</c:otherwise>
							                            		</c:choose>
															</c:when>
															<c:otherwise>
							                            		<button type="button" data-toggle="modal" data-target="#myModal" class="ing btn btn-primary recordJConfirm" data-prodno="${item.prodno}" data-seller="${item.seller}">구매자확정</button>
							                            		<button type="button" class="ing btn btn-danger recordCancel" data-prodno="${item.prodno}" data-recono="${item.recono}" data-refund="${item.refund}">거래취소</button>
															</c:otherwise>
														</c:choose>
							                        </div>
							                    </div>
							                </div>
							            </div>
		                        </c:forEach>
	                        </c:otherwise>
                        </c:choose>
                        
                        
                        <!-- 페이지 번호 구현 -->
		                <div class="clearfix text-center pagination">
		                    <ul>
		                   	<%-- 이전 그룹에 대한 링크 --%>
		                   	<c:choose>
								<%-- 이전 그룹으로 이동 가능하다면? --%>
								<c:when test="${pageData.prevPage > 0}">
									<%-- 이동할 URL 생성 --%>
									<c:url value="/member/record/selling.cider" var="prevPageUrl">
										<c:param name="page" value="${pageData.prevPage}" />
									</c:url>
		                        	<li class="arr"><a href="${prevPageUrl}">&laquo;</a></li>
		                       	</c:when>
		                       	<c:otherwise>
		                        	<li class="arr disabled"><a href="#">&laquo;</a></li>
								</c:otherwise>
							</c:choose>
							
							<%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
							<c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">
								<%-- 이동할 URL 생성 --%>
								<c:url value="/member/record/selling.cider" var="pageUrl">
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
		                    
		                    <%-- 다음 그룹에 대한 링크 --%>
							<c:choose>
								<%-- 다음 그룹으로 이동 가능하다면? --%>
								<c:when test="${pageData.nextPage > 0}">
									<%-- 이동할 URL 생성 --%>
									<c:url value="/member/record/selling.cider" var="nextPageUrl">
										<c:param name="page" value="${pageData.nextPage}" />
									</c:url>
		                        	<li class="arr"><a href="${nextPageUrl}">&raquo;</a></li>
		                       	</c:when>
								<c:otherwise>
		                        	<li class="arr disabled"><a href="#">&raquo;</a></li>
								</c:otherwise>
							</c:choose>
		                    </ul>
		                </div> <!-- 페이지 번호 구현 끝 -->
                        
                    </div> <!-- 거래중 탭 종료 -->
                       

                    </div>
                </div>
                
                
            </div>
        </section>
        
        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>
		
		<!-- 직거래시 구매자 선택 모달창 -->
        <a data-toggle="modal" href="#myModal" class="myModal"></a>
        <div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"></div>
        
        <!-- template -->
		<script id="buyer_tmpl" type="text/x-handlebars-template">
			<div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">구매자를 선택해 주세요.</h4>
                    </div>
                    <div class="modal-body">
						<select name="buy_user" id="buy_user" class="form-control">
						{{#each buyer}}
							<option value="{{sender}}" 
							data-prodno="{{prodno}}" 
							data-receiver="{{receiver}}" 
							data-sender="{{sender}}" 
							data-nickname="{{senderNickname}}">{{senderNickname}}</option>
						{{/each}}
						</select>
					</div>
                    <div class="modal-footer">
                        <button type="summit" id="buyerConfirm" class="btn btn-primary btn-block">확인</button>
                    </div>
                </div>
            </div>
        </script>
		
        <!-- Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
        <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
        <!-- ajax-helper -->
        <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
        <!-- handlebar plugin -->
        <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
        <script type="text/javascript">
	        /****************************** 직거래 구매자 확정 모달 *****************************/
	        $(document).on("click", ".recordJConfirm", function(e) {
	            e.preventDefault();
	            let ts = $(this)
	            
	            // data를 통해 거래 정보 가져오기
	            let receiver = ts.data("seller");
	            let prodno = ts.data("prodno");
	            
	         	// Ajax 호출
                $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/record/sell/ing/jlist",
                    data: {"receiver":receiver, "prodno":prodno},
                    success: function(json) {
  	    				console.log(json);
  	    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
  	    				if (json.rt == "OK") {
  	    					// 핸들바를 이용한 데이터 삽입
  	    					var template = Handlebars.compile($("#buyer_tmpl").html());
	  	                    var html = template(json);
	  	                    $("#myModal").append(html);
  	    				}
  	    			}
                });
	            
            });
	        // 모달창 닫으면 데이터 비우기
	        $(document).on("click", ".close", function(e) {
	        	$("#myModal").empty();
	        });
	        
        
	        /****************************** 직거래 거래확정 모달 ********************************/
	        $(document).on("click", "#buyerConfirm", function(e) {
	            e.preventDefault();
	            let ts = $("#buy_user option:selected")
	            
	            // data를 통해 거래 정보 가져오기
	            let seller = ts.data("receiver");
	            let prodno = ts.data("prodno");
	            let buyer = ts.data("sender");
	            let nickname = ts.data("nickname");
	            
	            // 확인, 취소버튼에 따른 후속 처리 구현
	            swal({
	                title: '확정',                // 제목
	                text: "구매자를 확정 하시겠습니까?",  // 내용
	                type: 'warning',              // 종류
	                confirmButtonText: '예',     // 확인버튼 표시 문구
	                showCancelButton: true,       // 취소버튼 표시 여부
	                cancelButtonText: '아니오',       // 취소버튼 표시 문구
	            }).then(function(result) {        // 버튼이 눌러졌을 경우의 콜백 연결
	                if (result.value) {           // 확인 버튼이 눌러진 경우
	              
                        // Ajax 호출
                        $.ajax({
                            type: "PUT",
                            url: "${pageContext.request.contextPath}/record/sell/ing/jconfirm",
                            data: {"seller":seller, "prodno":prodno, "buyer":buyer, "nickname":nickname},
                            success: function(json) {
          	    				console.log(json);
          	    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
          	    				if (json.rt == "OK") {
          	    					
          	    					swal('확정', '성공적으로 확정되었습니다.', 'success');
          	    					window.location = "${pageContext.request.contextPath}/member/record/selling.cider";
          	    				}
          	    			}
                        });
	
	                } else if (result.dismiss === 'cancel') {   // 취소버튼이 눌러진 경우
	                    swal('취소', '확정이 취소되었습니다.', 'error');
	                }
	            });
	        });
        	
            /****************************** 택배거래 거래확정 모달 *****************************/
            $(document).on("click", ".recordConfirm", function(e) {
                e.preventDefault();
                let ts = $(this)
                
                // data를 통해 거래 정보 가져오기
                let recono = ts.data("recono");
                let how = ts.data("how");
                let buyer = ts.data("buyer");
                let prodno = ts.data("prodno");
                
                // 확인, 취소버튼에 따른 후속 처리 구현
                swal({
                    title: '확정',                // 제목
                    text: "거래를 확정 하시겠습니까?",  // 내용
                    type: 'warning',              // 종류
                    confirmButtonText: '예',     // 확인버튼 표시 문구
                    showCancelButton: true,       // 취소버튼 표시 여부
                    cancelButtonText: '아니오',       // 취소버튼 표시 문구
                }).then(function(result) {        // 버튼이 눌러졌을 경우의 콜백 연결
                    if (result.value) {           // 확인 버튼이 눌러진 경우
                        if (ts.prev().data('refund') == 'J') {
                                swal('잠깐', '반품요청이 있습니다. 반품 승인/거절 여부 먼저 결정해 주세요.', 'error');
                        } else {
                            // Ajax 호출
                            $.ajax({
                                type: "PUT",
                                url: "${pageContext.request.contextPath}/record/sell/ing/confirm",
                                data: {"recono":recono, "how":how, "buyer":buyer, "prodno":prodno},
                                success: function(json) {
              	    				console.log(json);
              	    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
              	    				if (json.rt == "OK") {
              	    					swal('확정', '성공적으로 확정되었습니다.', 'success');
              	    					window.location = "${pageContext.request.contextPath}/member/record/selling.cider";
              	    				}
              	    			}
                            });
                        }

                    } else if (result.dismiss === 'cancel') {   // 취소버튼이 눌러진 경우
                        swal('취소', '확정이 취소되었습니다.', 'error');
                    }
                });
            });
            
            /****************************** 거래취소 모달 *****************************/
            $(document).on("click", ".recordCancel", function(e) {
                e.preventDefault();
                let ts = $(this)
                //let dis = ts.prev('.recordReturn').prop('disabled');
                
                // data를 통해 거래 정보 가져오기
                let recono = ts.data("recono");
                let refund = ts.data("refund");
                let prodno = ts.data("prodno");
                
                // 확인, 취소버튼에 따른 후속 처리 구현
                swal({
                    title: '취소',                // 제목
                    text: "거래를 취소 하시겠습니까?",  // 내용
                    type: 'warning',              // 종류
                    confirmButtonText: '예',     // 확인버튼 표시 문구
                    showCancelButton: true,       // 취소버튼 표시 여부
                    cancelButtonText: '아니오',       // 취소버튼 표시 문구
                }).then(function(result) {        // 버튼이 눌러졌을 경우의 콜백 연결
                    if (result.value) {           // 확인 버튼이 눌러진 경우
                        if (ts.prev().data('refund') == 'J') {
                                swal('잠깐', '반품요청이 있습니다. 반품 승인/거절 여부 먼저 결정해 주세요.', 'error');
                        } else {
                            // Ajax 호출
                            $.ajax({
                                type: "PUT",
                                url: "${pageContext.request.contextPath}/record/sell/ing/cancel",
                                data: {"recono":recono, "refund":refund, "prodno":prodno},
                                success: function(json) {
              	    				console.log(json);
              	    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
              	    				if (json.rt == "OK") {
              	    					swal('확정', '성공적으로 확정되었습니다.', 'success');
              	    					window.location = "${pageContext.request.contextPath}/member/record/selling.cider";
              	    				}
              	    			}
                            });
                        }

                    } else if (result.dismiss === 'cancel') {   // 취소버튼이 눌러진 경우
                        swal('취소', '확정이 취소되었습니다.', 'error');
                    }
                });
            });

            /****************************** 반품확정 *****************************/
            $(document).on("click", ".recordReturn", function(e) {
                e.preventDefault();
                var ts = $(this);
                
             	// data를 통해 거래 정보 가져오기
                let recono = ts.data("recono");
                
                // 확인, 취소버튼에 따른 후속 처리 구현
                swal({
                    title: '반품',                // 제목
                    text: "반품을 승인 하시겠습니까?",  // 내용
                    type: 'warning',              // 종류
                    confirmButtonText: '승인',     // 확인버튼 표시 문구
                    showCancelButton: true,       // 취소버튼 표시 여부
                    cancelButtonText: '거절',       // 취소버튼 표시 문구
                }).then(function(result) {        // 버튼이 눌러졌을 경우의 콜백 연결
                    if (result.value) {           // 확인 버튼이 눌러진 경우
                    	
                     	// Ajax 호출
                        $.ajax({
                            type: "PUT",
                            url: "${pageContext.request.contextPath}/record/ing/refund",
                            data: {"recono":recono, "refund":"W", "tradecon":"W"},
                            success: function(json) {
          	    				console.log(json);
          	    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
          	    				if (json.rt == "OK") {
          	    					swal('승인', '반품을 승인 하셨습니다.', 'success');
          	    					window.location = "${pageContext.request.contextPath}/member/record/selling.cider";
          	    				}
          	    			}
                        });
                        
                    } else if (result.dismiss === 'cancel') {   // 취소버튼이 눌러진 경우
                    	
                    	// Ajax 호출
                        $.ajax({
                            type: "PUT",
                            url: "${pageContext.request.contextPath}/record/ing/refund",
                            data: {"recono":recono, "refund":"X", "prodno":prodno},
                            success: function(json) {
          	    				console.log(json);
          	    				// json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
          	    				if (json.rt == "OK") {
          	    					swal('거절', '반품을 거절 하셨습니다.', 'error');
          	    					window.location = "${pageContext.request.contextPath}/member/record/selling.cider";
          	    				}
          	    			}
                        });
                        
                        ts.prop('disabled', true).html('반품거절');
                    }
                });
            });
        </script>
</body>

</html>