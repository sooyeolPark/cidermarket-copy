package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Product;

public interface AdmOrderService {
	
	/**
	 * 데이터가 저장되어 있는 갯수 조회
	 * @param Product 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getProductCount(Product input) throws Exception;
	
	/**
	 * 데이터 목록 조회
	 * @param Product 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Product> getProductList(Product input) throws Exception;

	/**
	 * 데이터 수정하기
	 * @param Product 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editProduct(Product input) throws Exception;
	
	/**
	 * 데이터 삭제하기
	 * @param Member 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteProduct(Product input) throws Exception;
	
	public List<Product> getPriceAsc(Product input) throws Exception;
	public List<Product> getPriceDesc(Product input) throws Exception;
	public List<Product> getHowJ(Product input) throws Exception;
	public List<Product> getHowT(Product input) throws Exception;
	public List<Product> getTradeconJ(Product input) throws Exception;
	public List<Product> getTradeconW(Product input) throws Exception;
	public int getHowJCount(Product input) throws Exception;
	public int getHowTCount(Product input) throws Exception;
	public int getTradeconJCount(Product input) throws Exception;
	public int getTradeconWCount(Product input) throws Exception;
	
	
	
	

}
