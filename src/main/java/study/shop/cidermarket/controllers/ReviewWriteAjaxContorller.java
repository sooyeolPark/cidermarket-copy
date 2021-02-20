package study.shop.cidermarket.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Bbs;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Review;
import study.shop.cidermarket.service.ItemListService;
import study.shop.cidermarket.service.ProductService;
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
   
   
   /** 상세 페이지 */
   @RequestMapping(value="/review_write.cider", method=RequestMethod.GET)
   public ModelAndView list(Model model,
		   // 검색어
	         @RequestParam(value="keyword", required=false) String keyword,
	         @RequestParam(value="prodno", defaultValue="5004" ) int prodno) {
	   if (prodno == 0) {
           return webHelper.redirect(null, "상품번호가 없습니다.");
       }

		  
 
      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
	      Product input = new Product();
	      input.setProdno(prodno);
	      
	      Product output = null;
      
   
      
      try {
    	  // 전체 게시글 수 조회
          // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
          
          // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장

         // 데이터 조회하기
         output = productService.getProductItem(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      

      /** 3) View 처리 */
      model.addAttribute("keyword", keyword);
      model.addAttribute("output", output);
      
      return new ModelAndView("user/review_write");
   }
 
  
 
 
}