package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class member {
	
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
	
}
