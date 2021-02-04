<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!doctype html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<title>주문서 - 사이다마켓</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/order_sheet.css" />
</head>

<body>
	<!-- 화면에 표시될 원본 보기 영역 - 기본적으로 숨겨진 상태이다. -->
	<div class='gray_layer' id='background'></div>
	<div class='over_layer' id='pay_warning'><%@ include file="/WEB-INF/views/user/pay_warning.jsp"%></div>
	<div class='over_layer' id='pay_refund_policy'><%@ include file="/WEB-INF/views/user/refund_policy.jsp"%></div>
	<!-- 헤더 영역 -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<section>
		<div class="container">
			<div id="order">주문서</div>
			<div id="order_cont">
				<div class="order_name">주문내용</div>
				<div class="media clearfix">
					<a class="pull-left" href="#">
						<img class="media-object" src="${pageContext.request.contextPath}/assets/img/item.png" width="80" height="80" alt="Generic placeholder image">
					</a>
					<div class="media-body">
						<div class="clearfix">
							<h4 class="media-heading pull-left" id="item_name">디올 조던 265 거의 새상품 판매 합니다아아아아아아아아아이이이이아이이</h4>
							<div class="pull-right"></div>
						</div>
						<div class="clearfix" id="item_price">
							<p>1,000,000원</p>
						</div>
					</div>
				</div>
			</div>
			<div id="order_adr">
				<div class="order_name">배송지</div>
				<form class="form-horizontal" role="form">
					<fieldset>
						<!-- 입력양식 -->
						<div class="form-group">
							<label for="user_name" class="col-sm-2 control-label">이름</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="user_name" placeholder="이름 입력">
							</div>
						</div>
						<!--// 입력양식 -->

						<!-- 입력양식 -->
						<div class="form-group">
							<label for="user_tel" class="col-sm-2 control-label">연락처</label>
							<div class="col-sm-10">
								<input type="tel" class="form-control" id="user_tel" placeholder="숫자만 입력">
							</div>
						</div>
						<!--// 입력양식 -->

						<!-- 입력양식 -->
						<div class="form-group">
							<label for="user_adr1" class="col-sm-2 control-label">주소</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="ipostcode" disabled placeholder="우편번호">
								<button type="button" class="btn btn-info" id="find_pc" onclick="iexecDaumPostcode()">우편번호 찾기</button>
								<br>
								<input type="text" class="form-control" id="iroadAddress" disabled placeholder="도로명주소">
								<input type="text" class="form-control" id="ijibunAddress" disabled placeholder="지번주소">
								<input type="text" class="form-control" id="iextraAddress" disabled placeholder="참고항목">
								<input type="text" class="form-control" id="idetailAddress" placeholder="상세주소">
							</div>
						</div>
						<!--// 입력양식 -->
					</fieldset>
				</form>
			</div>
			<div id="how_pay">
				<div class="order_name">결제수단</div>
				<form role="form">
					<fieldset>
						<div class="form-group">
							<label class="radio-inline"> 
								<input type="radio" name="how_pay" id="mtj" value="M" checked> 무통장입금
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="how_pay" id="card" value="C"> 카드결제
							</label>
						</div>
					</fieldset>
				</form>
				<div id="how_pay_anou">
					<h3>유의 사항</h3>
					<p>1. 금융 거래시에는 상대방의정보를 꼼꼼히 확인하세요.</p>
					<p>2. 분실, 파손 등의 모든 문제데 대한 책임은 거래 당사자에게 있습니다.</p>
					<p>3. 거래시 발생하는 회원 간 거래분쟁은 상호 합의로 해결해야 하며 사이다마켓이 개입하지 않습니다.</p>
					<p>4. 구매자 상품 수령 전 선 구매확정 하는 행위는 엄격히 금지됩니다.</p>
				</div>
			</div>
			<div id="final">
				<div class="order_name">최종결제금액</div>
				<table>
					<tr id="original-price">
						<td class="price_cont">상품가격</td>
						<td class="price_won">1,000,000원</td>
					</tr>
					<tr id="del_fee">
						<td class="price_cont">배송비</td>
						<td class="price_won">3,000원</td>
					</tr>
				</table>
				<div id="final_price">
					<table>
						<tr id="original-price">
							<td class="price_cont">최종결제금액</td>
							<td class="price_won">1,003,000원</td>
						</tr>
					</table>
				</div>
				<form role="form">
					<fieldset>
						<!-- 체크박스 -->
						<div class="form-group">
							<div class="checkbox">
								<label> <input id="checkbox1" type="checkbox" value=""> 결제하기 클릭시 
								<a id="clk_pay_warning" href="#">결제시 유의사항</a> 및 
								<a id="clk_refund_policy" href="#">반품환불정책</a>을 모두 이해하고 이에 동의함을 의미합니다.
								</label>
							</div>
						</div>
						<button id="allow" type="button" class="btn btn-primary btn-block" disabled>결 제 하 기</button>
					</fieldset>
				</form>
			</div>

		</div>
		<div id="anou">
			<p>
				(주)사이다마켓은 통신판매중개자로서 거래당사자가 아니며, <br /> 판매자가 등록한 상품정보 및 거래에 대해 (주)사이다마켓은 일체 책임을 지지 않습니다
			</p>
		</div>
	</section>

	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
	<!-- 주소 찾기 참조 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
        function iexecDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('ipostcode').value = data.zonecode;
                document.getElementById("iroadAddress").value = roadAddr;
                document.getElementById("ijibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("iextraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("iextraAddress").value = '';
                }
            }
        }).open();
    }
        $(function () {
            // 체크박스 미체크시 결제하기 버튼 비활성화 기능
            $("#checkbox1").change(function () {
                var chk = $(this).prop("checked");
                if (chk) {
                    $("#allow").prop("disabled", false);
                } else {
                    $("#allow").prop("disabled", true);
                }
            });
            $("#clk_pay_warning").click(function (e) {
                e.preventDefault();             // 페이지 이동 방지
                $("#background").fadeIn(300);   // 배경 레이어를 화면에 표시한다.
                $("#pay_warning").fadeIn(200);        // 이미지 레이어를 화면에 표시한다.
            });
            $("#clk_refund_policy").click(function (e) {
                e.preventDefault();             // 페이지 이동 방지
                $("#background").fadeIn(300);   // 배경 레이어를 화면에 표시한다.
                $("#pay_refund_policy").fadeIn(200);        // 이미지 레이어를 화면에 표시한다.

            });
            /** (화면에 표시된) 배경 레이어를 클릭한 경우 */
            $("#background").click(function () {
                $(this).fadeOut(300);       // 배경 레이어의 숨김
                $("#front").fadeOut(200);
                $(".over_layer").fadeOut(200);
                
                
                
                
                
                
            });
            
            $("#allow").click(function (e) {
                e.preventDefault();
                window.open("${pageContext.request.contextPath}/user/order_ok.cider", "_self");
            });
        });
    </script>
</body>

</html>