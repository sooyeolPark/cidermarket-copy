package study.shop.cidermarket.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.service.RecordService;

@Controller
public class MyGradeAjaxContorller {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("recordService")
   RecordService recordService;
   //
   /** 목록 페이지 */
   @RequestMapping(value="/mystore_mygrade.cider", method=RequestMethod.GET)
   public ModelAndView get_list(Model model) {
  
       /** 2) 데이터 조회하기 */
	   
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
       
	   
	   
       //이미지 파일 경로 불러오기
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       
		//판매갯수 불러오기 
		Record input_01 = new Record();
       input_01.setSeller(myNum);

       // 조회결과를 저장할 객체 선언
       int output_sell = 0;

       try {
           // 데이터 조회
           output_sell = recordService.getRecordSellEndCount(input_01);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       //구매 갯수 불러오기 
		Record input_02 = new Record();
	       input_02.setBuyer(myNum);

	       // 조회결과를 저장할 객체 선언
	       int output_buy = 0;

	       try {
	           // 데이터 조회
	           output_buy = recordService.getRecordSellEndCount(input_02);
	       } catch (Exception e) {
	           return webHelper.redirect(null, e.getLocalizedMessage());
	       }
	       
       
       
       
       // 모델 객체에 담기
       model.addAttribute("output_sell", output_sell);
       model.addAttribute("output_buy", output_buy);
 
	
      return new ModelAndView("user/mystore_mygrade");
   }
 
}