<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="ko">

<head>
   <%@ include file="/WEB-INF/views/inc/head.jsp"%>
    <title>주문완료 - 사이다마켓</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/user/order_ok.css" />
</head>

<body>
    <!-- 헤더 영역 -->
   <%@ include file="/WEB-INF/views/inc/header.jsp"%>

    <section>
        <div class="container">
            <div id="order">
                주문이 완료 되었습니다.
            </div>
            <div id="order_cont">
                <div class="order_name">주문내용</div>
                <div class="media clearfix">
                    <div class="pull-left"> <img class="media-object" src="${pageContext.request.contextPath}/assets/img${product.filepath}" width="80" height="80"
                            alt="Generic placeholder image"> </div>
                    <div class="media-body">
                        <div class="clearfix">
                            <h4 class="media-heading pull-left" id="item_name">${product.subject}
                            </h4>
                            <div class="pull-right">
                            </div>
                        </div>
                        <div class="clearfix" id="item_price">
                            <p><fmt:formatNumber value="${product.price}" pattern="#,###" />원</p>
                        </div>
                    </div>
                </div>
            </div>
            <div id="order_adr">
                <div class="order_name">배송지</div>
                <div class="row">
                    <div class="col-sm-2 ok_subject">이름</div>
                    <div class="col-sm-10 ok_content">${record.name}</div>
                </div>
                <div class="row">
                    <div class="col-sm-2 ok_subject">연락처</div>
                    <div class="col-sm-10 ok_content">${record.tel}</div>
                </div>
                <div class="row">
                    <div class="col-sm-2 ok_subject">주소</div>
                    <div class="col-sm-10 ok_content">${record.address}</div>
                </div>
            </div>

            <div id="final">
                <div class="order_name">최종결제금액</div>
                <div class="row">
                    <div class="col-sm-2 ok_subject">결제수단</div>
                    <div class="col-sm-10 ok_content">
                    <c:choose>
                    	<c:when test="${record.pay=='C'}">
                    		카드결제
                    	</c:when>
                    	<c:when test="${record.pay=='M'}">
                    		무통장입금
                    	</c:when>
                    </c:choose>
					</div>
                </div>
                <div class="row">
                    <div class="col-sm-2 ok_subject">입금정보</div>
                    <div class="col-sm-10 ok_content">홍길동 / 우리은행 / 1002-02-506589</div>
                </div>
                <div id="final_price">
                    <table>
                        <tr id="original-price">
                            <td class="price_cont">최종결제금액</td>
                            <c:set var="total" value="${product.price+product.fee}" />
                            <td class="price_won"><fmt:formatNumber value="${total}" pattern="#,###" />원</td>
                        </tr>
                    </table>
                </div>
                <form role="form">
                    <fieldset>
                        <button id="allow" type="button" class="btn btn-primary btn-block">
                            쇼 핑 &nbsp;계 속 하 기
                        </button>
                    </fieldset>
                </form>
            </div>

        </div>
        <div id="anou">
            <p>(주)사이다마켓은 통신판매중개자로서 거래당사자가 아니며,
                <br /> 판매자가 등록한 상품정보 및 거래에 대해 (주)사이다마켓은 일체 책임을 지지 않습니다
            </p>
        </div>
    </section>
    
    <!-- 푸터 영역 -->
   <%@ include file="/WEB-INF/views/inc/footer.jsp"%>

    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/asidebar.jquery.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#allow").click(function (e) {
                e.preventDefault();
                window.location="${pageContext.request.contextPath}";
            });
        });
    </script>
</body>

</html>