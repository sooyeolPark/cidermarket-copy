package study.shop.cidermarket.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.service.AdmHomeService;

@Slf4j
@Controller
public class AdmHomeAjaxController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	
	   /** Service 패턴 구현체 주입 */
	   @Autowired
	   @Qualifier("admhomeService")
	   AdmHomeService admhomeService;
	   
	/** 관리자 메인 페이지 */
	@RequestMapping(value = "/admin/home_adm.cider", method = RequestMethod.GET)
	public ModelAndView homeAdm(Model model) {
		/** 1) 데이터 조회하기 */
		// 1)일별 거래건수
		List<Integer> recordByDay = new ArrayList<Integer>();
		int result = 0;
		//7일치 데이터 조회
		for(int i=0; i<7 ; i++) {
			Record temp = new Record();
			temp.setRecono(i);
			result = 0;
			try {
		           // 데이터 조회
		           result = admhomeService.getRecordCountByDay(temp);
		       } catch (Exception e) {
		           return webHelper.redirect(null, e.getLocalizedMessage());
		       }
			recordByDay.add(result);
		}
		
		// 2) 일주일 총 거래액 구하기
		String result_01 = null;
		try {
	           // 데이터 조회
	           result_01 = admhomeService.getTotalPayByWeek(null);
	       } catch (Exception e) {
	           return webHelper.redirect(null, e.getLocalizedMessage());
	       }
		
		//3) 전체 상품수 구하기
		int result_02 = 0;
		try {
	           // 데이터 조회
	           result_02 = admhomeService.getTotalProduct(null);
	       } catch (Exception e) {
	           return webHelper.redirect(null, e.getLocalizedMessage());
	       }		
		
		// 4) 전체 멤버수 구하기 (탈퇴 회원 제외)
		int result_03 = 0;
		Member input_01 = new  Member();
		input_01.setOutmember("N");
		try {
	           // 데이터 조회
	           result_03 = admhomeService.getTotalMember(input_01);
	       } catch (Exception e) {
	           return webHelper.redirect(null, e.getLocalizedMessage());
	       }	
		
		// 5) 일주일 가입 멤버 구하기
		List<Integer> joinmemberByDay = new ArrayList<Integer>();
		int result_temp = 0;
		//7일치 데이터 조회
		for(int i=0; i<7 ; i++) {
			Member temp = new Member();
			temp.setMembno(i);
			result_temp = 0;
			try {
		           // 데이터 조회
		           result_temp = admhomeService.getMemberByDay(temp);
		       } catch (Exception e) {
		           return webHelper.redirect(null, e.getLocalizedMessage());
		       }
			joinmemberByDay.add(result_temp);
		}
		
		/** 3) 데이터 담기 */
		model.addAttribute("recordbyday", recordByDay);
		model.addAttribute("totalpay", result_01);
		model.addAttribute("totalproduct", result_02);
		model.addAttribute("totalmember", result_03);
		model.addAttribute("memberbyday", joinmemberByDay);
		
		return new ModelAndView("admin/home_adm");
	}
	
	/** 관리자 로그인 페이지 */
    @RequestMapping(value="/admin/login_adm.cider", method=RequestMethod.GET)
    public ModelAndView loginAdm(Model model,
    		@RequestParam(value="email", defaultValue="") String email) {
    	
    	model.addAttribute("email", email);
        return new ModelAndView("admin/login_adm");
    }
	
	/** 일반문의 - 답변*/
	@RequestMapping(value = "/admin/question_reply_adm.cider", method = RequestMethod.GET)
	public String questionReplyAdm() {
		return "admin/question_reply_adm";
	}

	


}
