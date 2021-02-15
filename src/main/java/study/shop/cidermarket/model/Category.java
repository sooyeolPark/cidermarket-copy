package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Category {
	
	
	//1) 기본값 
	private int cateno;
	private String name;
	
	
	// 2) JOIN절에 따른 추가 컬럼
	private String path;  // 이미지 파일 첨부용
	
	// 3) 페이지 구현을 위한 static 변수
	//페이지 구현이 필요한 경우 아래 속성들을 추가한다. (static)
	private static int offset;		// LIMIT 절에서 사용할 검색 시작 위치
	private static int listCount;		// LIMIT 절에서 사용할 검색할 데이터 수
	
	public static int getOffset() {
		return offset;
	}
	public static void setOffset(int offset) {
		Category.offset = offset;
	}
	public static int getListCount() {
		return listCount;
	}
	public static void setListCount(int listCount) {
		Category.listCount = listCount;
	}	
	
}
