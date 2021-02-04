<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
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
                    <a class="pull-left" href="#"> <img class="media-object" src="${pageContext.request.contextPath}/assets/img/item.png" width="80" height="80"
                            alt="Generic placeholder image"> </a>
                    <div class="media-body">
                        <div class="clearfix">
                            <h4 class="media-heading pull-left" id="item_name">디올 조던 265 거의 새상품 판매 합니다아아아아아아아아아이이이이아이이
                            </h4>
                            <div class="pull-right">
                            </div>
                        </div>
                        <div class="clearfix" id="item_price">
                            <p>1,000,000원</p>
                        </div>
                    </div>
                </div>
            </div>
            <div id="order_adr">
                <div class="order_name">배송지</div>
                <div class="row">
                    <div class="col-sm-2 ok_subject">이름</div>
                    <div class="col-sm-10 ok_content">최대일</div>
                </div>
                <div class="row">
                    <div class="col-sm-2 ok_subject">연락처</div>
                    <div class="col-sm-10 ok_content">01012345678</div>
                </div>
                <div class="row">
                    <div class="col-sm-2 ok_subject">주소</div>
                    <div class="col-sm-10 ok_content">서울특별시 서초구 서초대로 123 이젠학원</div>
                </div>
            </div>

            <div id="final">
                <div class="order_name">최종결제금액</div>
                <div class="row">
                    <div class="col-sm-2 ok_subject">결제수단</div>
                    <div class="col-sm-10 ok_content">무통장입금</div>
                </div>
                <div class="row">
                    <div class="col-sm-2 ok_subject">입금정보</div>
                    <div class="col-sm-10 ok_content">홍길동 / 우리은행 / 1002-02-506589</div>
                </div>
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
                window.open("${pageContext.request.contextPath}", "_self");
            });
        });
    </script>
</body>

</html>