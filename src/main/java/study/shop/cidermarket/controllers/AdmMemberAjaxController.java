package study.shop.cidermarket.controllers;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
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
import study.shop.cidermarket.service.AdmMemberService;

@Slf4j
@Controller
public class AdmMemberAjaxController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
	
	   /** Service 패턴 구현체 주입 */
	   @Autowired
	   @Qualifier("admmemberService")
	   AdmMemberService admmemberService;
    
    /** 관리자 회원관리 페이지 */
    @RequestMapping(value="/admin/member_adm.cider", method=RequestMethod.GET)
    public ModelAndView memberAdm(Model model,
    		@RequestParam(value="orderby", defaultValue="default") String orderby,
    		@RequestParam(value="page", defaultValue="1") int nowPage,
    		@RequestParam(value="search", defaultValue="") String search,
    		@RequestParam(value="listCount", defaultValue="10") int listCount) {
        /** 1) 페이지 구현에 필요한 변수값 생성 */
        int totalCount = 0;      // 전체 게시글 수
        int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
        
        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Member input = new Member();
        input.setOutmember("n");
        if(search!="" && search!=null) {
        	input.setEmail(search);
        }
        
        List<Member> output = null;
        PageData pageData = null;
        
        try {
           // 전체 게시글 수 조회
           totalCount = admmemberService.getMemberCount(input);
           // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
           pageData = new PageData(nowPage, totalCount, listCount, pageCount);
           
           // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
           Member.setOffset(pageData.getOffset());
           Member.setListCount(pageData.getListCount());

           // orderby에 때라서 데이터 조회하기
           switch (orderby) {
           case "default":
        	   output = admmemberService.getMemberList(input);
        	   break;
           case "amountAsc":
        	   output = admmemberService.getMemberListByAmountAsc(input);
        	   break;        	   
           case "amountDesc":
        	   output = admmemberService.getMemberListByAmountDesc(input);
        	   break;
           case "payAsc":
        	   output = admmemberService.getMemberListByPayAsc(input);
        	   break;
           case "payDesc":
        	   output = admmemberService.getMemberListByPayDesc(input);
        	   break;
           case "joinDesc":
        	   output = admmemberService.getMemberListByJoindateDesc(input);
        	   break;
           case "joinAsc":
        	   output = admmemberService.getMemberListByJoindateAsc(input);
        	   break;
           case "rateAsc":
        	   output = admmemberService.getMemberListByRateAsc(input);
        	   break; 	   
           case "rateDesc":
        	   output = admmemberService.getMemberListByRateDesc(input);
        	   break; 	   
           }
           
        } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
        }
        
        /** 3) View 처리 */
        model.addAttribute("search", search);
        model.addAttribute("orderby", orderby);
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);
    	return new ModelAndView("admin/member_adm");
    }
    
	/** 탈퇴회원관리 */
	@RequestMapping(value = "/admin/outmember_adm.cider", method = RequestMethod.GET)
	public ModelAndView outMemberAdm(Model model,
    		@RequestParam(value="orderby", defaultValue="default") String orderby,
    		@RequestParam(value="page", defaultValue="1") int nowPage,
    		@RequestParam(value="search", defaultValue="") String search,
    		@RequestParam(value="listCount", defaultValue="10") int listCount) {
        /** 1) 페이지 구현에 필요한 변수값 생성 */
        int totalCount = 0;      // 전체 게시글 수
        int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
        
        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Member input = new Member();
        input.setOutmember("a");
        if(search!="" && search!=null) {
        	input.setEmail(search);
        }
        
        List<Member> output = null;
        PageData pageData = null;
        
        try {
           // 전체 게시글 수 조회
           totalCount = admmemberService.getMemberCount(input);
           // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
           pageData = new PageData(nowPage, totalCount, listCount, pageCount);
           
           // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
           Member.setOffset(pageData.getOffset());
           Member.setListCount(pageData.getListCount());

           // orderby에 때라서 데이터 조회하기
           switch (orderby) {
           case "default":
        	   output = admmemberService.getMemberList(input);
        	   break;
           case "amountAsc":
        	   output = admmemberService.getMemberListByAmountAsc(input);
        	   break;        	   
           case "amountDesc":
        	   output = admmemberService.getMemberListByAmountDesc(input);
        	   break;
           case "payAsc":
        	   output = admmemberService.getMemberListByPayAsc(input);
        	   break;
           case "payDesc":
        	   output = admmemberService.getMemberListByPayDesc(input);
        	   break;
           case "joinDesc":
        	   output = admmemberService.getMemberListByJoindateDesc(input);
        	   break;
           case "joinAsc":
        	   output = admmemberService.getMemberListByJoindateAsc(input);
        	   break; 	   
           case "editAsc":
        	   output = admmemberService.getMemberListByEditdateAsc(input);
        	   break; 	   
           case "editDesc":
        	   output = admmemberService.getMemberListByEditdateDesc(input);
        	   break; 	   
           }
           
        } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
        }
        
        /** 3) View 처리 */
        model.addAttribute("search", search);
        model.addAttribute("orderby", orderby);
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);
    	return new ModelAndView("admin/outmember_adm");
	}
}
