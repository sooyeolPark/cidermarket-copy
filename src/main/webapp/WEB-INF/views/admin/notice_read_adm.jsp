<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>관리자 공지사항 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/notice_read_adm.css" />
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

                <div>
                    <div class="title_read clearfix">
                        <span class="pull-left title">사이다마켓 공지사항</span>
                        <span class="pull-right view_num">999</span>
                        <span class="pull-right date_view">/ 조회수 </span>
                        <span class="pull-right date_num">2020-11-01</span>
                        <span class="pull-right date">작성일</span>
                    </div>
                    <p class="content_body">
                    사이다마켓 공지사항<br>
                    <br>
                    <br>
                    사이다마켓은 공유를 통해 삶의 여유를 제공하는 개인간거래 중심의 마켓입니다.<br>
                    누구나 사고 팔고 나누는 공간으로, 다양한 개인들이 모여 자유롭고 편리하게 안전한 거래를 할 수 있습니다.
                    <br> 서로 존중하고 배려하는 건강한 개인간거래 문화를 회원 여러분과 함께 만들어가기 위해 아래의 운영정책을 공지합니다.<br>
                    운영정책은 개인간거래에 적합한 원칙과 기준으로 지속적으로 개선해나아가겠습니다.<br>
                    ※ 건강한 마켓 환경과 다수의 정상적인 회원 보호를 위해, 운영정책을 준수하지 않은 경우 헬로마켓은 관련 행위를 확인 후 결과에 따라 주의를 당부하거나, 사전안내 없이 서비스 이용을 한시적/영구적으로 일부 또는 전체 제한할 수 있습니다.
                    </p>

                    <form class="form-inline">
                        <div class="regi_cancel">
                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/notice_write_adm.cider" role="button">수정</a>
                            <button id="delete" class="btn btn-warning"  type="button">삭제</button>
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
			//   전체선택
		    $("#all-check").change(function(){
		        $(".board").prop('checked',$(this).prop('checked'));
		    });

	        // 로그아웃
	        $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('${pageContext.request.contextPath}/admin/login_adm.cider'); 
                }else{

                }
            });

	        // 로그아웃
	        $("#delete").click(function () {
	        swal({ 
	          title: '삭제',
	          text: "정말 삭제 하시겠습니까?" ,
	          type:'warning', //종류
	          confirmButtonText:'네', //확인버튼 표시문구
	          showCancelButton:true, //취소버튼 표시여부
	          cancelButtonText:'아니오', //취소버튼 표시문구 
	        });
		        // .then(function(result){
		        //   if(result.value) {   //확인버튼이 눌러진 경우 
		        //     swal('로그아웃', '로그아웃 되었습니다.', 'success');
		        //   } else if(result.dismiss==='cancel') {  //취소버튼 눌러진경우 
		        //     swal('취소', '취소하였습니다.', 'error');
		        //   }
		        // });
		    });
    	});
    </script>
</body>
</html>