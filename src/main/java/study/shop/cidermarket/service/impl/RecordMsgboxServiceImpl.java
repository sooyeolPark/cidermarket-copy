package study.shop.cidermarket.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.service.MsgboxService;

/** 교수 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
// -> import org.springframework.stereotype.Service;
@Slf4j
@Service
public class RecordMsgboxServiceImpl implements MsgboxService {
	
	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;

	@Override
	public List<Msgbox> getMsgboxList(Msgbox input) throws Exception {
		List<Msgbox> result = null;
		try {
			result = sqlSession.selectList("RecordMsgboxMapper.selectBuyerList", input);
			if(result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("구매 대기자 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("구매 대기자 데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int getMsgboxCount(Msgbox input) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int addMsgbox(Msgbox input) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int editMsgbox_save(Msgbox input) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int editMsgbox_delete(Msgbox input) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMsgbox_now(Msgbox input) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMsgbox_50(Msgbox input) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	

}
