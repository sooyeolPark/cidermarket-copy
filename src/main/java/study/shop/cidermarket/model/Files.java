package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Files {
	private int fileno;
	private String fname;
	private String path;
	private String type;
	private String size;
	private String regdate;
	private String editdate;
	private String reftable;
	private int refid;
}
