<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>상품수정 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/item_reg.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />

</head>

<body>
    <div class='gray_layer' id='background'>
        <div id="modal_name">태그입력</div>
        <div id="modal_content">
            <form role="form">
                <div class="form-group">
                    <span class="help-block">- 특수문자와 공백은 입력하실 수 없습니다.</span>
                    <span class="help-block">- 각 태그는 최대 10자까지 입력할 수 있습니다.</span>
                    <span class="help-block">- 판매하는 상품과 연관없는 태그 입력시 제재를 받을 수 있습니다.</span>
                    <div class="input-group">
                        <input type="text" maxlength="10" id="tag_input" class="form-control"
                            placeholder="태그를 입력해 주세요" />
                    </div>
                    <div class="modal_btn">
                        <button id="tag_ok" type="button" class="btn btn-primary">확인</button>
                        <button id="tag_cancle" type="button" class="btn btn-info">취소</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

    <section>
        <div class="container">
            <div id="reg_subject">
                상품 수정
            </div>
            <!-- 입력 양식 -->
            <form id="item_img_group" class="form-horizontal" enctype=“multipart/form-data” role="form" action="${pageContext.request.contextPath}/Item_update">
            <input type="hidden" name="prodno" id="prodno" value="${product.prodno }">
            <c:forEach var="item" items="${fileimages}" varStatus="status">
            <c:if test="${item.filepath!='X'}">
    		<input type="hidden" name="origin_image${status.index}" id="origin_image${status.index}" value="">
    		</c:if>
    		</c:forEach>
            <div id="reg_cont">
                <div class="reg_name">상품사진</div>
                
                <c:forEach var="item" items="${fileimages}" varStatus="status">
    					<c:choose>
    						<c:when test="${item.filepath!='X' && status.index==0}">
    			<div id="item_img${status.index+1}" class="col-xs-3 item-img">
                    <div id=first_img>대표</div>
                    <input type="file" id="image${status.index}" name="image${status.index}" class="image_plus" accept="image/*" data-path="${item.fileno}" />
                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                </div>			
    						</c:when>
    						<c:when test="${item.filepath!='X' && status.index > 0}">
    			<div id="item_img${status.index+1}" class="col-xs-3 item-img">
                    <input type="file" id="image${status.index}" name="image${status.index}" class="image_plus" accept="image/*" data-path="${item.fileno}" />
                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                </div>			
    						</c:when>
    						<c:otherwise>
    			<div id="item_img${status.index+1}" class="col-xs-3 item-img">
                    <input type="file" id="image${status.index}" name="image${status.index}" class="image_plus" accept="image/*" />
                    <a class="remove_img" href="#" title="삭제"><i class="glyphicon glyphicon-remove"></i></a>
                </div>					
    						</c:otherwise>
    					</c:choose>
    			</c:forEach>
            </div>


            <div id="reg_info">
                <div class="reg_name">상품정보</div>
                    <fieldset>
           
                        <div class="form-group">
                            <label for="item_subject" class="col-sm-2 control-label">제목</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="item_subject" name="item_subject" 
                                placeholder="상품 제목을 입력해주세요." value="${product.subject}">
                            </div>
                        </div>
                  
                        <div class="form-group">
                            <label for="item_category" class="col-sm-2 control-label">카테고리</label>
                            <div class="col-sm-5">
                                <select class="form-control" id="item_category" name="item_category">
                                    <option value="" >카테고리</option>
    								<%--조회 결과에 따른 반복 처리 --%>
    								<c:forEach var="item" items="${category}" varStatus="status">
    									<c:choose>
    										<c:when test="${product.cateno==item.cateno}">
    										<option selected value="${item.cateno}">${item.name}</option>
    										</c:when>
    										<c:otherwise>
    										<option value="${item.cateno}">${item.name}</option>		
    										</c:otherwise>
    									</c:choose>
    								</c:forEach>
                                </select>
                            </div>
                        </div>
                 
                        <div class="form-group">
                            <label for="item_content" class="col-sm-2 control-label">설명</label>
                            <div class="col-sm-10">
                                <textarea id="item_content" name="item_content" class="form-control ckeditor" rows="5"
                                    placeholder="상품 설명을 입력해주세요.">${product.detail}</textarea>
                            </div>
                        </div>
                
                        <div class="form-group">
                            <label for="item_tag" class="col-sm-2 control-label">연관태그<small>(선택)</small></label>
                            <input type="hidden" id="hash1" name="hash1" value="" />
                            <input type="hidden" id="hash2" name="hash2" value="" />
                            <input type="hidden" id="hash3" name="hash3" value="" />
                            <input type="hidden" id="hash4" name="hash4" value="" />
                            <input type="hidden" id="hash5" name="hash5" value="" />
                            <div class="col-sm-10">
                                <button id="item_tag" class="btn btn-info">태그입력</button>
                                <ul class="list-inline tag_list">
								<c:forEach var="item" items="${hashtag}" varStatus="status">
								<li id="origin_hashtag${status.index}" data-tagname="${item.tagname}">${item.tagname}<a class="remove_tag" href="#"><i class="glyphicon glyphicon-remove"></i></a></li>
    							</c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="item_stat" class="col-sm-2 control-label">상태</label>
                            <input type="hidden" id="item_prodcon" name="item_prodcon" value="${product.prodcon}" />
                            <div class="col-sm-10" id="item_con">
                                <button class="btn btn-info btn-list 
                                <c:if test="${product.prodcon=='N'}">
                                 active
                                </c:if>
                                " data-con="N">새상품</button>
                                <button class="btn btn-info btn-list
                                <c:if test="${product.prodcon=='A'}">
                                 active
                                </c:if>
                                " data-con="A">거의새것</button>
                                <button class="btn btn-info btn-list
                                <c:if test="${product.prodcon=='U'}">
                                 active
                                </c:if>
                                " data-con="U">중고</button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="item_price" class="col-sm-2 control-label">가격</label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" id="item_price" name="item_price" placeholder="가격을 입력해주세요." value="${product.price}">
                                <div class="won">원</div>
                                <p>*가격을 입력하지 않는 경우 무료나눔로 설정됩니다.</p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="optionsRadios1" class="col-sm-2 control-label">거래방법</label>
                            <div class="col-sm-10">

                                <label class="radio-inline">
                                    <input type="radio" class="radio_check" name="optionsRadios" id="optionsRadios1" value="T"
                                        <c:if test="${product.how=='T'}">
                                        checked
                                        </c:if>
                                        >
                                    택배거래 </label>


                                <label class="radio-inline">
                                    <input type="radio" class="radio_check" name="optionsRadios" id="optionsRadios2" value="J" 
                                    <c:if test="${product.how=='J'}">
                                        checked
                                        </c:if>
                                        >
                                    직거래 </label>


                                <label class="radio-inline">
                                    <input type="radio" class="radio_check" name="optionsRadios" id="optionsRadios3" value="X" 
                                    <c:if test="${product.how=='X'}">
                                        checked
                                        </c:if>
                                        >
                                    상관 없음 </label>

                            </div>
                        </div>
  
                        <div class="form-group">
                            <label for="item_delfee" class="col-sm-2 control-label">배송비</label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" id="item_delfee" name="item_delfee" placeholder="배송비를 입력해주세요." value="${product.fee}">
                                <div class="won">원</div>
                                <p>*배송비를 입력하지 않는 경우 배송비는 무료로 설정됩니다.</p>
                            </div>
                        </div>
                        <input type="hidden" name="seller" value="${myNum}">
                    </fieldset>
            </div>

            <div id="final">
                    <fieldset>
                        <button id="allow" type="submit" class="btn btn-warning btn-block" onClick="CKupdate();">
                            상 품 수 정
                        </button>
                    </fieldset>
                
            </div>
            </form>
             <!-- //입력양식 -->
        </div>
        <div id="anou">
            <p>(주)사이다마켓은 통신판매중개자로서 거래당사자가 아니며,
                <br /> 판매자가 등록한 상품정보 및 거래에 대해 (주)사이다마켓은 일체 책임을 지지 않습니다
            </p>
        </div>
    </section>
    
    <!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>
	
    <script id="tag_list_tmpl" type="text/x-handlebars-template">

	<li>{{content}}<a class="remove_tag" href="#"><i class="glyphicon glyphicon-remove"></i></a></li>
	
</script>
    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
    <!-- jQeury Ajax Form plugin CDN -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
    <!-- ajax-helper -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <!-- handlebar plugin -->
    <script src="${pageContext.request.contextPath}/assets/plugins/handlebars/handlebars-v4.7.6.js"></script>
    <!-- CKEditor CDN -->
    <script src="//cdn.ckeditor.com/4.16.0/basic/ckeditor.js"></script>
    <script type="text/javascript">
	    function CKupdate(){
	        for ( instance in CKEDITOR.instances )
	            CKEDITOR.instances[instance].updateElement();
	    }
    
        $(function () {
        	//등록된 사진 보여주기
        		var str= ["${fileimages.get(0).filepath}","${fileimages.get(1).filepath}","${fileimages.get(2).filepath}","${fileimages.get(3).filepath}",
        			"${fileimages.get(4).filepath}","${fileimages.get(5).filepath}","${fileimages.get(6).filepath}","${fileimages.get(7).filepath}",];	
        		
        	for(var i = 0 ; i<8 ; i++){
        			if(str[i]!="X"){
        				$("#image"+i+"").css('background-image', 'url(\"${pageContext.request.contextPath}/upload' + str[i] + '\")');
        				$("#image"+i+"").next().css('display', 'block');  
        				
        			}
        		}
        		
        		//등록된 해쉬태그 보여주기
        		$("#hash1").val($("#origin_hashtag0").data("tagname"));
        		$("#hash2").val($("#origin_hashtag1").data("tagname"));
        		$("#hash3").val($("#origin_hashtag2").data("tagname"));
        		$("#hash4").val($("#origin_hashtag3").data("tagname"));
        		$("#hash5").val($("#origin_hashtag4").data("tagname"));
        		
        	// 직거래 선택시 배송비 입력칸 비활성화
            $(".radio_check").click(function () {
                if($("#optionsRadios2").is(":checked")){
                	$("#item_delfee").val("");
                	$("#item_delfee").attr("placeholder", "직거래 선택 시 배송비는 없습니다.");
                	$("#item_delfee").attr("disabled", true);
                } else{
                	$("#item_delfee").attr("disabled", false);
                	$("#item_delfee").attr("placeholder", "배송비를 입력해주세요.");
                }
            });
            //사진 등록

            // 버튼 토글
            $(".btn-list").click(function (e) {
                e.preventDefault();
                $(".btn-list").not(this).removeClass('active');
                $(this).toggleClass('active');
				
				
                for(var i = 0 ; i<3 ; i++){
                	var con = $("#item_con>button").eq(i)
                	if(con.hasClass("active")){
                		$("#item_prodcon").val(con.data("con"));
                	}
                }
            });
            // 등록 이미지 등록 미리보기
            function readInputFile(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(input).css('background-image', 'url(\"' + e.target.result + '\")');
                        $(input).next().css('display', 'block');
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }

            $(".image_plus").on('change', function () {
                readInputFile(this);
                
                var chk = $(this).data("path");
                var check = true;
                for(var i = 0; i<8; i++){
                	if($("#origin_image"+i+"").val()==chk){
                	check =	false;
                	}
                }
                
                if(check){
                	for(var i = 0; i<8; i++){
                	if($("#origin_image"+i+"").val()==''){
                		$("#origin_image"+i+"").val(chk);
                		break;
                	}
                	} 	
                }
                
            });

            //등록 이미지 삭제
            function resetInputFile($input) {
                var agent = navigator.userAgent.toLowerCase();
                if ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1)) {
                    // ie 일때
                    $input.replaceWith($input.clone(true));

                } else {
                    //other
                    $input.val("");

                }
            }
            $(".remove_img").click(function (e) {
                e.preventDefault();
                var ok = confirm("사진을 삭제하시겠습니까?");
                if (ok) {
                    $(this).css('display', 'none');
                    $(this).prev().css('background-image', 'url("${pageContext.request.contextPath}/upload/img_plus.png")');
                    var $input = $(this).prev();
                    resetInputFile($input);
                    
                    var chk = $(this).prev().data("path");
                    var check = true;
                    for(var i = 0; i<8; i++){
                    	if($("#origin_image"+i+"").val()==chk){
                    	check =	false;
                    	}
                    }
                    
                    if(check){
                    	for(var i = 0; i<8; i++){
                    	if($("#origin_image"+i+"").val()==''){
                    		$("#origin_image"+i+"").val(chk);
                    		break;
                    	}
                    	} 	
                    }
                    }
                

            });
            $("#tag_input").keyup(function (e) {
                // 특수문자 정규식 변수(공백 포함)
                var replaceChar = /[~!@\#$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}\s]/gi;
                var input = $("#tag_input").val();
                if (input.match(replaceChar)) {
                    alert("특수문자 및 공백은 사용하실 수 없습니다.");
                    $("#tag_input").val(input.replace(replaceChar, ''));
                }
            });
            $("#tag_ok").click(function (e) {
                e.preventDefault();
                var input = $("#tag_input").val();
                if (!input) {
                    alert("태그를 입력해 주세요");
                    $("#tag_input").focus();
                    $("#tag_input").val('');
                    return false;
                }
                var replaceChar = /[~!@\#$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}\s]/gi;
                if (input.match(replaceChar)) {

                    alert("특수문자 및 공백은 사용하실 수 없습니다.");
                    $("#tag_input").focus();
                    $("#tag_input").val(input.replace(replaceChar, ''));
                    return false;
                }
                for (var i = 0; i < 5; i++) {
                    var tag_val = $(".tag_list>li").eq(i).html();
                    input_chk = input + "<a class=\"remove_tag\" href=\"#\"><i class=\"glyphicon glyphicon-remove\"></i></a>"
                    if (input_chk == tag_val) {
                        alert("중복된 태그입니다.");
                        $("#tag_input").focus();
                        $("#tag_input").val('');
                        return false;
                    }
                }
                if ($(".tag_list>li").length >= 5) {
                    alert("태그는 최대 5개까지만 입력 가능합니다.");
                    return false;
                }
                var li = { content: input };
                var template = Handlebars.compile($("#tag_list_tmpl").html());
                var html = template(li);
                $(".tag_list").append(html);
                $("#tag_input").val('');
                $("#background").fadeOut(300);
                
               for(var i = 1; i < 6; i++){
            	   if(!$("#hash"+i+"").val()){
            		   $("#hash"+i+"").val(input);
        				break;
            	   }
               }
            });
            
            $("#tag_input").keydown(function(e){
            	if(e.keyCode==13){
            		e.preventDefault();
            		$("#tag_ok").click();
            	}
            });

            $(document).on("click", ".remove_tag", function (e) {
                e.preventDefault();
                var target = $(this).parent().text();
                
                for(var i = 1; i < 6; i++){
             	   if($("#hash"+i+"").val()==target){
             		   $("#hash"+i+"").val("");
             	   }
                }
                $(this).parent().remove();
            });

            $("#item_tag").click(function (e) {
                e.preventDefault();
                $("#background").fadeIn(300);
                $("#tag_input").focus();

            });

            $("#tag_cancle").click(function (e) {
                $("#tag_input").val('');
                $("#background").fadeOut(300);
            });
            
         // #item_img_group에 대한 submit이벤트를 가로채서 Ajax요청을 전송한다.
            $("#item_img_group").ajaxForm({
                // 전송 메서드 지정
                method: "POST",
                // 서버에서 200 응답을 전달한 경우 실행됨
                success: function(json) {
                    console.log(json);
                 // json에 포함된 데이터를 활용하여 상세페이지로 이동한다.
                    if (json.rt == "OK") {
                    	alert("수정이 완료되었습니다.");
                   	 window.location="${pageContext.request.contextPath}/item_index.cider?prodno="+"${product.prodno}";
                    }
                }
            });
        });
    </script>
</body>

</html>