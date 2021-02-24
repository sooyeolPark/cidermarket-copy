package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.service.AdmMemberService;

@Slf4j
@RestController
public class AdmMemberRestController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
	
	   /** Service 패턴 구현체 주입 */
	   @Autowired
	   @Qualifier("admmemberService")
	   AdmMemberService admmemberService;
    
    /** 관리자 회원관리 페이지 */
    @RequestMapping(value="/admin/member_adm", method=RequestMethod.PUT)
    public Map<String, Object> memberAdm(
    		@RequestParam(value="membno", defaultValue="default") int membno) {
        /** 1) 페이지 구현에 필요한 변수값 생성 */
        if (membno == 0) {
            return webHelper.getJsonWarning("선택된 회원 없습니다.");
        }
        
        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Member input = new Member();
        input.setMembno(membno);
        //탈퇴 처리이기 때문에 Outmember에다가 a를 기록
        input.setOutmember("a");
        	try {
                // 데이터 저장 --> 
                  admmemberService.editMember(input);

             } catch (Exception e) {
                return webHelper.getJsonError(e.getLocalizedMessage());
             }
               
             /** 3) 결과를 확인하기 위한 JSON 출력 */
             return webHelper.getJsonData();
          }
    
	/** 탈퇴회원관리 */
	@RequestMapping(value = "/admin/outmember_adm", method = RequestMethod.PUT)
	public Map<String, Object> outMemberAdm(
    		@RequestParam(value="membno", defaultValue="default") int membno) {
        /** 1) 페이지 구현에 필요한 변수값 생성 */
        if (membno == 0) {
            return webHelper.getJsonWarning("선택된 회원 없습니다.");
        }
        
        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Member input = new Member();
        input.setMembno(membno);
        //복구 처리이기 때문에 Outmember에다가 n를 기록
        input.setOutmember("n");
        	try {
                // 데이터 저장 --> 
                  admmemberService.editMember(input);

             } catch (Exception e) {
                return webHelper.getJsonError(e.getLocalizedMessage());
             }
               
             /** 3) 결과를 확인하기 위한 JSON 출력 */
             return webHelper.getJsonData();
          }
}
