package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Bbs {
	// 1) 기본 컬럼
	private int bbsno;  // 게시물번호
	private String type;  // 게시판 종류(N=공지사항 / Q=일반문의 / E=이벤트)
	private String name;  // 이름(일반문의게시판에서만 사용)
	private String tel;  // 연락처(일반문의게시판에서만 사용)
	private String email;  // 이메일(일반문의게시판에서만 사용)
	private String category;  // 문의유형(M=회원관련 / P=상품관련 / T=거래관련 / D=택배관련 / E = 기타)(일반문의게시판에서만 사용)
	private String title;  // 제목
	private String content;  // 내용
	private int hits;  // 조회수
	private String regdate;  // 작성일시
	private String editdate;  // 변경일시
	private String reply;  // 일반문의 관리자답변
	private int membno;  // 작성자 고유번호(멤버테이블 참조)
	
	// 2) JOIN절에 따른 추가 컬럼
	private String path;  // 이미지 파일 첨부용
	
	// 3) 페이지 구현을 위한 static 변수
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
