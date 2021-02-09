package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class msgbox {
	private int msgno;
	private int sender;
	private int receiver;
	private String content;
	private String save;
	private int prodno;
	private String regdate;

}
