package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Record {
	// 1) 기본 컬럼
	private int recono;  // 거래번호(PK)
	private int prodno;  // 상품번호(FK-product)
	private int buyer;  // 구매자(회원번호)(FK-member)
	private String tradecon;  // 거래상태 (J=거래중 / W=거래완료 / S=거래정지 / A=정산중 / C=정산완료)
	private String refund;  // 반품 (N = 초기화 / J = 반품중 / W = 반품완료 / X = 반품거절)
	private String how;  // 거래방법 (T = 택배거래 / J = 직거래 / X = 상관없음)
	private String confirmdate;  // 거래완료일자
	private String name;  // 받는 사람 이름
	private String tel;  // 받는 사람 연락처
	private String address;  // 받는 사람 주소
	private String pay;  // 결제수단(M=무통장입금/ C=카드결제)
	
	// 2) JOIN절에 따른 추가 컬럼
	private String filepath;  // 상품이미지
	private String subject;  // 상품명
	private int price;  // 가격 
	private int seller;  // 판매자
	private String nickname;  // 구매자 닉네임
	private int revino;  // 후기번호
	private int count;  // 결과갯수 
	private int month; //월
	private int lastmonth;
	private int lasttwomonth;
	// 3) 페이지 구현을 위한 static 변수
    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;
    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;
    
	public static int getOffset() {
		return offset;
	}
	public static void setOffset(int offset) {
		Record.offset = offset;
	}
	public static int getListCount() {
		return listCount;
	}
	public static void setListCount(int listCount) {
		Record.listCount = listCount;
	}
}
