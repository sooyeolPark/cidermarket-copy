package study.shop.cidermarket.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.service.RecordService;

/** 교수 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
// -> import org.springframework.stereotype.Service;
@Slf4j
@Service
public class RecordServiceImpl implements RecordService {
	
	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;
	@Autowired WebHelper webHelper;

	@Override
	public Record getRecordItem(Record input) throws Exception {
		Record result = null;
		
		HttpSession session = webHelper.getRequest().getSession(); 
		int myNum = (int)session.getAttribute("myNum");
		
		try {
			if (input.getBuyer() == myNum) { // 작성자가 구매자라면 판매자에게 후기남기기
				log.debug("판매자에게 후기 남기기 내 번호는 = "+myNum + "------buyer 번호는 = " + input.getBuyer());
				log.debug("판매자에게 후기 남기기 내 번호는 = "+myNum + "------seller 번호는 = " + input.getSeller());
				result = sqlSession.selectOne("RecordMapper.selectBuyItem", input);								
			} else { 						 // 작성자가 판매자라면 구매자에게 후기남기기
				log.debug("구매자에게 후기 남기기 내 번호는 = "+myNum + "------buyer 번호는 = " + input.getBuyer());
				log.debug("판매자에게 후기 남기기 내 번호는 = "+myNum + "------seller 번호는 = " + input.getSeller());
				result = sqlSession.selectOne("RecordMapper.selectItem", input);				
			}
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
	
	
	// -------------- 판매자 거래내역 (거래중) ------------------------------//
	@Override
	public List<Record> getRecordSellIngList(Record input) throws Exception {
		List<Record> result = null;
		try {
			result = sqlSession.selectList("RecordMapper.selectSellIngList", input);
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
	// -------------- 판매자 거래내역 (거래완료) ------------------------------//
	@Override
	public List<Record> getRecordSellEndList(Record input) throws Exception {
		List<Record> result = null;
		try {
			result = sqlSession.selectList("RecordMapper.selectSellEndList", input);
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
	// -------------- 판매자 직거래 구매자 후보리스트 (거래중) ------------------------------//
	@Override
	public List<Record> getRecordBuyerList(Msgbox input) throws Exception {
		List<Record> result = null;
		try {
			result = sqlSession.selectList("RecordMapper.selectBuyerList", input);
			if(result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("구매자 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("구매자 데이터 조회에 실패했습니다.");
		}
		return result;
	}
	// -------------- 판매자 거래중 건수 카운트 ------------------------------//
	@Override
	public int getRecordSellIngCount(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("RecordMapper.selectSellIngCount", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	// -------------- 판매자 거래완료 건수 카운트 ------------------------------//
	@Override
	public int getRecordSellEndCount(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("RecordMapper.selectSellEndCount", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	
	
	@Override
	public Record getRecordSellEndCountByMonth(Record input) throws Exception {
		Record result = null;
		try {
			result = sqlSession.selectOne("RecordMapper.selectSellEndCountByMonth", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	
	@Override
	public Record getRecordBuyEndCountByMonth(Record input) throws Exception {
		Record result = null;
		try {
			result = sqlSession.selectOne("RecordMapper.selectBuyEndCountByMonth", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	

	@Override
	public int addRecord(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("RecordMapper.insertItem", input);
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
	
	
	// -------------- 판매자 택배 거래확정 ------------------------------//
	@Override
	public int editConfirmRecord(Record input) throws Exception {
		int result = 0;
		try {
			if (input.getHow() == "J") { // 직거래 확정시
				result = sqlSession.update("RecordMapper.updateTradeconJWItem", input);				
				result = sqlSession.update("RecordMapper.updateProductTradeconJWItem", input);				
			} else {  // 택배거래 확정시
				result = sqlSession.update("RecordMapper.updateTradeconTWItem", input);								
			}
			if(result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("확정할 거래가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("거래 확정에 실패했습니다.");
		}
		return result;
	}
	
	// -------------- 판매자 거래취소 ------------------------------//
	@Override
	public int editCancelRecord(Record input) throws Exception {
		int result = 0;
		try {
				result = sqlSession.update("RecordMapper.updateTradeconSItem", input);				
				result += sqlSession.update("RecordMapper.updateProductTradeconSItem", input);				
			if(result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("확정할 거래가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("거래 확정에 실패했습니다.");
		}
		return result;
	}
	// -------------- 판매자 반품승인 ------------------------------//
	@Override
	public int editRefundRecord(Record input) throws Exception {
		int result = 0;
		try {
				result = sqlSession.update("RecordMapper.updateRefundItem", input);				
			if(result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("반품승인할 거래가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("반품 승인에 실패했습니다.");
		}
		return result;
	}
		
	@Override
	public int deleteRecord(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.delete("RecordMapper.deleteItem", input);
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
	
	
	
	
	
	
	/** ----------------------------------- 구매내역 ---------------------------------- */
	
	// -------------- 구매자 거래중 목록 조회 --------------------------//
	@Override
	public List<Record> getRecordBuyIngList(Record input) throws Exception {
		List<Record> result = null;
		try {
			result = sqlSession.selectList("RecordMapper.selectBuyIngList", input);
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

	// -------------- 구매자 거래완료 목록 조회 --------------------------//
	@Override
	public List<Record> getRecordBuyEndList(Record input) throws Exception {
		List<Record> result = null;
		try {
			result = sqlSession.selectList("RecordMapper.selectBuyEndList", input);
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
	
	// -------------- 구매자 거래중 건수 카운트 ------------------------------//
	@Override
	public int getRecordBuyIngCount(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("RecordMapper.selectBuyIngCount", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	
	// -------------- 구매자 거래완료 건수 카운트 ------------------------------//
	@Override
	public int getRecordBuyEndCount(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("RecordMapper.selectBuyEndCount", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	
	// -------------- 구매자 택배 거래확정 ------------------------------//
	@Override
	public int editBuyConfirmRecord(Record input) throws Exception {
		int result = 0;
		try {
			if (input.getHow() == "J") { // 직거래 확정시
				result = sqlSession.update("RecordMapper.updateBuyTradeconJWItem", input);				
			} else {  // 택배거래 확정시
				result = sqlSession.update("RecordMapper.updateBuyTradeconTWItem", input);								
			}
			if(result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("확정할 거래가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("거래 확정에 실패했습니다.");
		}
		return result;
	}



	// -------------- 관리자 거래내역 ------------------------------//
	@Override
	public List<Record> getTotalList(Record input) throws Exception {
		List<Record> result = null;
		try {
			result = sqlSession.selectList("RecordMapper.selectTotalList", input);
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
	
	// -------------- 구매자 거래중 건수 카운트 ------------------------------//
	@Override
	public int getTotalCount(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("RecordMapper.selectCountAll", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	// -------------- 구매자 거래중 건수 카운트 ------------------------------//





}
