<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>헬프센터 일반문의 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/index.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>
	
	<section>
		<!-- Item 영역 -->
		<div class="container">
			<h3 class="text-center">헬프센터</h3>

			<!-- 탭의 전체 박스 -->
			<div class="tab clearfix">

				<!-- 탭 버튼 영역 -->
				<ul class="row tab-button clearfix">
					<li role="presentation" class="tab-button-item text-center"><a href="${pageContext.request.contextPath}/help/help.cider?selected=faq" class="tab-button-item-link3 pull-left" id="faq">자주묻는질문</a></li>
					<li role="presentation" class="tab-button-item text-center"><a href="${pageContext.request.contextPath}/help/help.cider?selected=policy" class="tab-button-item-link3 pull-left" id="policy">운영정책</a></li>
					<li role="presentation" class="tab-button-item text-center"><a href="${pageContext.request.contextPath}/help/inquiry_write.cider" class="tab-button-item-link3 pull-left selected" id="inquiry">일반문의</a></li>
				</ul>

				<!-- 내용영역 -->
				<div class="tab-panel">
				<!-- 탭 - 일반문의 -->
					<div id="tab-page-inquiry">
					
						<!-- sorting -->
						<div class="recordSort text-center">
						  <button type="button" class="ing btn btn-lg btn-primary selected">문의하기</button>
						  <button type="button" class="ing btn btn-lg btn-info" onclick="location.href='${pageContext.request.contextPath}/help/inquiry_list.cider'">문의내역</button>
						</div>
						
						<form class="form-horizontal" id="addForm" enctype=“multipart/form-data” method="post" role="form" action="${pageContext.request.contextPath}/help/inquiry_write">
						  <fieldset>
						    <legend class="sr-only">문의하기</legend>
						    <div class="form-group">
						      <label for="name" class="col-sm-2 control-label">이름 <span class="star">*</span></label>
						      <div class="col-sm-10">
						        <input type="text" name="name" id="name" class="form-control" maxlength="20" placeholder="이름을 입력해 주세요." value="${output.nickname}" />
						        <input type="hidden" name="membno" id="memberno" value="${myNum}" />
						      </div>
						    </div>
						    <div class="form-group">
						      <label for="tel" class="col-sm-2 control-label">연락처 <span class="star">*</span></label>
						      <div class="col-sm-10">
						        <input type="tel" name="tel" id="tel" class="form-control" placeholder="숫자만 입력해 주세요." value="${output.tel}" />
						      </div>
						    </div>
						    <div class="form-group">
						      <label for="email" class="col-sm-2 control-label">이메일 <span class="star">*</span></label>
						      <div class="col-sm-10">
						        <input type="email" name="email" id="email" class="form-control" placeholder="이메일을 입력해 주세요." value="${output.email}" >
						      </div>
						    </div>
						    <div class="form-group">
						      <label for="category" class="col-sm-2 control-label">유형 <span class="star">*</span></label>
						      <div class="col-sm-10">
						        <select class="form-control" id="category" name="category">
						          <option value="">--- 선택하세요 ---</option>
						          <option value="M">회원관련</option>
						          <option value="P">상품관련</option>
						          <option value="O">주문관련</option>
						          <option value="D">배송관련</option>
						          <option value="E">기타</option>
						        </select>
						      </div>
						    </div>
						    <div class="form-group">
						      <label for="title" class="col-sm-2 control-label">제목 <span class="star">*</span></label>
						      <div class="col-sm-10">
						        <input type="text" name="title" id="title" class="form-control" placeholder="제목을 입력해 주세요.">
						      </div>
						    </div>
						    <div class="form-group">
						      <label for="content" class="col-sm-2 control-label">내용 <span class="star">*</span></label>
						      <div class="col-sm-10">
						        <textarea name="content" id="content" maxlength="200" class="form-control ckeditor" placeholder="내용을 입력해 주세요."></textarea>
						        <span class="help-block">* 200자 이내</span>
						      </div>
						    </div>
						    <div class="form-group">
						      <label for="photo" class="col-sm-2 control-label">사진첨부</label>
						      <div class="col-sm-10">
						        <button type="button" class="file_input_img_btn btn btn-info" value="사진 선택">사진 선택</button>
						        <input type="file" name="photo" id="photo" accept="image/*" class="file_input_hidden multiple" multiple>
						        <div class="preview clearfix">
						          <span class="help-block">이미지 파일만 5장까지 업로드 가능합니다.</span>
						        </div>
						      </div>
						    </div>
						    </fieldset>
						
						    <div class="submitBtn clearfix">
						      <button type="button" class="col-xs-4 col-xs-offset-2 btn btn-lg btn-warning" onclick="location.href='${pageContext.request.contextPath}/help/inquiry_list.cider'">목록</button>
						      <button id="submit" type="submit" class="col-xs-4 col-xs-offset-1 btn btn-lg btn-primary">문의하기</button>
						    </div>
						</form>
						
					</div><!-- tab-page-inquiry 끝-->
				</div>
			</div>
		</div>
	</section>

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>


	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
	<!-- ajax-helper -->
	<script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugins/validate/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/validate/additional-methods.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>
	<!-- jQeury Ajax Form plugin CDN -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
    <!-- CKEditor CDN -->
    <script src="//cdn.ckeditor.com/4.16.0/basic/ckeditor.js"></script>
	<script type="text/javascript">
	
	/** 사진첨부 기능 */
	  var input = document.querySelector('#photo');
	  var preview = document.querySelector('.preview');
	  input.addEventListener('change', updateImageDisplay);
	
	  const fileTypes = [
	    "image/apng",
	    "image/bmp",
	    "image/gif",
	    "image/jpeg",
	    "image/pjpeg",
	    "image/png",
	    "image/svg+xml",
	    "image/tiff",
	    "image/webp",
	    "image/x-icon"
	  ];
	
	  function validFileType(file) {
	    return fileTypes.includes(file.type);
	  }
	
	  function updateImageDisplay() {
	    const curFiles = input.files;
	    const para = document.createElement('p');
	
	    while(preview.firstChild) {
	      preview.removeChild(preview.firstChild);
	    }
	
	    if(curFiles.length === 0) {
	      para.textContent = '파일 선택을 취소 했습니다.';
	      preview.appendChild(para);
	    } else if(curFiles.length >= 6) {
	      para.textContent = '5개까지 선택 가능합니다.';
	      preview.appendChild(para);
	    } else {
	      const list = document.createElement('ol');
	      preview.appendChild(list);
	
	      for(const file of curFiles) {
	        const listItem = document.createElement('li');
	        const para = document.createElement('p');
	        const i = document.createElement('i');
	        if(validFileType(file)) {
	          const image = document.createElement('img');
	          image.src = URL.createObjectURL(file);
	
	          listItem.appendChild(i);
	          listItem.appendChild(image);
	        } else {
	          para.textContent = `File name ${file.name}: 허용된 파일타입이 아닙니다. 다시 선택하세요.`;
	          listItem.appendChild(para);
	        }
	
	        list.appendChild(listItem);
	      }
	    }
	  }
	
	  /** 사진 삭제 기능 */
	  $(document).on('click', '.preview li i', function(){
	    $(this).parent().remove();
	  });
	  
	  
	  // 정규표현식 검사
	  $(function(){  
		const membno = $('#memberno').val();
    	$("#addForm").ajaxForm({
    		beforeSerialize:function($Form, options){
		        /* Before serialize */
		        for ( instance in CKEDITOR.instances ) {
		            CKEDITOR.instances[instance].updateElement();
		        }
		        return true; 
		    
	   		  if (!regex.value('#name', '이름을 입력하세요.')) { return false; }
	  	      if (!regex.kor_eng('#name', '이름은 한글과 영문만 입력 가능합니다.')) { return false; }
	  	      if (!regex.min_length('#name', 2, '이름은 최소 2자 이상 입력 가능합니다.')) { return false; }
	  	      if (!regex.max_length('#name', 20, '이름은 최대 20자 까지만 입력 가능합니다.')) { return false; }
	  	      
	  	      /** 연락처 검사 */
	  	      if (!regex.value('#tel', '연락처를 입력하세요.')) { return false; }
	  	      if (!regex.phone('#tel', '연락처가 잘못되었습니다.')) { return false; }
	  	
	  	      /** 이메일 검사 */
	  	      if (!regex.value('#email', '이메일을 입력하세요.')) { return false; }
	  	      if (!regex.email('#email', '이메일 주소가 잘못되었습니다.')) { return false; }
	  	
	  	      /** 유형 검사 */
	  	      if (!regex.value('#title', '제목을 입력하세요.')) { return false; }
	  	      if (!regex.value('#content', '내용을 입력하세요.')) { return false; }
    		},
	    	method: "POST",
	    	data: {"membno":membno},
  			success: function(json) {
  				console.log(json);
  				alert("등록되었습니다.");
  				if (json.rt == "OK") {
  					window.location = "${pageContext.request.contextPath}/help/inquiry_view.cider?bbsno=" + json.item.bbsno;
  				}
  			}
		});
	    
	   });
	    
	   
	
	
	  
	
	</script>