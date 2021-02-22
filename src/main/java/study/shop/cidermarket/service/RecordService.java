package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.model.Record;

public interface RecordService {
	/**
	 * 데이터 상세 조회
	 * @param Record 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public Record getRecordItem(Record input) throws Exception;
	
	/**
	 * 데이터 목록 조회 (거래중)
	 * @param Record 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Record> getRecordSellIngList(Record input) throws Exception;
	
	/**
	 * 데이터 목록 조회 (거래완료)
	 * @param Record 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Record> getRecordSellEndList(Record input) throws Exception;
	
	/**
	 * 데이터 목록 조회 (거래중)
	 * @param Record 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Record> getRecordBuyIngList(Record input) throws Exception;
	
	/**
	 * 데이터 목록 조회 (거래완료)
	 * @param Record 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Record> getRecordBuyEndList(Record input) throws Exception;
	
	/**
	 * 직거래 구매자 목록 조회 (거래중)
	 * @param Record 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Record> getRecordBuyerList(Msgbox input) throws Exception;
	
	/**
	 * 판매중 데이터가 저장되어 있는 갯수 조회
	 * @param Record 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getRecordSellIngCount(Record input) throws Exception;
	
	/**
	 * 판매완료 데이터가 저장되어 있는 갯수 조회
	 * @param Record 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getRecordSellEndCount(Record input) throws Exception;
	
	/**
	 * 구매중 데이터가 저장되어 있는 갯수 조회
	 * @param Record 검색조건을 담고 있는 Beans
<<<<<<< HEAD
=======
	 * @return int
	 * @throws Exception
	 */
	public int getRecordBuyIngCount(Record input) throws Exception;
	
	/**
	 * 구매완료 데이터가 저장되어 있는 갯수 조회
	 * @param Record 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getRecordBuyEndCount(Record input) throws Exception;
	
	/**
	 * 데이터 등록하기
	 * @param Record 저장할 정보를 담고 있는 Beans
>>>>>>> branch 'cidermarket' of git@github.com:ITPAPER/ezen-android2020-3.git
	 * @return int
	 * @throws Exception
	 */
	public int getRecordBuyIngCount(Record input) throws Exception;
	
	/**
	 * 구매완료 데이터가 저장되어 있는 갯수 조회
	 * @param Record 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getRecordBuyEndCount(Record input) throws Exception;
	
	/**
	 * 데이터 등록하기
	 * @param Record 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	
	public Record getRecordSellEndCountByMonth(Record input) throws Exception;
	
	/**
	 * 데이터 등록하기
	 * @param Record 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 * 
	 * 
	 */
	
	public Record getRecordBuyEndCountByMonth(Record input) throws Exception;
	
	/**
	 * 데이터 등록하기
	 * @param Record 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 * 
	 * 
	 */
	public int addRecord(Record input) throws Exception;
	
	/**
	 * 판매자 거래 확정 정보 업데이트 하기 (직거래냐 택배에 따라 메서드 변경)
	 * @param Record 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editConfirmRecord(Record input) throws Exception;
	
	/**
	 * 구매자 거래 확정 정보 업데이트 하기 (직거래냐 택배에 따라 메서드 변경)
	 * @param Record 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editBuyConfirmRecord(Record input) throws Exception;
	
	/**
	 * 거래 취소 정보 업데이트 하기 (택배거래 한정)
	 * @param Record 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editCancelRecord(Record input) throws Exception;
	
	/**
	 * 반품 승인 정보 업데이트 하기 (택배거래 한정)
	 * @param Record 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editRefundRecord(Record input) throws Exception;
	
	/**
	 * 데이터 삭제하기
	 * @param Record 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteRecord(Record input) throws Exception;
	
}
