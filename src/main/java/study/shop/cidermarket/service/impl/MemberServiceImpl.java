package study.shop.cidermarket.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.model.Member;

/** 교수 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
// -> import org.springframework.stereotype.Service;
@Slf4j
@Service
public class MemberServiceImpl implements MemberService {
	
	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;

	@Override
	public Member getMemberItem(Member input) throws Exception {
		Member result = null;
		try {
			result = sqlSession.selectOne("MemberMapper.selectItem", input);
			if(result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("회원 정보가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("회원 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public List<Member> getMemberList(Member input) throws Exception {
		List<Member> result = null;
		try {
			result = sqlSession.selectList("MemberMapper.selectList", input);
			if(result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("조회된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int getMemberCount(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("MemberMapper.selectCountAll", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int addMember(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("MemberMapper.insertItem", input);
			if(result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("저장된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 저장에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int editMember(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("MemberMapper.updateItem", input);
			if(result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("수정된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int deleteMember(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.delete("MemberMapper.deleteItem", input);
			if(result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("삭제된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 삭제에 실패했습니다.");
		}
		return result;
	}

	@Override
	public Member getMemberTelItem(Member input) throws Exception {
		Member result = null;
		try {
			result = sqlSession.selectOne("MemberMapper.selectTelItem", input);
			if(result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("회원 정보가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("회원 조회에 실패했습니다.");
		}
		return result;
	}
	
	@Override
	public Member getMemberEmailItem(Member input) throws Exception {
		Member result = null;
		try {
			result = sqlSession.selectOne("MemberMapper.selectEmailItem", input);
			if(result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("회원 정보가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("회원 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int editPassMember(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("MemberMapper.updatePassItem", input);
			if(result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("비밀번호 수정된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("비밀번호 수정에 실패했습니다.");
		}
		return result;
	}

}
