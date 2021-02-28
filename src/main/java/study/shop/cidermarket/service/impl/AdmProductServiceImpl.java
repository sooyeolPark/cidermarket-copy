package study.shop.cidermarket.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.AdmProductService;

@Slf4j
@Service
public class AdmProductServiceImpl implements AdmProductService{

	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;
	
	@Override
	public int getProductCount(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("AdmProductMapper.ProductSelectCountAll", input);
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
			result = sqlSession.selectList("AdmProductMapper.ProductSelectList", input);
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
	public int editProduct(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("AdmProductMapper.ProductUpdateItem", input);
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
			result = sqlSession.delete("AdmProductMapper.deleteItem", input);
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
	public List<Product> getPriceAsc(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("AdmProductMapper.getPriceAsc", input);
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
	public List<Product> getPriceDesc(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("AdmProductMapper.getPriceDesc", input);
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
	public List<Product> getHowJ(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("AdmProductMapper.getHowJ", input);
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
	public List<Product> getHowT(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("AdmProductMapper.getHowT", input);
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
	public List<Product> getTradeconJ(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("AdmProductMapper.getTradeconJ", input);
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
	public List<Product> getTradeconW(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("AdmProductMapper.getTradeconW", input);
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
	public int getHowJCount(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("AdmProductMapper.getHowJCount", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int getHowTCount(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("AdmProductMapper.getHowTCount", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int getTradeconJCount(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("AdmProductMapper.getTradeconJCount", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int getTradeconWCount(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("AdmProductMapper.getTradeconWCount", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

}
