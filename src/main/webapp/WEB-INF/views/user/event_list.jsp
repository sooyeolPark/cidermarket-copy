<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>이벤트 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                <h3 class="text-center">이벤트</h3>
                
                <!-- 목록 -->
                <div class="list-group" id="event-list">
                  <!-- Ajax로 로드한 결과가 표시될 곳 -->
                </div>
                <button type="button" id="more" class="btn btn-primary btn-block btn-lg" disabled>더보기</button>
                
            </div>
        </section>
        
        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

        <!-- template -->
        <script id="event_tmpl" type="text/x-handlebars-template">
          {{#each eventList}}
          <a href="${pageContext.request.contextPath}/user/{{href}}" class="list-group-item clearfix">
            <span class="boardImg"><img src="${pageContext.request.contextPath}/assets/{{imgUrl}}" alt="{{title}}"></span>
            <p class="boardTitle">{{title}}</p>
            <span class="boardDate">{{date}}</span>
          </a>
          {{/each}}
        </script>

        <!-- Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
        <!-- ajax-helper -->
        <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
        <!-- handlebar plugin -->
        <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
        <!-- 사용자 정의 스크립트 -->
        <script type="text/javascript">
        /** AJAX로 JSON데이터를 가져와서 화면에 출력하는 함수 */
        function get_list() {
          $.get("${pageContext.request.contextPath}/assets/plugins/ajax/event.json", function(req) {
            // 미리 준비한 HTML틀을 읽어온다.
            var template = Handlebars.compile($("#event_tmpl").html());
            // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
            var html = template(req);
            // #dept_list_body 읽어온 내용을 추가한다.
            $("#event-list").append(html);
          });
        }

        $(function() {
          get_list();		// 페이지가 열림과 동시에 호출된다.
          $("#more").click(function(e) {
            get_list(); // 버튼이 클릭되면 호출된다.
          });
        });
      </script>
</body>

</html>