package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Member {
	// 1) 기본 컬럼
	private int membno;
	private String nickname;
	private String email;
	private String password;
	private String tel;
	private String joindate;
	private String editdate;
	private int sms;
	private String shopaddress;
	private String intro;
	private String outmember;
	private float rate;
	
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
		Member.offset = offset;
	}
	public static int getListCount() {
		return listCount;
	}
	public static void setListCount(int listCount) {
		Member.listCount = listCount;
	}
}
