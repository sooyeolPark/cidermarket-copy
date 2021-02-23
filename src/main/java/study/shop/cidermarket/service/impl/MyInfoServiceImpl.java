package study.shop.cidermarket.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.service.MyInfoService;
import study.shop.cidermarket.model.Member;

/** 교수 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
// -> import org.springframework.stereotype.Service;
@Slf4j
@Service
public class MyInfoServiceImpl implements MyInfoService {
	
	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;

	//-------------------------------------------------------------------
	//회원정보 조회하기 
	@Override
	public Member getMemberItem(Member input) throws Exception {
		Member result = null;
		try {
			result = sqlSession.selectOne("MyInfoMapper.selectItem", input);
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
	
	//----DB에 있는지 없는 확인하기 ----------------------------------------------------
	// '0'은 없음 '1'은 있음 
	
	@Override
	public int getMemberCount(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("MyInfoMapper.selectCountAll", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	//-------------------------------------------------------------------
	//----DB에 있는지 없는 확인하기 ----------------------------------------------------
	// '0'은 없음 '1'은 있음 
	
	@Override
	public int getShopaddressCount(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("MyInfoMapper.selectCountShopaddress", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	//-------------------------------------------------------------------
	
	@Override
	public int getEmailCount(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("MyInfoMapper.selectCountEmail", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	//-------------------------------------------------------------------
	@Override
	public int getTelCount(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("MyInfoMapper.selectCountTel", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	//-------------------------------------------------------------------
	@Override
	public int getCheckPassword(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("MyInfoMapper.selectCheckPassword", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	//-------------------------------------------------------------------
	
	@Override
	public int editNickName(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("MyInfoMapper.updateNameItem", input);
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
	public int editIntro(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("MyInfoMapper.updateIntro", input);
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
	public int editShopaddress(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("MyInfoMapper.updateShopaddress", input);
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
	public int editEmail(Member input) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		try {
			result = sqlSession.update("MyInfoMapper.updateEmail", input);
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
	public int editTel(Member input) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		try {
			result = sqlSession.update("MyInfoMapper.updateTel", input);
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
	public int editPassword(Member input) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		try {
			result = sqlSession.update("MyInfoMapper.updatePassword", input);
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
	public int editSMS(Member input) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		try {
			result = sqlSession.update("MyInfoMapper.updateSMS", input);
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
	public int editOutmember(Member input) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		try {
			result = sqlSession.update("MyInfoMapper.updateOutmember", input);
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//-------------------------------------------------------------------
	
	
	/** 멤버번호로 단일행 조회 */
	@Override
	public Member getMemberIndexItem(Member input) throws Exception {
		Member result = null;
		try {
			result = sqlSession.selectOne("MyInfoMapper.selectItemIndex", input);
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
			result = sqlSession.selectList("MyInfoMapper.selectList", input);
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
	public int addMember(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("MyInfoMapper.insertItem", input);
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
			result = sqlSession.update("MyInfoMapper.updateItem", input);
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
			result = sqlSession.delete("MyInfoMapper.deleteItem", input);
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
			result = sqlSession.selectOne("MyInfoMapper.selectTelItem", input);
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
			result = sqlSession.selectOne("MyInfoMapper.selectEmailItem", input);
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
			result = sqlSession.update("MyInfoMapper.updatePassItem", input);
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
