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
}
