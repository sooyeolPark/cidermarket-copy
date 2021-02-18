package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Rereply {
	private int rereplyno;
	private int replyno;
	private int writer;
	private String content;
	private String regdate;
	private String editdate;
	private int prodno;
	
	// 2) JOIN절에 따른 추가 컬럼
	private String nickname;
}
