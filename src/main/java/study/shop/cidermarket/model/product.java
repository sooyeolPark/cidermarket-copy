package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class product {
	private int prodno;
	private int cateno;
	private String subject;
	private int price;
	private int fee;
	private String detail;
	private String regdate;
	private String prodcon;
	private String how;
	private String tradecon;
	private int seller;
	private int hits;
	private String editdate;
}
