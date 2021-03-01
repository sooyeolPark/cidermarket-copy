package study.shop.cidermarket.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.model.Review;
import study.shop.cidermarket.service.ItemIndexService;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.service.RecordService;
import study.shop.cidermarket.service.ReviewService;

@Controller
public class ReviewAjaxContorller {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   ReviewService reviewService;   
   
   @Autowired
   @Qualifier("recordService")
   RecordService recordService;
   
   @Autowired
   @Qualifier("memberService")
   MemberService memberService;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("itemindexService")
   ItemIndexService itemindexService;
   
   
   
   /** 목록 페이지 */
   @RequestMapping(value="/mystore/{shopaddress}/review.cider", method=RequestMethod.GET)
   public ModelAndView list(Model model,
		     @PathVariable("shopaddress") String shopaddress,
		     // 검색어
	         @RequestParam(value="keyword", required=false) String keyword,
	         @RequestParam(value="prodno", defaultValue="0") int prodno,
	         @RequestParam(value="revino", defaultValue="0") int revino,
	         // 페이지 구현에서 사용할 현재 페이지 번호
	         @RequestParam(value="page", defaultValue="1") int nowPage) {
	      
	   
	      /** 1) 페이지 구현에 필요한 변수값 생성 */
	      int totalCount = 0;      // 전체 게시글 수
	      int listCount = 3;	   // 한 페이지당 표시할 목록 수
	      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
		  
	      
	       //이미지 파일 경로 불러오기
	       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
	       Files input_01 = new Files();
	       input_01.setRefid(revino);

	       // 조회결과를 저장할 객체 선언
	       List<Files> output_01 = null;

	       try {
	           // 데이터 조회
	           output_01 = itemindexService.getFilesListItem(input_01);
	       } catch (Exception e) {
	           return webHelper.redirect(null, e.getLocalizedMessage());
	       }
 
      
          /** 2) 데이터 조회하기 */
          // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
	      Member inputM = new Member();
	      inputM.setShopaddress(shopaddress);
	      Member outputM = null;
	      
	      try {
	    	  outputM = memberService.getMemberShopItem(inputM);
	    	  inputM.setMembno(outputM.getMembno());
	    	  outputM = memberService.getMemberIndexItem(inputM);
	      } catch (Exception e) {
	    	  return webHelper.redirect(null, e.getLocalizedMessage());
	      }
	      
	      Review input = new Review();
	      input.setReceiver(outputM.getMembno());
	      List<Review> output = null;
	      PageData pageData = null;
      
      try {
    	  // 전체 게시글 수 조회
          totalCount = reviewService.getReviewCount(input);
          // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
          pageData = new PageData(nowPage, totalCount, listCount, pageCount);
          
          // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
          Review.setOffset(pageData.getOffset());
          Review.setListCount(pageData.getListCount());

          // 데이터 조회하기
          output = reviewService.getReviewList(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      

      /** 3) View 처리 */
      model.addAttribute("user", outputM);
      model.addAttribute("keyword", keyword);
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
   
      
      return new ModelAndView("user/mystore_review");
   }
   
   
 
   // --------------------------------------------------------------------------Review_View 페이지 
   @RequestMapping(value="/review_view.cider", method=RequestMethod.GET)
   public ModelAndView list(Model model,
		   @RequestParam(value="revino", defaultValue="0") int revino,
		   @RequestParam(value="filepath", defaultValue="0") int filepath
		   ) {
	      
	   
	   //파일 이미지 가져오기 
       Files input_01 = new Files();
       input_01.setRefid(revino);

       // 조회결과를 저장할 객체 선언
       List<Files> output_01 = null;

       try {
           // 데이터 조회
           output_01 = itemindexService.getFilesListItem(input_01);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }

      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
	      Review input = new Review();
	      input.setRevino(revino);
			/* input.setReceiver(myNum); */
	      
	      Review output = null;

      try {

         // 데이터 조회하기
         output = reviewService.getReviewItem(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      

      /** 3) View 처리 */
      model.addAttribute("output", output);
      model.addAttribute("fileimages", output_01);
      
      return new ModelAndView("user/review_view");
   }
 
   /** 후기남기기 쓰기 페이지 */
	//---------------------------------------------------------------------------------------------	
	@RequestMapping(value = "/review_write.cider", method = RequestMethod.GET)
	public ModelAndView get_item(Model model,
			@RequestParam(value="recono", defaultValue="0") int recono,
			@RequestParam(value="buyer", defaultValue="0") int buyer) {
		
		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Record input = new Record();
	    input.setRecono(recono);
	    input.setBuyer(buyer);
	      
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