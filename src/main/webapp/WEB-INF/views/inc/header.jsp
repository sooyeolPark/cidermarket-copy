<%@page import="java.util.ArrayList"%>
<%@page import="study.shop.cidermarket.model.CookieModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%

Cookie[] cookies = request.getCookies();
if(cookies!=null){
List<CookieModel> cookie_search = new ArrayList<CookieModel>();

for(int i =0; i< cookies.length; i++) {
	if(cookies[i].getName().contains("mySearch")) {
		CookieModel temp = new CookieModel();
		temp.setName(cookies[i].getName());
		temp.setValue(cookies[i].getValue());
	cookie_search.add(temp);
	}
}

//최신 10개 담기
List<CookieModel> cookie_10 = new ArrayList<CookieModel>();

if(cookie_search.size()!=0) {
	for (int i = 0; i<cookie_search.size() ; i++) {
		if(!cookie_search.get(cookie_search.size()-1-i).getValue().trim().equals("")) {
			cookie_10.add(cookie_search.get(cookie_search.size()-1-i));
		}
		if (cookie_10.size()==10) {
			break;
		}
	}
}

pageContext.setAttribute("cookie_10", cookie_10);
} else{
	pageContext.setAttribute("cookie_10", null);
}
%>
<div class="navbar navbar-fixed-top" role="navigation">
	<div class="container">
		<div id="logo" class="text-center">
			<a href="${pageContext.request.contextPath}">
				<img src="${pageContext.request.contextPath}/assets/img/logo.png" width="100%" alt="사이다마켓 로고" />
			</a>
		</div>
		<div class="ico-wrap">
			<div id="btnNav">
				<a href="#" onclick="$('.aside').asidebar('open'); return false;">
					<span class="glyphicon glyphicon-menu-hamburger"></span>
				</a>
			</div>
			<div id="btnAlarm">
				<a href="${pageContext.request.contextPath}/alarm.cider">
					<span class="newAlarm"></span><img src="${pageContext.request.contextPath}/assets/img/ico_bell.png" width="100%" alt="알림" />
				</a>
			</div>
			<div id="btnSearch">
				<a href="#">
					<span class="glyphicon glyphicon-search"></span>
				</a>
			</div>
		</div>
	</div>
	<div id="searchBox" class="container">
		<form id="searchForm" action="${pageContext.request.contextPath}/search.cider">
			<input type="search" class="form-control" name="keyword" id="keyword" value="${cookie.mySearch.value}" placeholder="키워드를 입력해 주세요." />
			<button id="searchBtn" class="btn btnSearch-s" type="submit">
				<i class="glyphicon glyphicon-search"></i>
			</button>
		</form>
		<div class="interest col-xs-6">
			<h5 class="label label-warning">인기 키워드</h5>
			<ul id="i-key"></ul>
		</div>
		<div class="latest col-xs-6">
			<h5 class="label label-default">최근 검색</h5>
			<ul id="l-key">
			<c:set var="cookie_10" value="${pageScope.cookie_10}" />
   			<c:choose>
    			<c:when test="${cookie_10 == null}">
   					<li>검색기록없음</li>
    			</c:when>
    			<c:otherwise>
    				<c:forEach var="item" items="${cookie_10}">
    					<li class="cookie_hover">
    					<a href="${pageContext.request.contextPath}/search.cider?keyword=${item.value}" >${item.value}</a> 
    					<a href="#" class="pull-right cookie_del " data-name="${item.name}">
    					<i class="glyphicon glyphicon-trash"></i>
    					</a>
    					</li>
    				</c:forEach>
				</c:otherwise>
   			</c:choose>
   			</ul>
		</div>
		<div id="searchClose" class="col-xs-12 text-center">닫기</div>
	</div>
</div>
<!-- 사이드바 시작 -->
<div class="aside">
	<div class="aside-header">
		<img src="${pageContext.request.contextPath}/assets/img/logo2.png" alt="로고" width="100%" />
		<div>
			<h5 class="btnn-login">
			<c:choose>
	      		<c:when test="${myId == null}">
	      			로그인 후 판매 가능합니다.
	      		</c:when>
	      		<c:otherwise>
					<span id="username">${myId}</span>님 쿨거래 하세요~!		
				</c:otherwise>
      		</c:choose>
			</h5>
		</div>
		<span class="close" data-dismiss="aside" aria-hidden="true">&times;</span>
	</div>
	
	<c:choose>
   		<c:when test="${myId == null}">
   			<div class="aside-contents">
				<div class="btnn-logout view-block">
					<a href="${pageContext.request.contextPath}/member/login.cider" class="btn btn-primary">로그인</a>
					<a href="${pageContext.request.contextPath}/member/join.cider" class="btn btn-info">회원가입</a>
					<div class="btnn-temp">
						<a href="${pageContext.request.contextPath}/admin/login_adm.cider" target="_blank" class="btn btn-danger templogin">관리자</a>
					</div>
				</div>
			</div>
   		</c:when>
   		<c:otherwise>
			<div class="btnn-login">
      			<a href="${pageContext.request.contextPath}/msgbox/receiver.cider" class="btn btn-info">쪽지함</a>
      			<a href="${pageContext.request.contextPath}/member/record/selling.cider" class="btn btn-info">거래내역</a>
      			<a href="${pageContext.request.contextPath}/mystore/${shopaddress}" class="btn btn-info">내상점</a>
      			<div class="btnn-temp">
	      			<a href="${pageContext.request.contextPath}/itemreg.cider" class="btn btn-primary">상품등록</a>
					<a href="${pageContext.request.contextPath}/admin/login_adm.cider" class="btn btn-danger templogin">관리자</a>
				</div>
    		</div>			
		</c:otherwise>
  	</c:choose>
    
    <div class="gory_title">CATEGORY</div>
    <div class="category">
      <ul id="category">
      	
      </ul>
    </div>
    <div class="nav_bar"><a href="${pageContext.request.contextPath}/user/event_list.cider">이벤트</a></div>
    <div class="nav_bar"><a href="${pageContext.request.contextPath}/notice/list.cider">공지사항</a></div>
    <div class="nav_bar"><a href="${pageContext.request.contextPath}/help/help.cider?selected=faq">헬프센터</a></div>
    <div class="nav_bar"><a href="${pageContext.request.contextPath}/help/protection.cider">개인정보처리방침</a></div>
    
    <c:choose>
   		<c:when test="${myId != null}">
		    <div class="btnn-login">
		      <a href="${pageContext.request.contextPath}/logout.cider" class="btn btn-danger logout">로그아웃</a>
		    </div>
   		</c:when>
  	</c:choose>
    <address class="sb_address">
      &copy;(주)사이다마켓. ALL RIGHTS RESERVED.
    </address>
</div>

<div class="aside-backdrop"></div>

<!-- template -->
<script id="key_tmpl" type="text/x-handlebars-template">
  {{#each i-key}}
    <li>
      <a href="{{khref}}">
        <span>
          {{knum}}
        </span>
        <span>
          {{ktitle}}
        </span>
      </a>
    </li>
  {{/each}}
</script>

<!-- template -->
<script id="category_tmpl" type="text/x-handlebars-template">
  {{#each item}}
    <li>
    	<a href="${pageContext.request.contextPath}/item_list.cider/{{cateno}}">
			<span><img src="${pageContext.request.contextPath}/assets/img{{filepath}}" />{{name}}</span>
		</a>
    </li>
  {{/each}}
</script>

<!-- // 사이드바 시작 -->
<script src="${pageContext.request.contextPath}/assets/js/searchbox.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/headerScroll.js"></script>
<!-- ajax-helper -->
<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
<!-- handlebar plugin -->
<script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
<!-- 사용자 정의 스크립트 -->
<script type="text/javascript">

 	//쿠키 저장함수 | 쿠키이름=쿠키값; Domain=도메인값; Path=경로값; Expires=GMT형식의만료일시
	function setCookie(name, value, exdays) {
	    var todayDate = new Date();
	    todayDate.setDate(todayDate.getTime() + (exdays*60));
	    document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	// 쿠키 불러오는 함수
	function getCookie(Name) { 
	    var search = Name + "=";
	    if (document.cookie.length > 0) { // if there are any cookies
	        offset = document.cookie.indexOf(search);
	        if (offset != -1) { // if cookie exists
	            offset += search.length; // set index of beginning of value
	            end = document.cookie.indexOf(";", offset); // set index of end of cookie value
	            if (end == -1)
	                end = document.cookie.length;
	            return unescape(document.cookie.substring(offset, end));
	        }
	    }
	}

	

	

  /** AJAX로 JSON데이터를 가져와서 화면에 출력하는 함수 */
 function get_key_list() {
    $.get("${pageContext.request.contextPath}/assets/plugins/ajax/interest_keyword.json", function (req) {
      // 미리 준비한 HTML틀을 읽어온다.
      var template = Handlebars.compile($("#key_tmpl").html());
      // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
      var html = template(req);
      // #dept_list_body 읽어온 내용을 추가한다.
      $("#i-key").append(html);
    });
  }
  
  function categoryList() {
	  $.ajax({
        type: "GET",
        url: "${pageContext.request.contextPath}/header",
        success: function(json) {
				console.log(json);
				if (json.rt == "OK") {
					var template = Handlebars.compile($("#category_tmpl").html());
				    var html = template(json);
				    $("#category").append(html);
				}
			}
      }); 
  }
  // 카테고리 호출
  window.onload = categoryList;
  

  $(function () {
    get_key_list(); // 인기키워드 호출    
    
    /** Ajax 호출 */
    $(".logout").click(function(){
	    $.ajax({
	        type: "GET",
	        url: "${pageContext.request.contextPath}/logout.cider",
	        success: function(json) {
					console.log(json);
					alert("로그아웃 되셨습니다.");
					if (json.rt == "OK") {
						window.location = "${pageContext.request.contextPath}";
					}
				}
	      });    	
    });
    
    /** 최근검색어 삭제 */
    $(".cookie_del").click(function(e){
    	var c_name = $(this).data("name");
    	//과거시점으로 설정하여 쿠키 삭제
    	setCookie(c_name, "", -1);
    	$(this).parent("li").remove();
    });
  });
</script>