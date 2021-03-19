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
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.service.ProductService;
import study.shop.cidermarket.service.RecordService;

@Slf4j
@Controller
public class RecordAjaxController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	
	/** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("productService")
	ProductService productService;
	
	@Autowired
	@Qualifier("memberService")
    MemberService memberService;
	
	@Autowired
	@Qualifier("recordService")
	RecordService recordService;
    
    /** 거래내역 판매 - 거래중 페이지 */
    @RequestMapping(value="/member/record/selling.cider", method=RequestMethod.GET)
    public ModelAndView recordSellIng(Model model,
    		@RequestParam(value="page", defaultValue="1") int nowPage) {
    	
    	/** 세션에 저장된 아이디값 가져오기 */
		HttpSession session = webHelper.getRequest().getSession();
        int myNum = (int)session.getAttribute("myNum");
        
        /** 페이지 구현에 필요한 변수값 생성 */
        int totalCount = 0;      // 전체 게시글 수
        int listCount = 5;      // 한 페이지당 표시할 목록 수
        int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
        
        /** 가져온 값을 이용하여 거래내역 조회 */
        Record input = new Record();
        input.setSeller(myNum);
        // 조회할 객체 선언
        List<Record> output = null;
        PageData pageData = null;
        
        try {
        	// 전체 게시글 수 조회
            totalCount = recordService.getRecordSellIngCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);
            
            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Record.setOffset(pageData.getOffset());
            Record.setListCount(pageData.getListCount());
        	
        	// 데이터 조회하기
			output = recordService.getRecordSellIngList(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
    	
        /** View 처리 */
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);
        return new ModelAndView("user/record_sell_ing");
    }
    
    /** 거래내역 판매 - 거래완료 페이지 */
    @RequestMapping(value="/member/record/sellend.cider", method=RequestMethod.GET)
    public ModelAndView recordSellEnd(Model model,
    		@RequestParam(value="page", defaultValue="1") int nowPage) {
    	
    	/** 세션에 저장된 아이디값 가져오기 */
		HttpSession session = webHelper.getRequest().getSession();
        int myNum = (int)session.getAttribute("myNum");
        
        /** 페이지 구현에 필요한 변수값 생성 */
        int totalCount = 0;      // 전체 게시글 수
        int listCount = 5;      // 한 페이지당 표시할 목록 수
        int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
        
        /** 가져온 값을 이용하여 거래내역 조회 */
        Record input = new Record();
        input.setSeller(myNum);
        // 조회할 객체 선언
        List<Record> output = null;
        PageData pageData = null;
        
        try {
        	// 전체 게시글 수 조회
            totalCount = recordService.getRecordSellEndCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);
            
            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Record.setOffset(pageData.getOffset());
            Record.setListCount(pageData.getListCount());
        	
        	// 데이터 조회하기
			output = recordService.getRecordSellEndList(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
    	
        /** View 처리 */
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);
        return new ModelAndView("user/record_sell_end");
    }
   
    /** 거래내역 구매 - 거래중 페이지 */
    @RequestMapping(value="/member/record/buying.cider", method=RequestMethod.GET)
    public ModelAndView recordBuyIng(Model model,
    		@RequestParam(value="page", defaultValue="1") int nowPage) {
    	
    	/** 세션에 저장된 아이디값 가져오기 */
		HttpSession session = webHelper.getRequest().getSession();
        int myNum = (int)session.getAttribute("myNum");
        
        /** 페이지 구현에 필요한 변수값 생성 */
        int totalCount = 0;      // 전체 게시글 수
        int listCount = 5;      // 한 페이지당 표시할 목록 수
        int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
        
        /** 가져온 값을 이용하여 거래내역 조회 */
        Record input = new Record();
        input.setBuyer(myNum);
        // 조회할 객체 선언
        List<Record> output = null;
        PageData pageData = null;
        
        try {
        	// 전체 게시글 수 조회
            totalCount = recordService.getRecordBuyIngCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);
            
            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Record.setOffset(pageData.getOffset());
            Record.setListCount(pageData.getListCount());
        	
        	// 데이터 조회하기
			output = recordService.getRecordBuyIngList(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
    	
        /** View 처리 */
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);
    	
        return new ModelAndView("user/record_buy_ing");
    }
    
    
    /** 거래내역 판매 - 거래완료 페이지 */
    @RequestMapping(value="/member/record/buyend.cider", method=RequestMethod.GET)
    public ModelAndView recordBuyEnd(Model model,
    		@RequestParam(value="page", defaultValue="1") int nowPage) {
    	
    	/** 세션에 저장된 아이디값 가져오기 */
		HttpSession session = webHelper.getRequest().getSession();
        int myNum = (int)session.getAttribute("myNum");
        
        /** 페이지 구현에 필요한 변수값 생성 */
        int totalCount = 0;      // 전체 게시글 수
        int listCount = 5;      // 한 페이지당 표시할 목록 수
        int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
        
        /** 가져온 값을 이용하여 거래내역 조회 */
        Record input = new Record();
        input.setBuyer(myNum);
        // 조회할 객체 선언
        List<Record> output = null;
        PageData pageData = null;
        
        try {
        	// 전체 게시글 수 조회
            totalCount = recordService.getRecordBuyEndCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);
            
            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Record.setOffset(pageData.getOffset());
            Record.setListCount(pageData.getListCount());
        	
        	// 데이터 조회하기
			output = recordService.getRecordBuyEndList(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
    	
        /** View 처리 */
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);
        return new ModelAndView("user/record_buy_end");
    }
    
}
