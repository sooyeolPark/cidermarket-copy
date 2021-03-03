package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.service.ItemIndexService;
import study.shop.cidermarket.service.MyInfoService;

@Controller
public class MyInfoAjaxController {
    /** WebHelper 주입 */
    // -> import org.springframework.beans.factory.annotation.Autowired;
    @Autowired WebHelper webHelper;
    
    /** RegexHelper 주입 */
    @Autowired RegexHelper regexHelper;
    
    /** Service 패턴 구현체 주입 */
    @Qualifier("MyInfoService")
    @Autowired MyInfoService myInfoService;
    /** Service 패턴 구현체 주입 */
    @Autowired
    @Qualifier("itemindexService")
    ItemIndexService itemindexService;
    

    
    /** 목록 페이지 */
    @RequestMapping(value = "/mystore/{shopaddress}/myinfo.cider", method = RequestMethod.GET)
    public ModelAndView list(Model model,
    		@PathVariable("shopaddress") String shopaddress) {
        
    	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
    	
		   //파일 이미지 가져오기 
	       Files input_01 = new Files();
	       input_01.setRefid(myNum);
	       input_01.setReftable("member");

	       // 조회결과를 저장할 객체 선언
			
			  Files output_01 = null;
			  
			  	try { // 데이터 조회 output_01 =
			  output_01= itemindexService.getFilesMemberListItem(input_01); } catch (Exception e) {
			  return webHelper.redirect(null, e.getLocalizedMessage()); }
			 

        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Member input = new Member();
        input.setMembno(myNum);

        Member output = null;   // 조회결과가 저장될 객체
 

        try {
  
            output = myInfoService.getMemberItem(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3) View 처리 */
        model.addAttribute("user", output);
        model.addAttribute("output", output);
		 model.addAttribute("output_01", output_01); 
        return new ModelAndView("user/mystore_myinfo");
    }
    

    
   


    

}
