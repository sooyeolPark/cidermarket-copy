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
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.AdmProductService;
import study.shop.cidermarket.service.ProductService;

@Controller
public class AdmProductAjaxController {
    /** WebHelper 주입 */
    // -> import org.springframework.beans.factory.annotation.Autowired;
    @Autowired WebHelper webHelper;
    
    /** RegexHelper 주입 */
    @Autowired RegexHelper regexHelper;
    
    /** Service 패턴 구현체 주입 */
    @Qualifier("productService")
    @Autowired ProductService productService;
    
    @Qualifier("AdmProductService")
    @Autowired AdmProductService admProductService;

    
    /** 목록 페이지 */
    @RequestMapping(value = "/admin/product_adm.cider", method = RequestMethod.GET)
    public ModelAndView list(Model model,
    	@RequestParam(value="orderby", defaultValue="default") String orderby,
        @RequestParam(value="keyword", required=false) String keyword,
        @RequestParam(value="listCount", defaultValue="10") int listCount,
        @RequestParam(value="page", defaultValue="1") int nowPage) {
     
  
    	 /** 1) 페이지 구현에 필요한 변수값 생성 */
        int totalCount = 0;              // 전체 게시글 수
        int pageCount  = 5;         // 한 그룹당 표시할 페이지 번호 수
        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Product input = new Product();
        input.setSubject(keyword);
        List<Product> output = null;   // 조회결과가 저장될 객체
        PageData pageData = null;        // 페이지 번호를 계산한 결과가 저장될 객체

        try {
            // 전체 게시글 수 조회
            totalCount = admProductService.getProductCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Product.setOffset(pageData.getOffset());
            Product.setListCount(pageData.getListCount());
            
            // orderby에 때라서 데이터 조회하기
            switch (orderby) {
            case "default":
         	   output = admProductService.getProductList(input);
         	   break;
            case "payAsc":
         	   output = admProductService.getPriceAsc(input);
         	   break;        	   
            case "payDesc":
         	   output = admProductService.getPriceDesc(input);
         	   break;
         	   

            case "J": //직택배
               totalCount = admProductService.getHowJCount(input);
               pageData = new PageData(nowPage, totalCount, listCount, pageCount);

               // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
               Product.setOffset(pageData.getOffset());
               Product.setListCount(pageData.getListCount());
         	   output = admProductService.getHowJ(input);
         	   break;
            case "T": //택배 
            	totalCount = admProductService.getHowTCount(input);
                pageData = new PageData(nowPage, totalCount, listCount, pageCount);

                // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
                Product.setOffset(pageData.getOffset());
                Product.setListCount(pageData.getListCount());
         	   output = admProductService.getHowT(input);
         	   break;
            case "tradeconJ": //판매중 
            	totalCount = admProductService.getTradeconJCount(input);
                pageData = new PageData(nowPage, totalCount, listCount, pageCount);

                // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
                Product.setOffset(pageData.getOffset());
                Product.setListCount(pageData.getListCount());
         	   output = admProductService.getTradeconJ(input);
         	   break;
            case "tradeconW": //판매완료 
            	totalCount = admProductService.getTradeconWCount(input);
                pageData = new PageData(nowPage, totalCount, listCount, pageCount);

                // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
                Product.setOffset(pageData.getOffset());
                Product.setListCount(pageData.getListCount());
         	   output = admProductService.getTradeconW(input);
         	   break;  

            }
         } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
         }

        /** 3) View 처리 */
        model.addAttribute("keyword", keyword);
        model.addAttribute("output", output);
        model.addAttribute("orderby", orderby);
        model.addAttribute("pageData", pageData);

        return new ModelAndView("admin/product_adm");
    }
    
    
}

    


