package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Alarm {
	private int alarno;
	private int sender;
	private int receiver;
	private String sort;
	private String regdate;
	private int prodno;
	private String subject;
	private String nickname;
}
