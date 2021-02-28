package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Review {
	// 1) 기본 컬럼
	private int revino;
	private int prodno;
	private String regdate;
	private int rate;
	private String content;
	private int recono;
	private int sender;
	private int receiver;
	
	// 2) JOIN절에 따른 추가 컬럼
	
	private String filepath;
	private String name;
	private String how;
	private String subject;
	private int buyer;
	private String reviewpic;
	private int price;
	private int seller;
	private String nickname;
	private String outmember;
	private String shopaddress;
	
	

	// 3) 페이지 구현을 위한 static 변수
    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;
    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;
    
	public static int getOffset() {
		return offset;
	}
	public static void setOffset(int offset) {
		Review.offset = offset;
	}
	public static int getListCount() {
		return listCount;
	}
	public static void setListCount(int listCount) {
		Review.listCount = listCount;
	}	
}
