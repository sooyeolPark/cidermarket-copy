package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Category;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Hashtag;
import study.shop.cidermarket.model.Product;

public interface ItemregService {

	/**
	 * 데이터 목록 조회
	 * @param Category 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Category> getCategoryList() throws Exception;
	
	/**
	 * 파일 이미지 리스트
	 * @param 파일 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Files> getFilesListItem(Files input) throws Exception;
	
	/**
	 * 상품정보 조회
	 * @param 상품 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public Product getProductItem(Product input) throws Exception;
	
	/**
	 * 해쉬태그 리스트
	 * @param 해쉬태그 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Hashtag> getHashtagList(Hashtag input) throws Exception;
}
