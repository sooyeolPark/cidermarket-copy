package study.shop.cidermarket.service;

import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Record;

public interface AdmHomeService {
	
	/**
	 * n일 전 거래건수 조회
	 * @param Member 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getRecordCountByDay(Record input) throws Exception;
	
	/**
	 * 총 거래액 
	 * @param Member 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int getTotalPayByWeek(Record input) throws Exception;
	
	/**
	 * 전체 상품 수
	 * @param Member 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int getTotalProduct(Product input) throws Exception;
	
	/**
	 * 전체 회원수 (탈퇴 제외)
	 * @param Member 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int getTotalMember(Member input) throws Exception;
	
	/**
	 * 데이터 목록 조회
	 * @param Member 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int getMemberByDay(Member input) throws Exception;
	
}
