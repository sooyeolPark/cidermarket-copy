<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html>

<head>
	<%@ include file="/WEB-INF/views/inc/head_adm.jsp"%>
    <title>운영정책 - 사이다마켓</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/admin/policy_adm.css" />
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
                <%@ include file="/WEB-INF/views/inc/board_adm_left.jsp"%>
            </div>
            <div class="col-lg-10">
                <div class="rule_content">
                    <div class="title text-center">사이다마켓 운영정책</div>
                    <div class="policy_content">
                        <p>사이다마켓은 공유를 통해 삶의 여유를 제공하는 개인간거래 중심의 마켓입니다.</p>
                        <p>누구나 사고 팔고 나누는 공간으로, 다양한 개인들이 모여 자유롭고 편리하게 안전한 거래를 할 수 있습니다. 서로 존중하고 배려하는 건강한 개인간거래 문화를 회원 여러분과 함께 만들어가기 위해 아래의 운영정책을 공지합니다.</p> <br>
                        <p>운영정책은 개인간거래에 적합한 원칙과 기준으로 지속적으로 개선해나아가겠습니다.</p>
                    </div>
                    <div class="policy_content_bold">
                        <p>※ 건강한 마켓 환경과 다수의 정상적인 회원 보호를 위해, 운영정책을 준수하지 않은 경우 사이다마켓은 관련 행위를 확인 후 결과에 따라 주의를 당부하거나, 사전안내 없이 서비스 이용을 한시적/영구적으로 일부 또는 전체 제한할 수 있습니다.</p> <br>
                        <p>※ 운영정책은 사이다마켓 약관을 포함합니다.</p>
                    </div>
                    <section class="policy_content">
                        <div class="title">[1] 아이템/글</div>
                        <p>깨끗한 마켓 환경을 위해 아이템과 글(이미지 포함)은 시스템과 모니터링, 회원신고에 따라 운영됩니다.</p> <br>
                        <p>- 마켓 내 상업적 홍보(스팸 등), 타 서비스 유도, 도배 행위, 검색노출을 목적으로 한 다수의 키워드 삽입, 게시공간의 성격에 맞지 않는 글, 음란성 글, 잘못된 카테고리 등록, 무의미한(장난성) 아이템, 올바르지 않은 가격 아이템(1원 등)의 경우 사전안내 없이 수정 또는 삭제될 수 있습니다</p> <br>
                        <p>- 다수의 회원이 선정성(과도한 신체 노출 등), 차별적인 내용(종교, 인종 등), 성적 수치심이나 불쾌감을 유발하는 사유로 불편 신고를 한 아이템/글은 사이다마켓의 판단에 따라 수정 권고 또는 삭제될 수 있습니다.</p> <br>
                        <p>- 사이다마켓 서비스에 대해 타 회원에게 오해를 일으키는 등 부정적인 영향을 미칠 수 있거나, 서비스에 방해(피해)가 발생할 수 있는 글은 사전안내 없이 삭제될 수 있습니다. (운영정책 위반으로 조사 중인 사안의 세부정보 또는 결과를 포함하는 내용 포함)</p> <br>
                        <dl class="policy_sub_content"> <dt>1) 거래부적합 아이템</dt>
                            <dd>
                                <p>아래의 거래부적합 아이템은 이용약관 및 현행 법률에 따라 마켓 내 등록 및 거래를 금지합니다.</p>
                                <ul>
                                    <li>- 주류</li>
                                    <li>- 담배</li>
                                    <li>- 의약품</li>
                                    <li>- 도수 있는 안경, 콘택트렌즈</li>
                                    <li>- 개인정보(신분증, 게임계정 등)</li>
                                    <li>- 성인용품(콘돔 제외)</li>
                                    <li>- 불법복제품</li>
                                    <li>- 반려동물</li>
                                </ul>
                                <p> <a href="/terms.hm" id="btnTermsLink" target="_blank">[모든 거래부적합 아이템 보기]</a> </p> <b>※ ‘거래부적합 아이템’은 [아이템 상세&gt;신고하기]를 통해 사이다마켓에 알려주세요.</b> <b>- 자동차 딜러 등 전문판매자 서비스를 제공하는 특정 카테고리는 해당 정책에 따라 운영됩니다.</b>
                            </dd>
                        </dl>
                    </section>
                    <section class="policy_content">
                        <div class="title">[2] 회원간 매너</div>
                        <dl class="policy_sub_content"> <dt>1) 서로를 존중하는 말로 대화하고, 상대가 불편함을 느낄 수 있는 표현과 거부하는 행동은 삼가해주세요.</dt>
                            <dd>
                                <ul>
                                    <li>- 욕설, 비방/비하, 명예훼손, 일방적인 반말 등은 ‘비매너’표현입니다</li>
                                    <li>- 공개된 공간에서의 ‘비매너’ 글(닉네임 포함), 다른 회원의 개인정보 또는 대화내용을 동의없이 공개하는 글, 분쟁을 유도하는 글, 허위사실 유포 등은 금지합니다.</li>
                                    <li>- 상대가 성희롱으로 느낄 수 있는 표현은 주의해주세요.(아이템과 관계없는 판매회원의 외모에 대한 표현, 무리한 착샷 요구 등)</li>
                                    <li>- 무리한 가격 에누리, 밤늦은 시간의 사이다톡 대화 요구, 구매 강요 행위 등은 비매너 신고될 수 있습니다.</li>
                                    <li>- 아이템의 높은 가격에 대한 조언은 사이다톡으로 이야기 해주세요. 모든 회원들에게 공개되는 아이템 댓글을 통한 조언은 판매회원의 입장에서 거래방해로 여겨질 수 있습니다.</li>
                                    <li>- 상습적으로 마켓 내 구매아이템을 웃돈을 받아 되파는 행위로 신고될 경우 제재 사유가 될 수 있으니 유의해주세요.</li>
                                    <li>- 사이다마켓 운영진, 직원 또는 관계자를 사칭하는 행위는 엄격히 금지합니다.</li>
                                </ul> <b>※ ‘비매너 회원’은 [회원 상세&gt;신고하기]를 통해 사이다마켓에 알려주세요. </b>
                            </dd> <dt>2) 거래 약속은 서로 지키기 위해 노력하고, 부득이한 사정으로 거래를 파기할 경우 상대에게 충분히 양해를 구해주세요.</dt>
                            <dd>
                                <ul>
                                    <li>- 상습적인 거래파기나 상대와 직접 만나서 거래를 약속한 후 불이행(연락두절 등)하는 행위는 제재사유가 될 수 있습니다.</li>
                                    <li>- 거래피해 상대회원의 개인정보 노출은 자제해주세요. 상대회원으로부터 확인한 정보가 거래와 무관한 타인의 도용된 정보일 경우, 게시한 회원에게 피해가 발생할 수 있습니다.<br> 거래피해는 [사이다마켓 &gt; 1:1문의]로 증빙자료와 함께 신고해주세요. </li>
                                </ul>
                            </dd>
                        </dl>
                    </section>
                    <section class="policy_content">
                        <div class="title">[3] 거래후기</div>
                        <p>사이다마켓 거래후기는 마켓 내 거래를 마치고 서로의 거래경험을 나누는 공간입니다. 거래후기는 추천을 포함하여 모든 회원들에게 공유되며, 다른 회원의 거래에도 도움이 될 수 있습니다.</p> <br>
                        <p> <b>신뢰할 수 있는 정직한 후기 공유를 위해 아래의 유의사항을 준수해주세요.</b> </p> <br>
                        <p>1) 거래후기는 원칙적으로 작성한 회원이 삭제를 할 수 있습니다.</p><br>
                        <p>2) '비매너 표현'을 포함한 부적합한 글은 사전안내 없이 삭제될 수 있습니다.</p><br>
                        <p>3) 후기 대상 회원의 소명요청이 접수될 경우 사이다마켓의 신중한 검토 및 판단에 따라 아래의 부적합한 후기는 수정 또는 삭제될 수 있습니다.</p>
                        <ul style="margin: 0; padding: 0;">
                            <li>- ‘비매너’ 표현이 포함된 경우</li>
                            <li>- 허위정보가 포함된 경우</li>
                            <li>- 상대회원의 개인정보 또는 대화내용을 동의없이 공개하는 경우</li>
                            <li>- 법령 및 상거래의 일반원칙을 위반하는 내용</li>
                            <li>- 범죄적 행위에 결부된다고 인정되는 경우</li>
                            <li>- 후기 및 추천을 빌미로 환불, 추가적인 보상, 상대회원에게 좋은 후기를 남기도록 강요하는 행위</li>
                        </ul>
                        <p>4) 다수의 계정을 생성하여 허위후기를 등록하는 부정행위는 금지합니다</p> <br>
                    </section>
                </div>
                <form class="form-inline">
                    <div class="regi_cancel">
                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/notice_write_adm.cider" role="button">수정</a>
                        <a class="btn btn-warning" href="#" role="button">삭제</a>
                    </div>
                  </form>
 
            </div>
            </div>
        </div>
    <!--/row-->
    <hr>
	<!-- 푸터 영역 -->
	<%@ include file="/WEB-INF/views/inc/footer_adm.jsp"%>


    <!--/.container-->
    <!-- Javascript -->

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {

        
        //로그아웃
        $("#log-out").click(function(e){
                var result = confirm("로그아웃 하시겠습니까?");

                if(result ==true) {
                    location.replace('${pageContext.request.contextPath}/admin/login_adm.cider'); 
                }else{

                }
            });
        });
    </script>

</body>

</html>    