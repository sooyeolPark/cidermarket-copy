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
import study.shop.cidermarket.service.ItemListService;
import study.shop.cidermarket.service.ProductService;

@Controller
public class ItemAjaxContorller {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("itemlistService")
   ItemListService itemListService;   
   
   
   
   /** 목록 페이지 */
   @RequestMapping(value="/item_list.cider", method=RequestMethod.GET)
   public ModelAndView list(Model model,
		   // 검색어
	         @RequestParam(value="keyword", required=false) String keyword,
	         // 페이지 구현에서 사용할 현재 페이지 번호
	         @RequestParam(value="page", defaultValue="1") int nowPage) {
	      
	      /** 1) 페이지 구현에 필요한 변수값 생성 */
	      int totalCount = 0;      // 전체 게시글 수
	      int listCount = 4;	   // 한 페이지당 표시할 목록 수
	      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
		  
 
      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
	      Product input = new Product();
	      input.setSubject(keyword);
	      
	      List<Product> output = null;
	      PageData pageData = null;
      
   
      
      try {
    	  // 전체 게시글 수 조회
          totalCount = itemListService.getItemListCount(input);
          // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
          pageData = new PageData(nowPage, totalCount, listCount, pageCount);
          
          // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
          Product.setOffset(pageData.getOffset());
          Product.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = itemListService.getItemListList(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      

      /** 3) View 처리 */
      model.addAttribute("keyword", keyword);
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
      
      return new ModelAndView("user/item_list");
   }
 
  
   //---------------------------------------------------------------------------------가격 오름차순으로 정렬
   @RequestMapping(value="/item_listAsc.cider", method=RequestMethod.GET)
   public ModelAndView listByPriceAsc(Model model,
		   // 검색어
	         @RequestParam(value="keyword", required=false) String keyword,
	         // 페이지 구현에서 사용할 현재 페이지 번호
	         @RequestParam(value="page", defaultValue="1") int nowPage) {
	      
	      /** 1) 페이지 구현에 필요한 변수값 생성 */
	      int totalCount = 0;      // 전체 게시글 수
	      int listCount = 4;	   // 한 페이지당 표시할 목록 수
	      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
		  
 
      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
	      Product input = new Product();
	      input.setSubject(keyword);
	      
	      List<Product> output = null;
	      PageData pageData = null;
      
   
      
      try {
    	  // 전체 게시글 수 조회
          totalCount = itemListService.getItemListCount(input);
          // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
          pageData = new PageData(nowPage, totalCount, listCount, pageCount);
          
          // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
          Product.setOffset(pageData.getOffset());
          Product.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = itemListService.selectListByPriceAsc(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      

      /** 3) View 처리 */
      model.addAttribute("keyword", keyword);
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
      
      return new ModelAndView("user/item_list");
   }
   
   
   //--------------------------------------------------------------------------------------가격 내림차순으로 정렬 
   @RequestMapping(value="/item_listDesc.cider", method=RequestMethod.GET)
   public ModelAndView listByPriceDesc(Model model,
		   // 검색어
	         @RequestParam(value="keyword", required=false) String keyword,
	         // 페이지 구현에서 사용할 현재 페이지 번호
	         @RequestParam(value="page", defaultValue="1") int nowPage) {
	      
	      /** 1) 페이지 구현에 필요한 변수값 생성 */
	      int totalCount = 0;      // 전체 게시글 수
	      int listCount = 4;	   // 한 페이지당 표시할 목록 수
	      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
		  
 
      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
	      Product input = new Product();
	      input.setSubject(keyword);
	      
	      List<Product> output = null;
	      PageData pageData = null;
      
   
      
      try {
    	  // 전체 게시글 수 조회
          totalCount = itemListService.getItemListCount(input);
          // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
          pageData = new PageData(nowPage, totalCount, listCount, pageCount);
          
          // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
          Product.setOffset(pageData.getOffset());
          Product.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = itemListService.selectListByPriceDesc(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      

      /** 3) View 처리 */
      model.addAttribute("keyword", keyword);
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
      
      return new ModelAndView("user/item_list");
   }
  
   
   //-------------------------------------------------------------------------------------------------날짜순정렬
   @RequestMapping(value="/item_listRegdate.cider", method=RequestMethod.GET)
   public ModelAndView listByRegdate(Model model,
		   // 검색어
	         @RequestParam(value="keyword", required=false) String keyword,
	         // 페이지 구현에서 사용할 현재 페이지 번호
	         @RequestParam(value="page", defaultValue="1") int nowPage) {
	      
	      /** 1) 페이지 구현에 필요한 변수값 생성 */
	      int totalCount = 0;      // 전체 게시글 수
	      int listCount = 4;	   // 한 페이지당 표시할 목록 수
	      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
		  
 
      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
	      Product input = new Product();
	      input.setSubject(keyword);
	      
	      List<Product> output = null;
	      PageData pageData = null;
      
   
      
      try {
    	  // 전체 게시글 수 조회
          totalCount = itemListService.getItemListCount(input);
          // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
          pageData = new PageData(nowPage, totalCount, listCount, pageCount);
          
          // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
          Product.setOffset(pageData.getOffset());
          Product.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = itemListService.selectListByRegdate(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      

      /** 3) View 처리 */
      model.addAttribute("keyword", keyword);
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
      
      return new ModelAndView("user/item_list");
   }
 
}