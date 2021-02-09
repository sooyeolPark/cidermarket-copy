package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class reply {
	private int replyno;
	private int prodno;
	private int writer;
	private String content;
	private String regdate;
	private String editdate;
}
