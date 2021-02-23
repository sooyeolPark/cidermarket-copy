package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Product {
	// 1) 기본 컬럼
	private int prodno;  // 상품번호
	private int cateno;  // 카테고리
	private String subject;  // 제목
	private int price;  // 가격
	private int fee;  // 배송비
	private String detail;  // 상품 상세 내용
	private String regdate;  // 등록시간
	private String prodcon;  // 상품상태 (N=새것 / A = 거의 새것 / U-중고)
	private String how;  // 거래방법 (T=택배 / J=직거래 / X = 상관없음)
	private String tradecon;  // 판매상태 (J=판매중 / W=판매완료 / S=숨김)
	private int seller;  // 판매자(회원번호)
	private int hits;  // 클릭수
	private String editdate;  // 수정날짜
	
	// 2) JOIN절에 따른 추가 컬럼
	private String filepath;  // 이미지 파일 첨부용
	private String sellerNick;  // 판매자(닉네임)
	private String name;  // 카테고리제목
	private String nickname;  // 셀러닉네임
	
	// 3) 페이지 구현을 위한 static 변수
    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;
    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;
    
	public static int getOffset() {
		return offset;
	}
	public static void setOffset(int offset) {
		Product.offset = offset;
	}
	public static int getListCount() {
		return listCount;
	}
	public static void setListCount(int listCount) {
		Product.listCount = listCount;
	}
}
