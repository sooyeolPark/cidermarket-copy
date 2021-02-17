package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Product;

public interface ItemListService {
	/**
	 * 데이터 상세 조회
	 * @param ItemList 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public Product getItemListItem(Product input) throws Exception;
	
	/**
	 * 데이터 목록 조회
	 * @param ItemList 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Product> getItemListList(Product input) throws Exception;
	
	/**
	 * 데이터가 저장되어 있는 갯수 조회
	 * @param ItemList 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getItemListCount(Product input) throws Exception;
	
	/**
	 * 데이터 등록하기
	 * @param ItemList 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addItemList(Product input) throws Exception;
	
	/**
	 * 데이터 수정하기
	 * @param ItemList 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editItemList(Product input) throws Exception;
	
	/**
	 * 데이터 삭제하기
	 * @param ItemList 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public List<Product> selectItemByFilter(Product input) throws Exception;
	public List<Product> selectListByPriceAsc(Product input) throws Exception;
	public List<Product> selectListByRegdate(Product input) throws Exception;
	public List<Product> selectListByPriceDesc(Product input) throws Exception;
	

}

