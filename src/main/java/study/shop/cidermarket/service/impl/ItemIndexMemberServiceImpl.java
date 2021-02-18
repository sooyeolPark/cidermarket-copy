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
public class ItemIndexMemberServiceImpl implements MemberService {
	
	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;

	@Override
	public Member getMemberItem(Member input) throws Exception {
		Member result = null;
		try {
			/** 상품 상세에 쓸 단일행 조회를 위한 기능 정의 */
			result = sqlSession.selectOne("MemberMapper.selectItemIndex", input);
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
		return null;
	}

	@Override
	public int getMemberCount(Member input) throws Exception {
		return 0;
	}

	@Override
	public int addMember(Member input) throws Exception {
		return 0;
	}

	@Override
	public int editMember(Member input) throws Exception {
		return 0;
	}

	@Override
	public int deleteMember(Member input) throws Exception {
		return 0;
	}

	@Override
	public Member getMemberTelItem(Member input) throws Exception {
		return null;
	}
	
	@Override
	public Member getMemberEmailItem(Member input) throws Exception {
		return null;
	}

	@Override
	public int editPassMember(Member input) throws Exception {
		return 0;
	}

}
