<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>관리자 공지사항 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/notice_write_adm.css" />
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
            
                <!-- <div class="title-menu clearfix">
                    <h4>공지사항</h4>
                    <select class="form-control clearfix" id="align-number">
                        <option value>10개씩보기</option>
                        <option value="lowprice">20개씩보기</option>
                    </select>
                    <select class="form-control clearfix" id="align-menu">
                        <option value>작성일순</option>
                        <option value="lowprice">조회수순</option>
                    </select>
                </div> -->


                <form class="form-horizontal" role="form">
                    <fieldset>

                        
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="subject" class="col-md-2 control-label">게시판</label>
                            <div class="col-md-2">
                                <select class="form-control clearfix">
                                    <option value>공지사항</option>
                                    <option value="lowprice">이벤트게시판</option>
                                    <option value="lowprice">일반문의</option>
                                    <option value="lowprice">자주묻는질문</option>
                                    <option value="lowprice">운영정책</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="subject" class="col-md-2 control-label">글 제목</label>
                            <div class="col-md-10">
                                <input type="text" class="form-control" id="subject" placeholder="제목을 입력하세요.">
                            </div>
                        </div>
                        <!--// 입력양식 -->
                        
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="writer" class="col-md-2 control-label">작성자 이름</label>
                            <div class="col-lg-10">
                                <input type="password" class="form-control" id="writer" placeholder="이름을 입력하세요.">
                            </div>
                        </div>
                        <!--// 입력양식 -->
                        
                        <!-- 입력양식 -->
                        <div class="form-group">
                            <label for="content" class="col-md-2 control-label">내용</label>
                            <div class="col-md-10">
                                <textarea id="content" class="form-control" rows="15" placeholder="내용을 입력하세요."></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="content" class="col-md-2 control-label">파일첨부</label>
                            <div class="col-md-2">
                                <input type="file" id="avatar" name="avatar"accept="image/png, image/jpeg">
                            </div>
                        </div>
                        <form class="form-inline">
                            <div class="regi_cancel">
	                            <button id="regi" type="button" class="btn btn-primary">등록</button>
	                            <button id="cancel" type="button" class="btn btn-default">취소</button>
                            </div>
                         </form>
                        <!--// 입력양식 -->
                        
                        <!-- 입력양식 -->

                        <!--// 입력양식 -->
                    </fieldset>
                </form>
                <!-- <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="button"><span
                                class="glyphicon glyphicon-search"></span></button>
                    </div>
                    <input type="text" class="form-control" id="search_btn" placeholder="키워드를 입력하세요">
                </div>
                <ul class="pagination">
                    <li class="disabled"><a href="#">&laquo;</a></li>
                    <li class="active"><span>1 <span class="sr-only">(current)</span></span></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li><a href="#">&raquo;</a></li>
                </ul> -->
            </div>
        </div>
    </div>

    <!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>

    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
    <script type="text/javascript">
        $(function () {
            //로그아웃
            $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result == true) {
                    location.replace('${pageContext.request.contextPath}/admin/login_adm.cider'); 
                }
            });

              // 글쓰기 등록 후 이동 
		      $("#regi").click(function(e){
                e.preventDefault();
                swal({ 
                title: '등록',
                text: "글을 등록 하시겠습니까?" ,
                type:'warning', //종류
                confirmButtonText:'네', //확인버튼 표시문구
                showCancelButton:true, //취소버튼 표시여부
                cancelButtonText:'아니오', //취소버튼 표시문구 
                }).then(function(result){
                    if(result.value) {
                        window.open("${pageContext.request.contextPath}/admin/board_adm.cider", "_self");
                    } else {
                     swal("취소하였습니다.")
                    }
                 });
             });

             $("#cancel").click(function(e){
                e.preventDefault();
                swal({ 
                title: '취소',
                text: "취소 하시겠습니까?" ,
                type:'warning', //종류
                confirmButtonText:'네', //확인버튼 표시문구
                showCancelButton:true, //취소버튼 표시여부
                cancelButtonText:'아니오', //취소버튼 표시문구 
                }).then(function(result){
                    if(result.value) {
                        window.open("${pageContext.request.contextPath}/admin/board_adm.cider", "_self");
                    } else {
                     swal("취소하였습니다.")
                    }
                 });
             });
    });
    </script>
</body>
</html>