<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html>

<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>일반문의 - 사이다마켓</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/question_reply_adm.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/header&footer_adm.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.23/datatables.min.css"/>
    <!-- 반응형 웹을 지원하지 않을 경우 -->
    <!-- <link rel="stylesheet" href="assets/css/non-responsive.css" /> -->
    <!-- IE8 이하 버전 지원 -->
    <!--[if lt IE 9]>
<script type="text/javascript" src="assets/js/html5shiv.js"></script>
<script type="text/javascript" src="assets/js/respond.min.js"></script>
<![endif]-->
    <!-- IE10 반응형 웹 버그 보완 -->
    <!--[if gt IE 9]>
<link rel="stylesheet" type="text/css" href="assets/css/ie10.css" />
<script type="text/javascript" src="assets/js/ie10.js"></script>
<![endif]-->
</head>

<body>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header_adm.jsp"%>
	
	<div class="container">
        <div class="row">
            <div class="col-lg-2">
                <%@ include file="/WEB-INF/views/admin/board_adm_left.jsp"%>
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

                <div>
                    <div class="title_read clearfix">
                        <span class="pull-left title">핸드폰 번호 변경 문의드립니다. </span>
                        <span class="pull-right date_view">/ 답변대기 </span>
                        <span class="pull-right date_num">2020-11-01</span>
                        <span class="pull-right date">작성일</span>
                    </div>

                
                    <div class="row1 clearfix">
                    <p class="reply_info col-md-2">
                        <span>이름</span>
                        <span>연락처</span>
                        <span>이메일</span>
                        <span>유형</span>

                    </p>
                    
                    <p class="reply_info col-md-2">
                        <span class="name">이동훈</span>
                        <span class="phone">0102222444</span>
                        <span class="email">hoonyhoney@gmail.com</span>
                        <span class="name">개인정보</span>
                    </p>
                </div>
                    <p class="content_body col-md-12">
                        핸드폰번호 변경하고 싶은데 아래 사진처럼 잘 안되네요.
                    </p>
                    <div class="form-group">
                        <label for="content" class="control-label">답변 </label>
                        <textarea id="content" class="form-control" rows="3" placeholder="답변을 입력해주세요."></textarea>
                      </div>

                    <form class="form-inline">
                        <div class="regi_cancel">
                        <button id="regi"type="button" class="btn btn-primary">등록</button>
                        <button id="cancel"type="button" class="btn btn-warning">취소</button>
                        </div>
                      </form>

                </div>

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



    <!--/row-->
    <hr>
    <footer class="footer">

        <!-- <a href="#" class="btn btn-primary btn-sm">
                    <span class="glyphicon glyphicon-triangle-left"></span> 이전
                  </a>
                  <a href="#" class="btn btn-primary btn-sm">
                    <span class="glyphicon glyphicon-triangle-right"></span> 다음
                  </a> -->

        <address>
            <strong>&copy; (주)사이다마켓.All right reserved</strong><br>
        </address>
    </footer>

    <!--/.container-->
    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
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
      
    

    //   전체선택
      $("#all-check").change(function(){
          $(".board").prop('checked',$(this).prop('checked'));
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
                        window.open("${pageContext.request.contextPath}/admin/question_adm.cider", "_self");
                    } else {
                     swal("취소하였습니다.")
                    }
                        


                 });
             });

             $("#cancel").click(function(e){
                e.preventDefault();
                swal({ 
                title: '취소',
                text: "글작성을 취소 하시겠습니까?" ,
                type:'warning', //종류
                confirmButtonText:'네', //확인버튼 표시문구
                showCancelButton:true, //취소버튼 표시여부
                cancelButtonText:'아니오', //취소버튼 표시문구 
                }).then(function(result){
                    if(result.value) {
                        window.open("${pageContext.request.contextPath}/admin/question_adm.cider", "_self");
                    } else {
                     swal("취소하였습니다.")
                    }
                        


                 });
             });

    });

    </script>

</body>

</html>