package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Singo;

public interface AdmSingoService {
	
	/**
	 * 데이터가 저장되어 있는 갯수 조회
	 * @param Singo 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getSingoCount(Singo input) throws Exception;
	
	/**
	 * 데이터 목록 조회
	 * @param Singo 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Singo> getSingoList(Singo input) throws Exception;

	/**
	 * 데이터 수정하기
	 * @param Product 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editSingo(Product input) throws Exception;
	
	/**
	 * 데이터 삭제하기
	 * @param Member 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteSingo(Singo input) throws Exception;

}
