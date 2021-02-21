<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
	<title>상품상세 - 사이다마켓</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/item_index.css" />
	<!-- 캐러셀 jqeury plugin 참조 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/swiper/swiper-bundle.css">
	<script src="${pageContext.request.contextPath}/assets/plugins/swiper/swiper-bundle.js"></script>
	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/searchbox.js"></script>
	<!-- ligthbox pulgin 참조 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/lightbox/css/lightbox.css" />
	<script src="${pageContext.request.contextPath}/assets/plugins/lightbox/js/lightbox.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
</head>

<body>
	<!-- 헤더 영역 -->
    <%@ include file="/WEB-INF/views/inc/header.jsp"%>    
    
  <!-- 화면에 표시될 원본 보기 영역 - 기본적으로 숨겨진 상태이다. -->
  <div class='gray_layer' id='background'></div>
  <div class='over_layer' id='front'>
    <div class="modal_name">쪽지보내기</div>
    <div class="modal_content">
      <form id="sendmsg" action="${pageContext.request.contextPath}/msgbox/receiver" role="form">
        <div class="form-group">
          <span id="to_user">${seller.nickname}</span>
          <span class="help-block">님에게 쪽지보내기</span>
          <textarea rows="5" id="send_input" name="content" class="form-control" placeholder="내용을 입력해주세요."></textarea>
          <input type="hidden" id="send_sender" name="sender" value="${myNum}" />
          <input type="hidden" id="send_receiver" name="receiver" value="${seller.membno}" />
          <input type="hidden" id="send_prodno" name="prodno" value="${product.prodno}" />
          <div class="modal_btn">
            <button id="send_ok" type="submit" class="btn btn-primary">보내기</button>
            <button id="send_cancle" type="button" class="btn btn-info">취소</button>
          </div>
        </div>
      </form>
    </div>
  </div>
  <div class='over_layer' id="singo">
    <div class="modal_name">신고하기</div>
    <div class="modal_content">
      <form id="sendsingo" action="${pageContext.request.contextPath}/admin/singo" role="form">
        <div class="form-group">
          <span id="singo_name">${product.subject}</span>
          <span class="help-block">게시글을 신고하는 이유를 선택해주세요.</span>
          <select class="form-control" id="singo_type" name="singo_type">
            <option value="" selected>신고 이유를 선택해주세요</option>
            <option value ="P" >판매금지 품목이에요</option>
            <option value ="G" >거래 게시글이 아니에요</option>
            <option value ="S" >사기글 같아요</option>
            <option value ="E" >기타 사유</option>
          </select>
          <textarea rows="2" id="singo_content" class="form-control" name="singo_content" placeholder="신고사유를 입력해주세요."></textarea>
          <input type="hidden" id="send_sender" name="singo_sender" value="${myNum}" />
          <input type="hidden" id="send_prodno" name="singo_prodno" value="${product.prodno}" />
          <div class="modal_btn">
            <button id="singo_ok" type="submit" class="btn btn-primary">신고하기</button>
            <button id="singo_cancle" type="button" class="btn btn-info">취소</button>
          </div>
        </div>
      </form>
    </div>
  </div>
  <!-- nav 시작 -->
  <header></header>
  <!-- // nav 끝 -->

  <!-- content 시작 -->
  <section>
      <!-- Slider main container -->
      <div class="swiper-container">
        <!-- Additional required wrapper -->
        <div class="swiper-wrapper">
          <!-- Slides -->
          <c:forEach var="item" items="${fileimages}" varStatus="status">
          	<div class="swiper-slide"><a href="${pageContext.request.contextPath}/assets/img${item.filepath}" data-lightbox="my-gallery">
              <img src="${pageContext.request.contextPath}/assets/img${item.filepath}" width="100%" /></a></div>
          </c:forEach>
        </div>
        <!-- If we need pagination -->
        <div class="swiper-pagination"></div>
      </div>
      <div class="item_title clearfix">
        <span class="label">
        <c:choose>
        	<c:when test="${product.prodcon == 'N'}">
        	새것
        	</c:when>
        	<c:when test="${product.prodcon == 'A'}">
        	거의새것
        	</c:when>
        	<c:when test="${product.prodcon == 'U'}">
        	중고
        	</c:when>
        </c:choose>	
        </span>
        <c:if test="${product.fee==0}">
        <span class="label">배송비무료</span>
        </c:if>
        <div id="like_this" class="pull-right"><i class="glyphicon glyphicon-heart"></i><span id="countzzim">${fn:length(membprod)}</span></div>
        <a href="#" id="flag_this" class="pull-right"><i class="glyphicon glyphicon-flag"></i></a>
        <h3>${product.subject}</h3>
        <h1><b><fmt:formatNumber value="${product.price}" pattern="#,###" />원</b></h1>
      </div>
      <div class="div_blank1"></div>
      <div class="item_info">
        <!-- 탭의 전체 박스 -->
        <div class="tab">
          <!-- 탭 버튼 영역 -->
          <ul class="tab-button clearfix">
            <li class="tab-button-item pull-left">
              <a class="tab-button-item-link selected" href="#tab-page-1">상세설명</a>
            </li>
            <li class="tab-button-item pull-left">
              <a class="tab-button-item-link" href="#tab-page-2">판매자 다른상품</a>
            </li>
          </ul>
          <!-- 내용영역 -->
          <div class="tab-panel">
            <div id="tab-page-1">
              <div class="row how_trade">
                <div class="col-xs-3"><b>거래방법</b></div>
                <div class="col-xs-9"><b>
					<c:choose>
        				<c:when test="${product.how == 'J'}">
      				  	직거래
        				</c:when>
        				<c:when test="${product.how == 'T'}">
        				택배거래
        				</c:when>
        				<c:when test="${product.how == 'X'}">
        				상관없음
        				</c:when>
        			</c:choose>
				</b></div>
              </div>
              <div class="row how_trade">
                <div class="col-xs-3"><b>배송비</b></div>
                <div class="col-xs-9"><b>
                <c:choose>
        			<c:when test="${product.fee == 0}">
      			  	무료
        			</c:when>
        			<c:otherwise>
        			${product.fee}원
        			</c:otherwise>
        		</c:choose>
                </b></div>
              </div>
              <div class="info_desc">
                ${product.detail}
              </div>
              <div class="info_etc">
                <div class="row">
                  <div class="col-xs-1"><i class="glyphicon glyphicon-time"></i></div>
                  <div class="col-xs-11"><span id="reg_time">${product.regdate}</span></div>
                </div>
                <c:if test="${fn:length(hashtag) != 0}">
                <div class="row">
                  <div class="col-xs-1"><i class="glyphicon glyphicon-link"></i></div>
                  <div class="col-xs-11">
                  	<c:forEach var="item" items="${hashtag}" varStatus="status">
          				<span>#${item.tagname}</span>
          			</c:forEach>
				  </div>
                </div>
                </c:if>
                <div class="row">
                  <div class="col-xs-1"><i class="glyphicon glyphicon-tag"></i></div>
                  <div class="col-xs-11">
                  <span>${product.catename}</span>
                  </div>
                </div>
              </div>
              <div class="user_info clearfix">
                <a class="pull-left" href="#"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img${seller.filepath}" width="50"
                    height="50" alt="Generic placeholder image"> </a>
                <div class="user_info_detail clearfix">

                  <div id="user_id">${seller.nickname}</div>
                  <div id="user_info_item" class="pull-right">상품 <span>${productcount}</span></div>
                  <div id="user_lv">
                  <c:choose>
        				<c:when test="${sellercount < 1}">
      				  	Lv 1 화이트
        				</c:when>
        				<c:when test="${sellercount > 0 && sellercount < 3}">
        				Lv 2 블루
        				</c:when>
        				<c:when test="${sellercount > 2 && sellercount < 7}">
        				Lv 3 브론즈
        				</c:when>
        				<c:when test="${sellercount > 6 && sellercount < 15}">
        				Lv 4 실버
        				</c:when>
        				<c:when test="${sellercount > 14}">
        				Lv 5 골드
        				</c:when>
        			</c:choose>
                  </div>
                  <fmt:parseNumber var="rate" type="number" value="${seller.rate}" />
                  <c:choose>                  	
        				<c:when test="${rate < 1}">
        				<div id="user_star">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	</div>
                  		<div id="user_string">${seller.rate}</div>
        				</c:when>
        				<c:when test="${rate >= 1 && rate < 2}">
        				<div id="user_star">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	</div>
                  		<div id="user_string">${seller.rate}</div>
        				</c:when>
        				<c:when test="${rate >= 2 && rate < 3}">
        				<div id="user_star">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	</div>
                  		<div id="user_string">${seller.rate}</div>
        				</c:when>
        				<c:when test="${rate >= 3 && rate < 4}">
        				<div id="user_star">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	</div>
                  		<div id="user_string">${seller.rate}</div>
        				</c:when>
        				<c:when test="${rate >= 4 && rate < 5}">
        				<div id="user_star">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_blank.png" alt="별점 0점">
      				  	</div>
                  		<div id="user_string">${seller.rate}</div>
        				</c:when>
        				<c:when test="${rate == 5}">
        				<div id="user_star">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	<img src="${pageContext.request.contextPath}/assets/img/star_full.png" alt="별점 1점">
      				  	</div>
                  		<div id="user_string">${seller.rate}</div>
        				</c:when>
        			</c:choose>
        		</div>
              </div>
              <div class="item-repl">
                <form id="send_reply" action="${pageContext.request.contextPath}/reply" role="form">
                  <fieldset>
                    <!-- 입력양식 -->
                    <div class="form-group">
                      <label for="content" class="control-label">댓글 <span>(<span id="reply_count">
                      <c:set var="total" value="0" />
                      <c:forEach var="item" items="${reply}" varStatus="status">
                      	<c:if test="${item.redelete=='Y'}">
                      	<c:set var="total" value="${total+1}" />
                      	</c:if>
                      </c:forEach>
                      ${fn:length(reply)+fn:length(rereply)-total}
                      </span> )</span></label>
                      <textarea id="content" name=reply_content class="form-control" rows="3" placeholder="댓글을 입력해주세요."></textarea>
                      <input type="hidden" id="reply_prodno" name="reply_prodno" value="${product.prodno}" >
                      <input type="hidden" id="reply_writer" name="reply_writer" value="${myNum}" >
                    </div>
                    <div class="form-group clearfix">
                      <button type="submit" id="reply_submit" class="btn btn-primary pull-right">등록</button>
                    </div>
                    <!--// 입력양식 -->
                  </fieldset>
                </form>
                
                <ul class="media-list" id="reply_box">
                
                  <!-- 목록의 개별 항목이 웹진 박스로 구성됩니다. -->
                	<c:forEach var="item" items="${reply}" varStatus="status">
                		<li class="media">
                		<c:choose>
						<c:when test="${item.redelete=='Y'}">
						<div class="pull-left" style="width:70px; height:70px;" ></div>
      					<div class="media-body">
        					<div class="clearfix">
          					<h4 class="media-heading pull-left re_user_name" style="color:#ccc;">삭제된 댓글입니다<small></small></h4>
          					<div class="pull-right">
          					</div>
        					</div>
        					<div class="clearfix re_user_rpl">
        					<p>  </p>
        					</div>
        					<div class="reply_div">
        					<c:forEach var="rere" items="${rereply}" varStatus="restatus">
        					<c:if test="${item.replyno==rere.replyno}">
        						<div class="media">
        							
      								<div class="pull-left"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img${rere.filepath}"
          								width="60" height="60" alt="Generic placeholder image"> </div>
      								<div class="media-body">
        								<div class="clearfix">
          									<h4 class="media-heading pull-left re_user_name">${rere.nickname} <small>${rere.regdate}</small></h4>
          									<c:if test="${myNum==rere.writer}">
          									<div class="pull-right">
            									<a class="rere_remove" href="#" title="삭제" data-rereplyno ="${rere.rereplyno}"><i class="glyphicon glyphicon-remove"></i></a>
          									</div>
          									</c:if>
        								</div>
        								<div class="clearfix re_user_rpl">
          									<p>${rere.content}</p>
        								</div>
      								</div>
    							</div>
    						</c:if>
        					</c:forEach>
        					</div>
      					</div>
						
						</c:when>
						<c:otherwise>
          				<div class="pull-left"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img${item.filepath}"
          						width="60" height="60" alt="Generic placeholder image"> </div>
      					<div class="media-body">
        					<div class="clearfix">
          					<h4 class="media-heading pull-left re_user_name">${item.nickname} <small>${item.regdate}</small></h4>
          					<c:if test="${myNum==item.writer}">
          					<div class="pull-right">
            					<a class="re_remove" href="#" title="삭제" data-replyno ="${item.replyno}"><i class="glyphicon glyphicon-remove"></i></a>
          					</div>
          					</c:if>
        					</div>
        					<div class="clearfix re_user_rpl">
          					<p>${item.content}</p>
          					<button type="submit" class="btn btn-danger pull-right reply">답글</button>
          					<div class="repl_form">
            					<form role="form" class="send_rereply" action="${pageContext.request.contextPath}/rereply" >
              					<fieldset>
                					<div class="form-group">
                  					<textarea class="form-control re_reply rereply_content" name="rereply_content" rows="3" placeholder="댓글을 입력해주세요."></textarea>
                  					<input type="hidden" class="rereply_prodno" name="rereply_prodno" value="${product.prodno}" >
                      				<input type="hidden" class="rereply_writer" name="rereply_writer" value="${myNum}" >
                      				<input type="hidden" class="rereply_replyno" name="rereply_replyno" value="${item.replyno}" >
                					</div>
                					<div class="form-group clearfix">
                  					<button type="submit" class="btn btn-default pull-right reply_submit1">등록</button>
                					</div>
              					</fieldset>
            					</form>
          					</div>
        					</div>
        					<div class="reply_div">
        					<c:forEach var="rere" items="${rereply}" varStatus="restatus">
        					<c:if test="${item.replyno==rere.replyno}">
        						<div class="media">
      								<div class="pull-left"> <img class="media-object img-circle" src="${pageContext.request.contextPath}/assets/img${rere.filepath}"
          								width="60" height="60" alt="Generic placeholder image"> </div>
      								<div class="media-body">
        								<div class="clearfix">
          									<h4 class="media-heading pull-left re_user_name">${rere.nickname} <small>${rere.regdate}</small></h4>
          									<c:if test="${myNum==rere.writer}">
          									<div class="pull-right">
            									<a class="rere_remove" href="#" title="삭제" data-rereplyno ="${rere.rereplyno}"><i class="glyphicon glyphicon-remove"></i></a>
          									</div>
          									</c:if>
        								</div>
        								<div class="clearfix re_user_rpl">
          									<p>${rere.content}</p>
        								</div>
      								</div>
    							</div>
    						</c:if>
        					</c:forEach>
        					</div>
      					</div>
      					</c:otherwise>
      					</c:choose>
      					</li>
          			</c:forEach>
                </ul>
              </div>			
        					
              <div class="div_blank"></div>
              <div class="container">
                <h3>이런 상품은 어때요?</h3>
                <div class="box clearfix" id="center">
                  <c:choose>
					<%-- 조회결과가 없는 경우 --%>
					<c:when test="${itemlistcategory == null || fn:length(itemlistcategory) == 0}">
						<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
							<p>같은 카테고리로 등록된 상품이 없습니다.</p>
						</div>
					</c:when>
					<%-- 조회결과가 있는 경우 --%>
					<c:otherwise>
						<%-- 조회 결과에 따른 반복 처리 --%>
						<c:forEach var="item" items="${itemlistcategory}" varStatus="status">
							<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
								<%-- 상세페이지로 이동하기 위한 URL --%>
								<c:url var="viewUrl" value="/item_index.cider">
									<c:param name="prodno" value="${item.prodno}" />
								</c:url>								
				                <a href="${viewUrl}">
				                    <div class="sorting thumbnail">
			                        	<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img${item.filepath}">
				                        <div class="caption">
				                            <h5>${item.subject}</h5>
				                            <h4>${item.price}원</h4>
				                        </div>
				                    </div>
				                </a>
				            </div>
			            </c:forEach>
		            </c:otherwise>
	            </c:choose>
                </div>
              </div>
            </div>
            <div id="tab-page-2" class="hide">
            <div class="container">
              <h3>${seller.nickname} 님의 다른 상품</h3>
              <div class="box clearfix" id="others">
                <c:choose>
					<%-- 조회결과가 없는 경우 --%>
					<c:when test="${itemlistseller == null || fn:length(itemlistseller) == 0}">
						<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
							<p>등록된 상품이 없습니다.</p>
						</div>
					</c:when>
					<%-- 조회결과가 있는 경우 --%>
					<c:otherwise>
						<%-- 조회 결과에 따른 반복 처리 --%>
						<c:forEach var="item" items="${itemlistseller}" varStatus="status">
							<div class="col-xs-6 col-sm-4 col-lg-3 item-list">
								<%-- 상세페이지로 이동하기 위한 URL --%>
								<c:url var="viewUrl" value="/item_index.cider">
									<c:param name="prodno" value="${item.prodno}" />
								</c:url>								
				                <a href="${viewUrl}">
				                    <div class="sorting thumbnail">
			                        	<img alt="${item.subject}" class="img-rounded" src="${pageContext.request.contextPath}/assets/img${item.filepath}">
				                        <div class="caption">
				                            <h5>${item.subject}</h5>
				                            <h4>${item.price}원</h4>
				                        </div>
				                    </div>
				                </a>
				            </div>
			            </c:forEach>
		            </c:otherwise>
	            </c:choose>
              </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="anou">
        <p>(주)사이다마켓은 통신판매중개자로서 거래당사자가 아니며,
          <br /> 판매자가 등록한 상품정보 및 거래에 대해 (주)사이다마켓은 일체 책임을 지지 않습니다.
        </p>
      </div>
  </section>
  <div class="fixed-btn">
  <c:set var="is" value="NO" />
  <c:forEach var="item" items="${membprod}" varStatus="status">
  	<c:if test="${myNum==item.membno}">
  		<div class="col-xs-2 zzim"><a href="#" id="like" data-membno="${myNum}" data-prodno="${product.prodno}"><i class="glyphicon glyphicon-heart"></i></a></div>
  		<c:set var="is" value="OK" />
  	</c:if>
  </c:forEach>
  <c:if test="${is=='NO'}">
  	<div class="col-xs-2 zzim"><a href="#" id="like" data-membno="${myNum}" data-prodno="${product.prodno}"><i class="glyphicon glyphicon-heart-empty"></i></a></div>
  </c:if>
    
          
    
    <c:choose>
  	<c:when test="${myNum==product.seller}">
    <div class="col-xs-5"><button type="submit" class="btn btn-warning" id="dir_trade"><span
          class="cool">쿨하게</span><span class="trade">수정하기</span></button></div>
    <div class="col-xs-5"><button type="submit" class="btn btn-danger" id="dir_pay"><span class="cool">쿨하게</span><span
          class="trade">삭제하기</span></button></div>  	
  	</c:when>
  	<c:otherwise>
  		<c:choose>
  			<c:when test="${product.how=='X' }">
    <div class="col-xs-5"><button type="submit" class="btn btn-warning" id="dir_trade"><span
          class="cool">쿨하게</span><span class="trade">직거래</span></button></div>
    <div class="col-xs-5"><button type="submit" class="btn btn-primary" id="dir_pay" data-prodno="${product.prodno}"><span class="cool">쿨하게</span><span
          class="trade">바로결제</span></button></div>
          	</c:when>
          	<c:when test="${product.how=='J' }">
    <div class="col-xs-10"><button type="submit" class="btn btn-warning" id="dir_trade"><span
          class="cool">쿨하게</span><span class="trade">직거래</span></button></div>
          	</c:when>
          	<c:when test="${product.how=='T' }">
    <div class="col-xs-10"><button type="submit" class="btn btn-primary" id="dir_pay" data-prodno="${product.prodno}"><span class="cool">쿨하게</span><span
          class="trade">바로결제</span></button></div>
          	</c:when>
        </c:choose>  
    </c:otherwise>      
    </c:choose>
  </div>

  	<!-- jQeury Ajax Form plugin CDN -->
  	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>	
  <script type="text/javascript">
    //캐러셀 플러그인
    var mySwiper = new Swiper('.swiper-container', {
      loop: true,
      pagination: {
        el: '.swiper-pagination',
        dynamicBullets: 'true'
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
    //라이트박스 플러그인
    lightbox.option({
      albumLabel: ""
    });
    $(function () {
      /** 신고하기 링크를 클릭한 경우 */
      $("#flag_this").click(function (e) {
    	  e.preventDefault();
    	  var myNum = '<%=session.getAttribute("myNum")%>';
    	  if(myNum=="null"){
    		  if(confirm("신고하기는 로그인 후 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
    			window.location = "${pageContext.request.contextPath}/member/login.cider";  
    		  } else{
    		  return false;
    		  }
    	  }
        var user = $(".item_title>h3").html();
        $("#singo_name").html(user);
        $("#background").fadeIn(300);   // 배경 레이어를 화면에 표시한다.
        $("#singo").fadeIn(200);
      });
      
      $("#singo_cancle").click(function (e) {
        $("#background").fadeOut(300);
        $("#singo").fadeOut(200);
        $("#singo_content").val('');
        $("#singo_type > option:eq(0)").prop('selected', true);
      });
      
      /**신고하기 구현 */
      $("#sendsingo").ajaxForm({
                // 전송 메서드 지정
                method: "POST",
                // 서버에서 200 응답을 전달한 경우 실행됨
                success: function(json) {
                    console.log(json);
                    if (json.rt == "OK") {
                 	   alert("신고가 접수되었습니다.");
                        $("#background").fadeOut(300);
                        $("#singo").fadeOut(200);
                        $("#singo_type > option:eq(0)").prop('selected', true);
                        $("#singo_content").val(''); 
                    }
                }
            });


      /** 탭 버튼의 클릭 처리 */
      $(".tab-button-item-link").click(function (e) {
        $(".tab-button-item-link").not(this).removeClass("selected");
        $(this).addClass("selected");
        var target = $(this).attr('href');
        $(target).removeClass('hide');
        $(".tab-panel > div").not($(target)).addClass('hide');

      });

      //찜하기 버튼 누를 시 하트버튼 토글
      $("#like").click(function (e) {
        e.preventDefault();
  	  var myNum = '<%=session.getAttribute("myNum")%>';
	  if(myNum=="null"){
		  if(confirm("찜하기는 로그인 후 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
			window.location = "${pageContext.request.contextPath}/member/login.cider";  
		  } else{
		  return false;
		  }
	  }
        var heart = $(this).find("i").hasClass("glyphicon-heart");
        var prodno = $(this).data("prodno");
        var membno = $(this).data("membno");
        
        if (heart) {
        	//삭제
        	$.delete("${pageContext.request.contextPath}/membprod_delete",{
          	 "prodno": prodno,
          	 "membno": membno
            }, function(json){
          	  if(json.rt=="OK"){
          		var count = json.item.length;
          		$("#countzzim").html(count);
          	  }
        });
        	$(this).find("i").removeClass("glyphicon-heart").addClass("glyphicon-heart-empty");
        } else {
        	//등록
        	$.post("${pageContext.request.contextPath}/membprod_add",{
        		"prodno": prodno,
             	"membno": membno
            }, function(json){
          	  if(json.rt=="OK"){
          		var count = json.item.length;
          		$("#countzzim").html(count);
          	  }
        });
        	$(this).find("i").removeClass("glyphicon-heart-empty").addClass("glyphicon-heart");
        }
      });

      /** 직거래 버튼 클릭한 경우  쪽지를 보내는 모달창이 열린다.*/
      $("#dir_trade").click(function (e) {
        e.preventDefault();
  		  var myNum = '<%=session.getAttribute("myNum")%>';
		  if(myNum=="null"){
		  if(confirm("로그인 후 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
			window.location = "${pageContext.request.contextPath}/member/login.cider";  
		  } else{
		  return false;
		  }
		  }
        $("#background").fadeIn(300);
        $("#front").fadeIn(200);

      });
      
      $("#send_cancle").click(function (e) {
        $("#send_input").val('');
        $("#background").fadeOut(300);
        $("#front").fadeOut(200);
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
                	   if(confirm("쪽지를 보냈습니다. 쪽지함으로 이동하시겠습니까?")){
                		   window.location="${pageContext.request.contextPath}/msgbox/sender.cider";
                	   }
                	   
                       $("#send_input").val('');
                       $("#background").fadeOut(300);
                       $("#front").fadeOut(200);  
                   }
                }
                });
      });
        
      // 바로 결제 누를때 주문서 화면으로 이동
      $("#dir_pay").click(function (e) {
        e.preventDefault();
  	  	var myNum = '<%=session.getAttribute("myNum")%>';
	  	if(myNum=="null"){
		if(confirm("로그인 후 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
			window.location = "${pageContext.request.contextPath}/member/login.cider";  
		  } else{
		  return false;
		  }
	  	} else{
		var prodno = $(this).data("prodno");
        window.location="${pageContext.request.contextPath}/user/order_sheet.cider?prodno="+prodno;
	  	}
      });

      // 댓글달기 구현
      $("#send_reply").submit(function(e) {
       	  e.preventDefault();
    	  var myNum = '<%=session.getAttribute("myNum")%>';
    	  if(myNum=="null"){
    		  if(confirm("댓글작성은 로그인 후 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
    			window.location = "${pageContext.request.contextPath}/member/login.cider";  
    		  } else{
    		  return false;
    		  }
    	  }
       	 var input = $("#content").val();
         if (!input || input.trim() == "") {
           alert("댓글 내용을 작성해 주세요.");
           $("#content").val("");
           $("#content").focus();
           return false;
         }
         
         if(confirm("댓글을 등록하시겠습니까?")){
        	 /** Ajax 호출 */
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
       					location.reload();
       				}
       			}
               });
         }
          
          
        });
      
   // 댓글달기 구현
      $(".send_rereply").submit(function(e) {
       	  e.preventDefault();
    	  var myNum = '<%=session.getAttribute("myNum")%>';
    	  if(myNum=="null"){
    		  if(confirm("댓글작성은 로그인 후 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
    			window.location = "${pageContext.request.contextPath}/member/login.cider";  
    		  } else{
    		  return false;
    		  }
    	  }
       	 var input = $(this).find(".rereply_content").val();
         if (!input || input.trim() == "") {
           alert("댓글 내용을 작성해 주세요.");
           $(this).find(".rereply_content").val("");
           $(this).find(".rereply_content").focus();
           return false;
         }
         
         if(confirm("댓글을 등록하시겠습니까?")){
        	 /** Ajax 호출 */
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
       					location.reload();
       				}
       			}
               });
         }
          
          
        });
      
      /** 댓글삭제 구현 */
      $(".re_remove").click(function (e) { 		//삭제 버튼을 눌렀을때
        e.preventDefault();
        let target = $(this);					//이벤트가 발생한 객체 자신
        let replyno = target.data("replyno");		//data-msgno값을 가져옴
        
        //삭제 확인
        if(!confirm("댓글를 삭제하시겠습니까?")){
      	  return false;
        }
        
        $.put("${pageContext.request.contextPath}/reply_delete",{
          	 "replyno": replyno
            }, function(json){
          	  if(json.rt=="OK"){
          		alert("삭제가 완료되었습니다.");
          		//삭제 완료 후 목록 페이지로 이동
          		location.reload();
          	  }
        });
      });
      
      /** 대댓글삭제 구현 */
      $(".rere_remove").click(function (e) { 		//삭제 버튼을 눌렀을때
        e.preventDefault();
        let target = $(this);					//이벤트가 발생한 객체 자신
        let rereplyno = target.data("rereplyno");		//data-msgno값을 가져옴
        
        //삭제 확인
        if(!confirm("댓글를 삭제하시겠습니까?")){
      	  return false;
        }
        
        $.delete("${pageContext.request.contextPath}/rereply_delete",{
          	 "rereplyno": rereplyno
            }, function(json){
          	  if(json.rt=="OK"){
          		alert("삭제가 완료되었습니다.");
          		//삭제 완료 후 목록 페이지로 이동
          		location.reload();
          	  }
        });
      });
   
    }); //온로드 제이쿼리 끝
    
    //답글 버튼 클릭시 입력창 토글
    $(document).on('click', '.reply', function (e) {
      e.preventDefault();
      $(this).next().slideToggle(300);
    });
  </script>
</body>

</html>