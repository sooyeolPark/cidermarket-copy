package study.shop.cidermarket.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.service.ItemListService;
import study.shop.cidermarket.model.Product;

/** 교수 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
// -> import org.springframework.stereotype.Service;
@Slf4j
@Service
public class ItemListServiceImpl implements ItemListService {
	
	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;

	@Override
	public Product getItemListItem(Product input) throws Exception {
		Product result = null;
		try {
			result = sqlSession.selectOne("ItemListMapper.selectItem", input);
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
	public List<Product> getItemListList(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("ItemListMapper.selectList", input);
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
	public int getItemListCount(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("ItemListMapper.selectCountAll", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int addItemList(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("ItemListMapper.insertItem", input);
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
	public int editItemList(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("ItemListMapper.updateItem", input);
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
	public List<Product> selectItemByFilter(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("ItemListMapper.selectItemByFilter", input);
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
	public List<Product> selectListByPriceAsc(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("ItemListMapper.selectListByPriceAsc", input);
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
	public List<Product> selectListByRegdate(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("ItemListMapper.selectListByRegdate", input);
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
	public List<Product> selectListByPriceDesc(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("ItemListMapper.selectListByPriceDesc", input);
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

}
