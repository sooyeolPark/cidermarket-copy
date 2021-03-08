package study.shop.cidermarket.service.impl;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.service.DeleteMsgboxService;

/** 교수 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
// -> import org.springframework.stereotype.Service;
@Slf4j
@Service
public class DeleteMsgboxServiceImpl implements DeleteMsgboxService {
	
	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;

	@Override
	public int deleteMsgbox() throws Exception {
		int total = 0;
		int result_01 = 0;
		int result_02 = 0;
		try {
			result_01 = sqlSession.delete("ReceiverMsgboxMapper.deleteItem", null);
			result_02 = sqlSession.delete("ReceiverMsgboxMapper.deleteItemAfter50days", null);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 삭제에 실패했습니다.");
		}
		total = result_01+result_02;
		return total;
	}

}
