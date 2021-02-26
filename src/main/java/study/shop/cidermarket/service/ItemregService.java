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


	/**
	 * 상품 수정
	 * @param 수정한 상품 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int editProduct(Product input) throws Exception;
	
	
	/**
	 * 해쉬태그 삭제 
	 * @param 해쉬태그 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int deleteHashtag(Hashtag input) throws Exception;
	
	/**
	 * 해쉬태그 등록 
	 * @param 해쉬태그 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int addHashtag(Hashtag input) throws Exception;	
	
	/**
	 * 파일 삭제 
	 * @param 해쉬태그 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int deleteFiles(Files input) throws Exception;
	
	/**
	 * 파일 등록 
	 * @param 파일 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int addFiles(Files input) throws Exception;	
	
	/**
	 * 파일 단일행 조회 
	 * @param 파일 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public Files getFilesItem(Files input) throws Exception;	
}
