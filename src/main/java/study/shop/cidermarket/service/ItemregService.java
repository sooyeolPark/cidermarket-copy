package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Category;

public interface ItemregService {

	/**
	 * 데이터 목록 조회
	 * @param Category 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Category> getCategoryList() throws Exception;
	
}
