<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>공지사항 - 사이다마켓</title>
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
                <h3 class="text-center">공지사항</h3>
                
                <!-- 목록 -->
                <div class="list-group" id="notice-list">
                  <!-- Ajax로 로드한 결과가 표시될 곳 -->
                </div>
                <div class="clearfix text-center pagination">
                    <ul>
                        <li class="arr disabled"><a href="#">&laquo;</a></li>
                        <li class="active"><span>1 <span class="sr-only">(current)</span></span></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li class="arr"><a href="#">&raquo;</a></li>
                    </ul>
                </div>

            </div>
        </section>
        
        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

        <!-- template -->
        <script id="notice_tmpl" type="text/x-handlebars-template">
          {{#each noticeList}}
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
          $.get("${pageContext.request.contextPath}/assets/plugins/ajax/notice.json", function(req) {
            console.log(req);
            if (!req) {
              $("#notice-list").append("<p>공지사항이 없습니다.</p>");
            } else {
              // 미리 준비한 HTML틀을 읽어온다.
              var template = Handlebars.compile($("#notice_tmpl").html());
              // Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
              var html = template(req);
              // #dept_list_body 읽어온 내용을 추가한다.
              $("#notice-list").append(html);
            }
          });
        }
        
        $(function() {
          get_list();

          $(".pagination li").click(function(e) {
            e.preventDefault();
            $(".pagination li").not(this).removeClass("active");
            $(this).addClass("active");
            $("#notice-list").empty();
            get_list();
          });
        });

        </script>
</body>

</html>