package study.shop.cidermarket.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.service.ProductService;
import study.shop.cidermarket.model.Product;

/** 교수 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
// -> import org.springframework.stereotype.Service;
@Slf4j
@Service
public class ProductServiceImpl implements ProductService {
	
	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;

	@Override
	public Product getProductItem(Product input) throws Exception {
		Product result = null;
		try {
			result = sqlSession.selectOne("ProductMapper.selectItem", input);
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
	public List<Product> getProductList(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("ProductMapper.selectList", input);
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
	public int getProductCount(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("ProductMapper.selectCountAll", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int addProduct(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("ProductMapper.insertItem", input);
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
	public int editProduct(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("ProductMapper.updateItem", input);
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
	public int deleteProduct(Product input) throws Exception {
		int result = 0;
		try {
			if(input.getTradecon().equals("W")) {
				throw new NullPointerException("판매가 완료된 상품은 삭제할 수 없습니다.");
			} else {
				// 신고 테이블 삭제
				sqlSession.delete("SingoMapper.deleteProductItem", input);
				// 해시태그 테이블 삭제
				sqlSession.delete("HashtagMapper.deleteItem", input);
				// 찜하기 테이블 삭제
				sqlSession.delete("MembprodMapper.deleteProductItem", input);
				// 대댓글-댓글 테이블 삭제
				sqlSession.delete("RereplyMapper.deleteProductItem", input);
				sqlSession.delete("ReplyMapper.deleteProductItem", input);
				// 거래내역 테이블 삭제 (직거래/상관없음 경우)
				sqlSession.delete("RecordMapper.deleteProductItem",input);
				// 쪽지함 주고받은 쪽지 더미상품으로 변경
				sqlSession.update("ReceiverMsgboxMapper.updateItemByProdno",input);
				
				result = sqlSession.delete("ProductMapper.deleteItem", input);
				if(result == 0) {
					throw new NullPointerException("result=0");
				}				
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
	
	/** 특정 회원이 올린 상품 수 */
	@Override
	public int getMemberProductCount(Product input) throws Exception {
		int result = 0;
		try {
			if (input.getTradecon().equals("MP")) {
				result = sqlSession.selectOne("ProductMapper.selectCountMemberItemsMP", input);
			} else {
				result = sqlSession.selectOne("ProductMapper.selectCountMemberItems", input);
			}
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}
	
	/** 특정 회원이 올린 상품 리스트 조회 */
	@Override
	public List<Product> getMemberProductList(Product input) throws Exception {
		List<Product> result = null;
		try {
			if (input.getTradecon().equals("MP")) {
				result = sqlSession.selectList("ProductMapper.selectMemberListMP", input);
			} else {
				result = sqlSession.selectList("ProductMapper.selectMemberList", input);
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
	

	/** 상품진열(카테고리) 목록 */
	@Override
	public List<Product> getCategoryProductList(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("ProductMapper.selectCategoryList", input);								
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
	
	/** 상품진열(카테고리) 수정 */
	@Override
	public int editCategoryProduct(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("ProductMapper.categoryUpdateItem", input);
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
	public int editTradecon(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("ProductMapper.singoUpdateItem", input);
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
	public List<Product> selectListByFilter(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("ProductMapper.selectListByFilter", input);
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
	
	/** 특정 회원이 올린 상품 수 */
	@Override
	public int getProductCountByFilter(Product input) throws Exception {
		int result = 0;
		try {

		result = sqlSession.selectOne("ProductMapper.selectCountFilter", input);
			
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

}
