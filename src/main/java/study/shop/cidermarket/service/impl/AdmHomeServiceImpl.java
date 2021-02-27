package study.shop.cidermarket.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.service.AdmHomeService;

@Slf4j
@Service
public class AdmHomeServiceImpl implements AdmHomeService{

	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;
	
	@Override
	public int getRecordCountByDay(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("RecordMapper.selectAdmRecordCount", input);
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
	public int getTotalPayByWeek(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("RecordMapper.selectAdmTotalPayCount", input);
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
	public int getTotalProduct(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("ProductMapper.selectCountAll", input);
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
	public int getTotalMember(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("MemberMapper.adminSelectCountAll", input);
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
	public int getMemberByDay(Member input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("MemberMapper.selectAdmMembCountByDay", input);
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("조회된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

}
