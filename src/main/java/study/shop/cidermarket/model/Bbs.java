package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Bbs {
	private int bbsno;
	private String type;
	private String name;
	private String tel;
	private String email;
	private String category;
	private String title;
	private String content;
	private int hits;
	private String regdage;
	private String editdate;
	private String reply;
	
	/** 페이지 구현이 필요한 경우 아래 속성들을 추가한다. (static) */
	private static int offset;		// LIMIT 절에서 사용할 검색 시작 위치
	private static int listCount;		// LIMIT 절에서 사용할 검색할 데이터 수
	
	public static int getOffset() {
		return offset;
	}
	public static void setOffset(int offset) {
		Bbs.offset = offset;
	}
	public static int getListCount() {
		return listCount;
	}
	public static void setListCount(int listCount) {
		Bbs.listCount = listCount;
	}	
	
}
