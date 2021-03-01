package study.shop.cidermarket.scheduler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Membprod;
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.service.DeleteMemberService;
import study.shop.cidermarket.service.DeleteMsgboxService;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.model.Reply;
import study.shop.cidermarket.model.Rereply;
import study.shop.cidermarket.model.Review;
import study.shop.cidermarket.model.Singo;

@Slf4j
@Controller
public class DeleteScheduler {
    /** WebHelper 주입 */
    // -> import org.springframework.beans.factory.annotation.Autowired;
    @Autowired WebHelper webHelper;
    
    /** RegexHelper 주입 */
    @Autowired RegexHelper regexHelper;
    
    /** Service 패턴 구현체 주입 */
    @Autowired
    @Qualifier("deletememberService")
	DeleteMemberService deletememberService;
    
    /** Service 패턴 구현체 주입 */
    @Autowired
    @Qualifier("deletemsgboxService")
    DeleteMsgboxService deletemsgboxService;
	
    public void deleteOutmember() {
    	List<Member> output = new ArrayList<Member>();
    	try {
			output = deletememberService.getOutmemberList(null);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	if(output!=null) {
    		for(int i=0; i<output.size(); i++) {
    			//1)파일 삭제
    			Files input_01 = new Files();
    			input_01.setRefid(output.get(i).getMembno());
    			input_01.setReftable("member");
    			try {
					deletememberService.deleteFile(input_01);
				} catch (Exception e) {
					e.printStackTrace();
				}
    			
    			//2)찜테이블 테이터 삭제
    			Membprod input_02 = new Membprod();
    			input_02.setMembno(output.get(i).getMembno());
    			
    			try {
					deletememberService.deleteMembprod(input_02);
				} catch (Exception e) {
					e.printStackTrace();
				}
    			
    			//3) Msgbox의 sender 더미데이터로 고치기
    			Msgbox input_03 = new Msgbox();
    			input_03.setSender(output.get(i).getMembno());
    			
    			try {
					deletememberService.updateSender(input_03);
				} catch (Exception e) {
					e.printStackTrace();
				}
    			
    			//4) Msgbox의 sender 더미데이터로 고치기
    			Msgbox input_04 = new Msgbox();
    			input_04.setReceiver(output.get(i).getMembno());
    			
    			try {
					deletememberService.updateReceiver(input_04);
				} catch (Exception e) {
					e.printStackTrace();
				}
    			
    			//5) Record에 buyer 더미데이터로 고치기
    			Record input_05 = new Record();
    			input_05.setBuyer(output.get(i).getMembno());
    			
    			try {
					deletememberService.updateRecord(input_05);
				} catch (Exception e) {
					e.printStackTrace();
				}
    			
    			//6) Reply에 Writer를 더미데이터로 고치기
    			Reply input_06 = new Reply();
    			input_06.setWriter(output.get(i).getMembno());
    			
    			try {
					deletememberService.updateReply(input_06);
				} catch (Exception e) {
					e.printStackTrace();
				}
    			
    			//7) Rereply에 Writer를 더미데이터로 고치기
    			Rereply input_07 = new Rereply();
    			input_07.setWriter(output.get(i).getMembno());
    			
    			try {
					deletememberService.updateRereply(input_07);
				} catch (Exception e) {
					e.printStackTrace();
				}
    			
    			//8) Review sender에 더미데이터로 고치기
    			Review input_08 = new Review();
    			input_08.setSender(output.get(i).getMembno());
    			
    			try {
					deletememberService.updateReviewSender(input_08);
				} catch (Exception e) {
					e.printStackTrace();
				}
    			
    			//9) Review receiver를 삭제
    			Review input_09 = new Review();
    			input_09.setReceiver(output.get(i).getMembno());
    			
    			try {
					deletememberService.deleteReviewReceiver(input_09);
				} catch (Exception e) {
					e.printStackTrace();
				}
    			
    			//10) Singo membno을 더미데이터로 고치기
    			Singo input_10 = new Singo();
    			input_10.setMembno(output.get(i).getMembno());
    			
    			try {
					deletememberService.updateSingo(input_10);
				} catch (Exception e) {
					e.printStackTrace();
				}
    			
    			//11) 마지막으로 멤버 테이블에서 삭제
    			Member input_11 = new Member();
    			input_11.setMembno(output.get(i).getMembno());
    			
    			try {
					deletememberService.deleteMember(input_11);
					log.debug("membno["+output.get(i).getMembno()+"] >>>>>> 데이터 삭제 완료");
				} catch (Exception e) {
					e.printStackTrace();
				}
    		}
    		
    	} else {
    		log.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>삭제할 회원 없음<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    	}
    }
    public void deleteMsgbox() {
    	int result = 0;
    	try {
			result = deletemsgboxService.deleteMsgbox();
			log.debug(">>>>>>>>>>>>>>>>>>>>>>[msgbox데이터]"+ result +"건 삭제 완료<<<<<<<<<<<<<<<<<<<<<<<<");
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    }
}
