package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Category;
import study.shop.cidermarket.model.Files;

public interface CategoryService {
	/**
	 * 데이터 상세 조회
	 * @param Category 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public Category getCategoryItem(Category input) throws Exception;
	
	/**
	 * 데이터 목록 조회
	 * @param Category 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Category> getCategoryList(Category input) throws Exception;
	
	/**
	 * 데이터가 저장되어 있는 갯수 조회
	 * @param Category 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getCategoryCount(Category input) throws Exception;
	
	/**
	 * 데이터 등록하기
	 * @param Category 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addCategory(Category input) throws Exception;
	
	/**
	 * 데이터 수정하기
	 * @param Category 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editCategory(Category input) throws Exception;
	
	/**
	 * 데이터 삭제하기
	 * @param Category 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteCategory(Category input) throws Exception;
	
	/**
	 * 데이터 삭제하기
	 * @param Category 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteCategoryImage(Files input) throws Exception;
	
}
