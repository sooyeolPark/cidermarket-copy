package study.shop.cidermarket.service;

import java.util.List;


import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Membprod;
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.model.Reply;
import study.shop.cidermarket.model.Rereply;
import study.shop.cidermarket.model.Review;
import study.shop.cidermarket.model.Singo;

public interface DeleteMemberService {

	/**
	 * 탈퇴신청한지 3개월이 지난 member 데이터 목록 조회
	 * @param Member 검색 결과를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Member> getOutmemberList(Member input) throws Exception;
	
	/**
	 * File테이블의 테이블 삭제
	 * @param 삭제 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int deleteFile(Files input) throws Exception;
	
	/**
	 * Membprod 테이블(찜하기) 테이블 데이터 삭제
	 * @param 삭제 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int deleteMembprod(Membprod input) throws Exception;
	
	/**
	 * 메시지박스에서 sender를 더미데이터로 바꿔주기
	 * @param 업데이트 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int updateSender(Msgbox input) throws Exception;
	
	/**
	 * 메시지박스에서 receiver를 더미데이터로 바꿔주기
	 * @param 업데이트 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int updateReceiver(Msgbox input) throws Exception;
	
	/**
	 * record 테이블에서 buyer를 대표더미데이터로 변경
	 * @param update 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int updateRecord(Record input) throws Exception;
	
	/**
	 * reply 테이블에서 writer를 대표더미데이터로 변경
	 * @param update 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int updateReply(Reply input) throws Exception;
	
	/**
	 * rereply 테이블에서 writer를 대표더미데이터로 변경
	 * @param update 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int updateRereply(Rereply input) throws Exception;
	
	/**
	 * review 테이블에서 sender를 대표더미데이터로 변경
	 * @param update 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int updateReviewSender(Review input) throws Exception;
	
	/**
	 * review 테이블에서 Receiver를 삭제
	 * @param delete 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int deleteReviewReceiver(Review input) throws Exception;
	
	/**
	 * Singo 테이블에서 membno를 대표더미데이터로 변경
	 * @param update 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int updateSingo(Singo input) throws Exception;
	
	/**
	 * Member 테이블에서 삭제
	 * @param delete 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public int deleteMember(Member input) throws Exception;
}
