package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Records {
	// 1) 기본 컬럼
	private int recono;
	private int prodno;
	private int buyer;
	private String tradecon;
	private String refund;
	private String how;
	private String confirmdate;
	private String name;
	private String tel;
	private String address;
	private String pay;
	
	// 2) JOIN절에 따른 추가 컬럼
	private String path; 
	
	// 3) 페이지 구현을 위한 static 변수
    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;
    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;
    
	public static int getOffset() {
		return offset;
	}
	public static void setOffset(int offset) {
		Records.offset = offset;
	}
	public static int getListCount() {
		return listCount;
	}
	public static void setListCount(int listCount) {
		Records.listCount = listCount;
	}
}
