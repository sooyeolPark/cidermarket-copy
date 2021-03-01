package study.shop.cidermarket.service;

public interface DeleteMsgboxService {

	/**
	 * 50일이 지나거나 sender, receiver가 모두 삭제처리 누른 메시지 삭제하기
	 * @return int
	 * @throws Exception
	 */
	public int deleteMsgbox() throws Exception;
	
}
