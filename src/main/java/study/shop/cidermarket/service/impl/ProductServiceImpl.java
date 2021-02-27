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
			
			//상품삭제전 참조하는 prod을 null값으로 수정 
			sqlSession.update("RecordMapper.unsetProduct",input);
			result = sqlSession.delete("ProductMapper.deleteItem", input);
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
			if (input.getNickname().equals("subject")) {
				result = sqlSession.selectList("ProductMapper.selectCategorySubjectList", input);								
			} else {
				result = sqlSession.selectList("ProductMapper.selectCategoryLatelyList", input);				
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

}
