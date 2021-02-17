package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Hashtag;

public interface HashtagService {
	/**
	 * 데이터 목록 조회
	 * @param Hashtag 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Hashtag> getHashtagList(Hashtag input) throws Exception;

	/**
	 * 데이터 등록하기
	 * @param Hashtag 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addHashtag(Hashtag input) throws Exception;

	/**
	 * 데이터 삭제하기
	 * @param Hashtag 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteHashtag(Hashtag input) throws Exception;
	
}
