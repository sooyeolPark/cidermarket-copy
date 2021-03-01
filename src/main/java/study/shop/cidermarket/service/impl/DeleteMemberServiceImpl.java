package study.shop.cidermarket.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.protobuf.compiler.PluginProtos.CodeGeneratorResponse.File;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Membprod;
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.model.Reply;
import study.shop.cidermarket.model.Rereply;
import study.shop.cidermarket.model.Review;
import study.shop.cidermarket.model.Singo;
import study.shop.cidermarket.service.DeleteMemberService;

/** 교수 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
// -> import org.springframework.stereotype.Service;
@Slf4j
@Service
public class DeleteMemberServiceImpl implements DeleteMemberService {
	
	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;

	@Override
	public List<Member> getOutmemberList(Member input) throws Exception {
		List<Member> result = null;
		try {
			result = sqlSession.selectList("MemberMapper.selectListbyOutmember", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int deleteFile(File input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.delete("FilesMapper.deleteRefItem", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 삭제에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int deleteMembprod(Membprod input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.delete("MembprodMapper.deleteItemByMembno", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 삭제에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int updateSender(Msgbox input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("ReceiverMsgboxMapper.updateItemBySender", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int updateReceiver(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("ReceiverMsgboxMapper.updateItemByReceiver", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int updateRecord(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("RecordMapper.updateItemByMembno", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int updateReply(Reply input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("ReplyMapper.updateItemByMemebno", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int updateRereply(Rereply input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("RereplyMapper.updateItemByMemebno", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int updateReviewSender(Review input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("ReviewMapper.updateItemBySender", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int deleteReviewReceiver(Review input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.delete("ReviewMapper.deleteItemByReceiver", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 삭제에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int updateSingo(Singo input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("SingoMapper.updateItemByMembno", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}
		return result;
	}


}
