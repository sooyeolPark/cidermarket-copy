package study.shop.cidermarket.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Review;
import study.shop.cidermarket.service.ProductService;
import study.shop.cidermarket.service.ReviewService;

/** 교수 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
// -> import org.springframework.stereotype.Service;
@Slf4j
@Service
public class ReviewWriteImpl implements ReviewService{
	
	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;

	@Override
	public Review getReviewItem(Review input) throws Exception {
		Review result = null;
		try {
			result = sqlSession.selectOne("ReviewWriteMapper.selectItem", input);
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
	public int addReview(Review input) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("ReviewWriteMapper.insertItem", input);
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
	public List<Review> getReviewList(Review input) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public int getReviewCount(Review input) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}






	@Override
	public int editReview(Review input) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}



	@Override
	public int deleteReview(Review input) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
