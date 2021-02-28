package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Alarm;
import study.shop.cidermarket.model.Product;

public interface AlarmService {
	/**
	 * 알람 테이블에 새로운 정보 저장
	 * @param 입력할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addAlarm(Alarm input) throws Exception;
	
	/**
	 * 데이터 상세 조회
	 * @param 입력할 정보를 담고 있는 Beans
	 * @return 조회 결과에 따른 컬렉션
	 * @throws Exception
	 */
	public Alarm getAlarmItem(Alarm input) throws Exception;
	
	/**
	 * 데이터 목록 조회
	 * @param 조회된 데이터가 저장된 Beans
	 * @return Exception
	 */
	public List<Alarm> getAlarmList(Alarm input) throws Exception;
	
	/**
	 * 데이터 삭제하기
	 * @param 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteAlarm(Alarm input) throws Exception;
	
	/** 
	 * 데이터가 저장되어 있는 갯수 조회
	 * @param 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getAlarmCount(Alarm input) throws Exception;

	/**
	 * 상품명 조회를 위한 상품 상세 조회
	 * @param 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public Product getProductItem(Alarm input) throws Exception;
}
