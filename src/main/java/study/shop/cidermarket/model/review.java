package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class review {
	private int revino;
	private int prodno;
	private String regdate;
	private int rate;
	private String content;
	private int recono;
	private int sender;
	private int receiver;
}
