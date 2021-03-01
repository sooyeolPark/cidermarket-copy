package study.shop.cidermarket.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Hashtag;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Membprod;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.model.Reply;
import study.shop.cidermarket.model.Rereply;
import study.shop.cidermarket.model.Singo;
import study.shop.cidermarket.service.ItemIndexService;

/** 교수 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
//-> import org.springframework.stereotype.Service;
@Slf4j
@Service
public class ItemIndexServiceImpl implements ItemIndexService {

	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;
	
	@Override
	public List<Files> getFilesListItem(Files input) throws Exception {
		List<Files> result = null;
		try {
			result = sqlSession.selectList("FilesMapper.selectReviewImgList", input);
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
	public int getProductCount(Product input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("ProductMapper.selectCountMemberItems", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public Member getSellerItem(Member input) throws Exception {
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
	public int getTradeCount(Record input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.selectOne("RecordMapper.selectCount", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public List<Reply> getReplyList(Reply input) throws Exception {
		List<Reply> result = null;
		try {
			result = sqlSession.selectList("ReplyMapper.selectList", input);
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
	public List<Rereply> getRereplyList(Rereply input) throws Exception {
		List<Rereply> result = null;
		try {
			result = sqlSession.selectList("RereplyMapper.selectList", input);
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
	public List<Membprod> getMembprodList(Membprod input) throws Exception {
		List<Membprod> result = null;
		try {
			result = sqlSession.selectList("MembprodMapper.selectList", input);
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
	public List<Product> getProductListByCategory(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("ItemListMapper.selectListByCategory", input);
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
	public List<Product> getProductListByMember(Product input) throws Exception {
		List<Product> result = null;
		try {
			result = sqlSession.selectList("ItemListMapper.selectListBySeller", input);
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
	public List<Hashtag> getHashtagList(Hashtag input) throws Exception {
		List<Hashtag> result = null;
		try {
			result = sqlSession.selectList("HashtagMapper.selectList", input);
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
	public int addSingo(Singo input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("SingoMapper.insertItem", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 저장에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int addReply(Reply input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("ReplyMapper.insertItem", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 저장에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int addRereply(Rereply input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("RereplyMapper.insertItem", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 저장에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int editReply(Reply input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.update("ReplyMapper.updateItem", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int deleteRereply(Rereply input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.delete("RereplyMapper.deleteItem", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 삭제에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int addMembprod(Membprod input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("MembprodMapper.insertItem", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 저장에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int deleteMembprod(Membprod input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.delete("MembprodMapper.deleteItem", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 삭제에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int editProduct(Product input) throws Exception {
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
	
	public List<Files> getFilesReviewListItem(Files input) throws Exception {
		List<Files> result = null;
		try {
			result = sqlSession.selectList("FilesMapper.selectReviewImgList", input);
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
