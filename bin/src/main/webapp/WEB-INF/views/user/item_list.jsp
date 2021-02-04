<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>상품목록 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

        <section>
            <!-- Item 영역 -->
            <div class="container">
                <p class="category-name text-center">Category</p>
                <h3 id="category-title" class="text-center">신발/가방/잡화</h3>

                <div class="item-filter text-center">
                    <button type="button" class="btn btn-danger btn-lg" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-filter"></span> 상품필터</button>
                </div>

                <!-- Modal -->
                <div class="modal fade" id="myModal">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">상품필터</h4>
                        </div>
                        <div class="modal-body">
                            <div class="filter_category_sort">
                                <div class="filter_sort">
                                    <h5>상품상태</h5>
                                    <button class="btn btn-tag"><span class="glyphicon glyphicon-ok"></span> 새상품</button>
                                    <button class="btn btn-tag"><span class="glyphicon glyphicon-ok"></span> 거의새것</button>
                                    <button class="btn btn-tag"><span class="glyphicon glyphicon-ok"></span> 중고</button>
                                </div>
                                <div class="filter_sort">
                                    <h5>판매방법</h5>
                                    <button class="btn btn-tag"><span class="glyphicon glyphicon-ok"></span> 직거래</button>
                                    <button class="btn btn-tag"><span class="glyphicon glyphicon-ok"></span> 택배거래</button>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">선택적용</button>
                        </div>
                        </div>
                    </div>
                </div><!-- Modal -->

                <div class="item-row">
                    <select class="form-control" id="item-select">
                        <option value="fastest">최신순</option>
                        <option value="lowprice">저가순</option>
                        <option value="highprice">고가순</option>
                    </select>
                    <div class="btn-group">
                        <button id="sortList" type="button" class="btn btn-default btn-list"><span class="glyphicon glyphicon glyphicon-th-list"></span><span class="sr-only">썸네일로 보기</span></button>
                        <button id="sortThumb" type="button" class="btn btn-default btn-list active"><span class="glyphicon glyphicon glyphicon-th-large"></span><span class="sr-only">리스트로 보기</span></button>
                    </div>
                </div>

                <div class="box" id="item-list">
                    <!-- Ajax로 로드한 결과가 표시될 곳 -->
                </div>
                <button type="button" id="more" class="btn btn-primary btn-block btn-lg">더보기</button>
                
            </div>
        </section>
        
        <!-- 푸터 영역 -->
		<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

        <!-- template -->
        <script id="item_tmpl" type="text/x-handlebars-template">
			{{#each item}}
            <div class="col-xs-6 col-sm-4 col-lg-3 item-list">
                <a href="${pageContext.request.contextPath}/user/{{href}}">
                    <div class="sorting thumbnail">
                        <img alt="{{title}}" class="img-rounded" src="${pageContext.request.contextPath}/assets/{{imgurl}}">
                        <div class="caption">
                            <h5>{{title}}</h5>
                            <h4>{{price}}원</h4>
                        </div>
                    </div>
                </a>
            </div>
            {{/each}}
		</script>

        <!-- Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
        <!-- ajax-helper -->
	    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	    <!-- handlebar plugin -->
	    <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
        <script type="text/javascript">
            /** AJAX로 JSON데이터를 가져와서 화면에 출력하는 함수 */
            function get_sort() {
                if($("#sortList").hasClass("active")) {
                    $(".item-list").removeClass("col-xs-6 col-sm-4 col-md-3");
                    $(".item-list").addClass("col-xs-12 col-sm-6 col-md-6");
                    $(".sorting").removeClass("thumbnail");
                    $(".sorting").addClass("itemList");
                } else if ($("#sortThumb").hasClass("active")) {
                    $(".item-list").removeClass("col-xs-12 col-sm-6 col-md-6");
                    $(".item-list").addClass("col-xs-6 col-sm-4 col-md-3");
                    $(".sorting").removeClass("itemList");
                    $(".sorting").addClass("thumbnail");
                };
            }
            
			function get_list() {
				$.get("${pageContext.request.contextPath}/assets/plugins/ajax/item.json", function(req) {
					// 미리 준비한 HTML틀을 읽어온다.
					var template = Handlebars.compile($("#item_tmpl").html());
					// Ajax를 통해서 읽어온 JSON을 템플릿에 병합한다.
					var html = template(req);
					// #dept_list_body 읽어온 내용을 추가한다.
                    $("#item-list").append(html);
                    get_sort();
				});
            }
            
            $(function() {
                get_list();		// 페이지가 열림과 동시에 호출된다.
                
                /* 상품필터 */
                $(".btn-tag").click(function() {
                    $(this).toggleClass('active');
                });

                /* 상품리스트형 */
                $(".btn-list").click(function() {
                    $(".btn-list").not(this).removeClass('active');
                    $(this).toggleClass('active');
                    get_sort();
                });
                
                /* 상품 더보기 */
				$("#more").click(function(e) {
                    get_list();
                });
            });

		</script>
</body>

</html>