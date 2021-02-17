package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Msgbox;

public interface MsgboxService {
	/**
	 * 데이터 목록 조회
	 * @param Msgbox 검색결과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Msgbox> getMsgboxList(Msgbox input) throws Exception;
	
	/**
	 * 데이터가 저장되어 있는 갯수 조회
	 * @param Msgbox 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getMsgboxCount(Msgbox input) throws Exception;
	
	/**
	 * 데이터 등록하기
	 * @param Msgbox 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addMsgbox(Msgbox input) throws Exception;
	
	/**
	 * 데이터 수정하기 (보관 유무)
	 * @param Msgbox 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editMsgbox_save(Msgbox input) throws Exception;
	
	/**
	 * 데이터 수정하기 (삭제 유무)
	 * @param Msgbox 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editMsgbox_delete(Msgbox input) throws Exception;
	
	/**
	 * 데이터 삭제하기 (바로 삭제 가능한 파일)
	 * @param Msgbox 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteMsgbox_now(Msgbox input) throws Exception;
	
	/**
	 * 데이터 삭제하기 (50일이 지난 파일)
	 * @param Msgbox 삭제할 데이터의 일련번호를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteMsgbox_50(Msgbox input) throws Exception;
	
}
