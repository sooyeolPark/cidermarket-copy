package study.shop.cidermarket.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.service.ProductService;
import study.shop.cidermarket.service.RecordService;
import study.shop.cidermarket.service.ReviewService;

@Controller
public class ReviewWriteAjaxContorller {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired 
   @Qualifier("reviewWriteService")
   ReviewService reviewService;  
   
   @Autowired 
   @Qualifier("productService")
   ProductService productService;
   
   @Autowired
   @Qualifier("recordService")
   RecordService recordService;
   
   
   /** 상세 페이지 */
   @RequestMapping(value="/review_write.cider/", method=RequestMethod.GET)
   public ModelAndView list(Model model,
	         @RequestParam(value="recono", defaultValue="0" ) int recono) {
	   
	   if (recono == 0) {
           return webHelper.redirect(null, "거래 내역이 없습니다.");
       }

      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
      Record input = new Record();
      input.setRecono(recono);
   
      Record output = null;
      
      try {
         // 데이터 조회하기
    	 output = recordService.getRecordItem(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }

      /** 3) View 처리 */
      model.addAttribute("output", output);
      
      return new ModelAndView("user/review_write");
   }
 
  
 
 
}