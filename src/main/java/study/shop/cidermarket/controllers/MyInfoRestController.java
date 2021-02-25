package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.service.MyInfoService;

@Slf4j
@RestController
public class MyInfoRestController {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Qualifier("MyInfoService")
   @Autowired MyInfoService myInfoService;
   

 
 //------------ID 변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_id", method=RequestMethod.PUT)
   public Map<String, Object> id(Model model,
   		@RequestParam(value="nickname", defaultValue="") String nickname) {
   	
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setNickname(nickname);
   	
   	Member output = null;
   	
   	try {
   			// 일치하는 데이터 조회
			int result = myInfoService.getMemberCount(input);
			if (result == 1) {
				return webHelper.getJsonError("이미 등록된 아이디 입니다.");
			} 
		myInfoService.editNickName(input);
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   
   //------------Intro 변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_intro", method=RequestMethod.PUT)
   public Map<String, Object> intro(Model model,
   		@RequestParam(value="intro", defaultValue="") String intro) {
   	
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setIntro(intro);
   	
   	Member output = null;
   	
   	try {

		myInfoService.editIntro(input);
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }

   //------------shopaddress 변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_shopaddress", method=RequestMethod.PUT)
   public Map<String, Object> shopaddress(Model model,
   		@RequestParam(value="shopaddress", defaultValue="") String shopaddress) {
   	
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setShopaddress(shopaddress);
   	
   	Member output = null;
   	
   	try {
			// 일치하는 데이터 조회
		int result = myInfoService.getShopaddressCount(input);
		if (result == 1) {
			return webHelper.getJsonError("이미 등록된 주소 입니다.");
		} 

		myInfoService.editShopaddress(input);
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   
   //-----------email 변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_email", method=RequestMethod.PUT)
   public Map<String, Object> email(Model model,
   		@RequestParam(value="email", defaultValue="") String email) {
   	
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setEmail(email);
   	
   	Member output = null;
   	
   	try {
			// 일치하는 데이터 조회
		int result = myInfoService.getEmailCount(input);
		if (result == 1) {
			return webHelper.getJsonError("이미 등록된 이메일 입니다.");
		} 

		myInfoService.editEmail(input);
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   //------------Tel 변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_tel", method=RequestMethod.PUT)
   public Map<String, Object> tel(Model model,
   		@RequestParam(value="tel", defaultValue="") String tel) {
   	
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setTel(tel);
   	
   	Member output = null;
   	
   	try {
			// 일치하는 데이터 조회
		int result = myInfoService.getTelCount(input);
		if (result == 1) {
			return webHelper.getJsonError("이미 등록된 번호 입니다.");
		} 

		myInfoService.editTel(input);
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   
   
   
   
   //------------Password변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_password", method=RequestMethod.PUT)
   public Map<String, Object> password(Model model,
   		@RequestParam(value="password", defaultValue="") String password,
	   @RequestParam(value="newpassword", defaultValue="") String newpassword) {
   	
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setPassword(password);
   	
   	
   	
   	Member output = null;
   	
   	try {
			// 일치하는 데이터 조회
		int result = myInfoService.getCheckPassword(input);
		if (result == 0) {
			return webHelper.getJsonError("비밀번호가 일치하지 않습니다.");
		} 
		else if( result == 1) {
			
		input.setPassword(newpassword);
		myInfoService.editPassword(input);
		output = myInfoService.getMemberItem(input);
			}
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   
   //------------SMS변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_SMS", method=RequestMethod.PUT)
   public Map<String, Object> sms(Model model,
	   @RequestParam(value="sms", defaultValue="") int[] sms) {
   	
	   

	   
	 //checkbox 에서 전달된 파라미터 배열 꺼내기 
	 //합계를 더해서 전달
	   int sumVal = 0;
		  for (int i=0; i<sms.length; i++){ 
			  sumVal += sms[i]; 
		  }
		  
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setSms(sumVal);
   	
   	
   	
   	Member output = null;
   	
   	try {

		myInfoService.editSMS(input);
		output = myInfoService.getMemberItem(input);
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   
   private int parseInt(String substring) {
	// TODO Auto-generated method stub
	return 0;
}

//-----------회원탈퇴페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_out", method=RequestMethod.PUT)
   public Map<String, Object> OUT(Model model,
   		@RequestParam(value="outmember", defaultValue="") String outmember) {
   	
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setOutmember(outmember);
   	
   	

   	
   	try {
			// 일치하는 데이터 조회		
		input.setOutmember(outmember);
		myInfoService.editOutmember(input);
			
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
	session.invalidate();
	return webHelper.getJsonData();
   }
}