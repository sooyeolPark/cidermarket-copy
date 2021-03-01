package study.shop.cidermarket.service;

import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Record;

public interface OrderService {
	/**
	 * product 테이블 거래상태를 거래완료로 바꿔주는 기능
	 * @param int
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int editProduct(Product input) throws Exception;
	
	/**
	 * 레코드 테이블에 새로운 정보 저장
	 * @param 입력할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addRecord(Record input) throws Exception;
	
	/**
	 * 레코드 테이블에 새로운 정보 저장
	 * @param 입력할 정보를 담고 있는 Beans
	 * @return Record
	 * @throws Exception
	 */
	public Record getRecord(Record input) throws Exception;
	
	/**
	 * 레코드 테이블에 직거래 필드 삭제
	 * @param 입력할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteRecord(Record input) throws Exception;
}
