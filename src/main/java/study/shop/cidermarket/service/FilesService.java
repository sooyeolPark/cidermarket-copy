package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Files;

public interface FilesService {
	/**
	 * 데이터 상세 조회
	 * @param Files 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public Files getFilesItem(Files input) throws Exception;
	
	/**
	 * 연관게시물 데이터 목록 조회
	 * @param Files 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Files> getRefFilesList(Files input) throws Exception;
	
	/**
	 * 데이터 목록 조회
	 * @param Files 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Files> getFilesList(Files input) throws Exception;
	
	/**
	 * 데이터가 저장되어 있는 갯수 조회
	 * @param Files 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getFilesCount(Files input) throws Exception;
	
	/**
	 * 데이터 등록하기
	 * @param Files 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addFiles(Files input) throws Exception;
	
	/**
	 * 데이터 수정하기
	 * @param Files 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editFiles(Files input) throws Exception;
	
	/**
	 * 데이터 삭제하기
	 * @param Files 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteFiles(Files input) throws Exception;

	/**
	 * refid로 데이터 삭제하기
	 * @param input
	 * @return
	 * @throws Exception
	 */
	public int deleteRefIdFiles(Files input) throws Exception;
	
}
