package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.service.MemberService;

@Slf4j
@RestController
public class AdmHomeRestController {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Qualifier("memberService")
   @Autowired MemberService memberService;
   
   /** 로그인 페이지 */
   @RequestMapping(value="/admin/login.cider", method=RequestMethod.POST)
   public Map<String, Object> login(HttpServletRequest request,
		   @RequestParam(value="email", defaultValue="") String email,
		   @RequestParam(value="password", defaultValue="") String password,
		   @RequestParam(value="idStateful", defaultValue="") String idStateful) {
	   
	   
	   	/** 1) request 객체를 사용해서 세션 객체 만들기 */
	   	HttpSession session = request.getSession();
   	
	   /** 멤버 데이터 조회하기 */
	   Member input = new Member();
	   String admin = "admin@cidermarket.shop";
	   if (!email.equals(admin)) {
		   return webHelper.getJsonError("관리자 아이디가 존재하지 않습니다.");
	   } else {
		   input.setEmail(email);
		   input.setPassword(password);		   
	   }
	   // 조회할 객체 선언
	   Member output = null;
	   
	   log.debug("-------------------------로그인 상태유지 : " + idStateful + "------------------------");
	   
	   try {
		   output = memberService.getMemberItem(input);
		   /** 2) 세션 저장, 삭제 */
		   	if (!email.equals("")) {
		   		// 입력 내용이 있다면 세션 저장 처리
		   		session.setAttribute("myAdmId", email);
		   		session.setAttribute("myAdmNum", output.getMembno());		   		
		   		if (idStateful.equals("true")) {
		   			log.debug(idStateful+"---------------- 세션 유지시간 24시간 ---------------------");
		   			session.setMaxInactiveInterval(86400); // 24시간 유지
		   		} else {
		   			log.debug(idStateful+"---------------- 세션 유지시간 30분 ---------------------");
		   			session.setMaxInactiveInterval(1800); // 30분간 유지		   			
		   		}
		   	} else {
		   		// 입력 내용이 없다면 세션 삭제
		   		session.removeAttribute("myAdmId");
		   		session.removeAttribute("myAdmNum");
		   	}
	   } catch (Exception e) {
		   return webHelper.getJsonError(e.getLocalizedMessage());
	   }
	   
	   /** 3) View 처리 */
       Map<String, Object> data = new HashMap<String, Object>();
       data.put("item", output);
      
       return webHelper.getJsonData(data);
   }
   
   /** 로그아웃 페이지 */
   @RequestMapping(value="/admin/logout.cider", method=RequestMethod.GET)
   public Map<String, Object> logout(HttpSession session) {
	   session.invalidate();
	   return webHelper.getJsonData();
   }
   
   
}