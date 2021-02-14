package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Msgbox {
	// 1) 기본 컬럼
	private int msgno;
	private int sender;
	private int receiver;
	private String content;
	private String save;
	private int prodno;
	private String regdate;

	// 2) JOIN절에 따른 추가 컬럼
	 
	
	// 3) 페이지 구현을 위한 static 변수
    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;
    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;
    
	public static int getOffset() {
		return offset;
	}
	public static void setOffset(int offset) {
		Msgbox.offset = offset;
	}
	public static int getListCount() {
		return listCount;
	}
	public static void setListCount(int listCount) {
		Msgbox.listCount = listCount;
	}
}
