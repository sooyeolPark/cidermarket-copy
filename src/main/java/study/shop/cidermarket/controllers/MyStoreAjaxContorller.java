package study.shop.cidermarket.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.service.ProductService;

@Slf4j
@Controller
public class MyStoreAjaxContorller {
   /** WebHelper 주입 */
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("memberService")
   MemberService memberService;
   
   @Autowired
   @Qualifier("productService")
   ProductService productService;
   
   /** 목록 페이지 */
   @RequestMapping(value="/mystore.cider", method=RequestMethod.GET)
   public ModelAndView get_mystore(Model model,
		// 검색어
		@RequestParam(value="smallKeyword1", required=false) String smallKeyword1,
		@RequestParam(value="smallKeyword2", required=false) String smallKeyword2,
		@RequestParam(value="smallKeyword3", required=false) String smallKeyword3,
		// 페이지 구현에서 사용할 현재 페이지 번호
		@RequestParam(value="page1", defaultValue="1") int nowPage1,
		@RequestParam(value="page2", defaultValue="1") int nowPage2,
		@RequestParam(value="page3", defaultValue="1") int nowPage3) {
	   
	   /** 1) 로그인 된 회원아이디 가져오기 */
	   HttpSession session = webHelper.getRequest().getSession();
	   int myNum = (int) session.getAttribute("myNum");
       
	   /** 2) 페이지 구현에 필요한 변수값 생성 */
	   int totalCount1 = 0;		// 전체 게시글 수
	   int totalCount2 = 0;		// 전체 게시글 수
	   int totalCount3 = 0;		// 전체 게시글 수
	   int listCount1 = 4;		// 한 페이지당 표시할 목록 수
	   int listCount2 = 4;		// 한 페이지당 표시할 목록 수
	   int listCount3 = 4;		// 한 페이지당 표시할 목록 수
	   int pageCount1 = 5;		// 한 그룹당 표시할 페이지 번호 수
	   int pageCount2 = 5;		// 한 그룹당 표시할 페이지 번호 수
	   int pageCount3 = 5;		// 한 그룹당 표시할 페이지 번호 수
	   
	   /** 2) 데이터 조회 */
	   Member input = new Member();
	   input.setMembno(myNum);
	   
	   Product pro1 = new Product();
	   Product pro2 = new Product();
	   Product pro3 = new Product();
	   pro1.setSeller(myNum);
	   pro1.setSubject(smallKeyword1);
	   pro1.setTradecon("J");
	   pro2.setSeller(myNum);
	   pro2.setSubject(smallKeyword2);
	   pro2.setTradecon("S");
	   pro3.setSeller(myNum);
	   pro3.setSubject(smallKeyword3);
	   pro3.setTradecon("MP");
		
	   Member output = null;
	   List<Product> product1 = null;
	   List<Product> product2 = null;
	   List<Product> product3 = null;
	   PageData pageData1 = null;
	   PageData pageData2 = null;
	   PageData pageData3 = null;
       try {
           // 멤버 데이터 조회
           output = memberService.getMemberIndexItem(input);
           
           // 전체 상품 수 조회
		   totalCount1 = productService.getMemberProductCount(pro1);
		   totalCount2 = productService.getMemberProductCount(pro2);
		   totalCount3 = productService.getMemberProductCount(pro3);
		   // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
		   pageData1 = new PageData(nowPage1, totalCount1, listCount1, pageCount1);
		   pageData2 = new PageData(nowPage2, totalCount2, listCount2, pageCount2);
		   pageData3 = new PageData(nowPage3, totalCount3, listCount3, pageCount3);
		   
		   // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
		   Product.setOffset(pageData1.getOffset());
		   Product.setOffset(pageData2.getOffset());
		   Product.setOffset(pageData3.getOffset());
		   Product.setListCount(pageData1.getListCount());
		   Product.setListCount(pageData2.getListCount());
		   Product.setListCount(pageData3.getListCount());
           // 데이터 조회
           product1 = productService.getMemberProductList(pro1);
           product2 = productService.getMemberProductList(pro2);
           product3 = productService.getMemberProductList(pro3);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 모델 객체에 담기
       model.addAttribute("output", output);
       model.addAttribute("pageData1", pageData1);
       model.addAttribute("pageData2", pageData2);
       model.addAttribute("pageData3", pageData3);
       model.addAttribute("product1", product1);
       model.addAttribute("product2", product2);
       model.addAttribute("product3", product3);
       
       return new ModelAndView("user/mystore");
   }
 
}