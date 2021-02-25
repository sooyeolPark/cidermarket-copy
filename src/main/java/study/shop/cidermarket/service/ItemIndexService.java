package study.shop.cidermarket.service;

import java.util.List;

import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Hashtag;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Membprod;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Reply;
import study.shop.cidermarket.model.Rereply;
import study.shop.cidermarket.model.Singo;

public interface ItemIndexService {
	
	/**
	 * 파일 패스 리스트 조회
	 * @param filepath 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public List<Files> getFilesListItem(Files input) throws Exception;
	
	/**
	 * 상품 단일행 조회
	 * @param filepath 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public Product getProductItem(Product input) throws Exception;
	
	/**
	 * 상품 수 조회
	 * @param 판매자 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public int getProductCount (Product input) throws Exception;
	
	/**
	 * 판매자 단일행 조회
	 * @param 판매자 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public Member getSellerItem(Member input) throws Exception;
	
	/**
	 * 판매자 거래성공 수 조회
	 * @param 판매자 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public int getTradeCount(study.shop.cidermarket.model.Record input) throws Exception;
	
	/**
	 * 댓글
	 * @param 댓글을 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public List<Reply> getReplyList(Reply input) throws Exception;
	
	/**
	 * 대댓글
	 * @param 대댓글 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public List<Rereply> getRereplyList(Rereply input) throws Exception;
	
	/**
	 * 상품에 찜하기 누른 리스트 가져오기
	 * @param 상품에 찜하기 누른 리스트를 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public List<Membprod> getMembprodList(Membprod input) throws Exception;
	
	/**
	 * 카테고리별 아이템 리스트
	 * @param 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public List<Product> getProductListByCategory(Product input) throws Exception;
	
	/**
	 * 작성자별 아이템 리스트
	 * @param 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public List<Product> getProductListByMember(Product input) throws Exception;
	
	/**
	 * 해쉬태그 리스트 조회
	 * @param 조회할 데이터의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public List<Hashtag> getHashtagList(Hashtag input) throws Exception;
	
	/**
	 * 신고 데이터 등록하기
	 * @param 신고테이블에 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addSingo(Singo input) throws Exception;
	
	/**
	 * 댓글 등록하기
	 * @param 댓글테이블에 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addReply(Reply input) throws Exception;
	
	/**
	 * 대댓글 등록하기
	 * @param 대댓글테이블에 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addRereply(Rereply input) throws Exception;
	
	/**
	 * 댓글 삭제하기 (실제로 삭제하지 않고 컬럼값을 바꿔준다.)
	 * @param 댓글테이블에 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int editReply(Reply input) throws Exception;
	
	/**
	 * 대댓글 삭제하기
	 * @param 대댓글테이블에 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteRereply(Rereply input) throws Exception;
	
	/**
	 * 찜하기 등록하기
	 * @param 대댓글테이블에 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int addMembprod(Membprod input) throws Exception;
	
	/**
	 * 찜하기 삭제하기
	 * @param 대댓글테이블에 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int deleteMembprod(Membprod input) throws Exception;
	
	/**
	 * 데이터 수정하기
	 * @param Product 수정할 정보를 담고 있는 Beans 
	 * @return int
	 * @throws Exception
	 */
	public int editProduct(Product input) throws Exception;
}

