package study.shop.cidermarket.model;

import lombok.Data;

@Data
public class Files {
	private int fileno; // 파일번호
	private String fname;  // 파일이름
	private String oriname; // 원본 파일이름
	private String filepath;  // 서버상의 파일 경로
	private String thumbnailPath;  // 썸네일 이미지 경로
	private String fileUrl;  // 서버상의 원본 이미지 URL
	private String thumbnailUrl;  // 썸네일 이미지 URL
	private String type;  // 파일형식
	private long size;  // 파일용량
	private String regdate;  // 등록일
	private String editdate;  // 수정일
	private String reftable;  // 연관 테이블
	private int refid;  // 연관 테이블의 데이터번호
}
