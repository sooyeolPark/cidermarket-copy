package study.shop.cidermarket.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.service.BbsService;
import study.shop.cidermarket.service.FilesService;
import study.shop.cidermarket.service.MemberService;

@Controller
public class InquiryAjaxContorller {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("bbsInquiryService")
   BbsService bbsInquiryService;
   
   @Autowired
   @Qualifier("memberService")
   MemberService memberService;
   
   @Autowired
   @Qualifier("filesBbsService")
   FilesService filesBbsService;
   
   
   /** 목록 페이지 */
   @RequestMapping(value="/help/inquiry_list.cider", method=RequestMethod.GET)
   public ModelAndView list(Model model,
         @RequestParam(value="membno", defaultValue="0") int membno,
         // 페이지 구현에서 사용할 현재 페이지 번호
         @RequestParam(value="page", defaultValue="1") int nowPage) {
      
      /** 1) 페이지 구현에 필요한 변수값 생성 */
      int totalCount = 0;      // 전체 게시글 수
      int listCount = 10;      // 한 페이지당 표시할 목록 수
      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
      Bbs input = new Bbs();
      input.setMembno(membno);
      
      List<Bbs> output = null;
      PageData pageData = null;
      
      try {
         // 전체 게시글 수 조회
         totalCount = bbsInquiryService.getBbsCount(input);
         // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
         pageData = new PageData(nowPage, totalCount, listCount, pageCount);
         
         // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
         Bbs.setOffset(pageData.getOffset());
         Bbs.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = bbsInquiryService.getBbsList(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
      
      return new ModelAndView("user/inquiry_list");
   }
   
   /** 상세 페이지 */
   @RequestMapping(value="/help/inquiry_view.cider", method=RequestMethod.GET)
   public ModelAndView view(Model model,
         @RequestParam(value="bbsno", defaultValue="0") int bbsno) {
      
      /** 1) 유효성 검사 */
      if(bbsno == 0) {
         return webHelper.redirect(null, "글이 없습니다.");
      }
      
      /** 2) 데이터 조회하기 */
      // 데이터 조회에 필요한 조건값을 Beans에 저장하기
      Bbs input = new Bbs();
      input.setBbsno(bbsno);
      Files f = new Files();
      f.setRefid(bbsno);
      
      // 조회 결과를 저장할 객체 선언
      Bbs output = null;
      List<Files> files = null;
      try {
         // 데이터 조회
         output = bbsInquiryService.getBbsItem(input);
         // 파일 조회
         files = filesBbsService.getRefFilesList(f);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      model.addAttribute("output", output);
      model.addAttribute("files", files);
      return new ModelAndView("user/inquiry_view");
      
   }
   
   /** 작성 폼 페이지 */
   @RequestMapping(value="/help/inquiry_write.cider", method=RequestMethod.GET)
   public ModelAndView add(Model model, HttpServletRequest request) {
	   
	  HttpSession session = request.getSession();
	  int myNum = (int)session.getAttribute("myNum");
	  
	  Member input = new Member();
	  input.setMembno(myNum);
	  Member output = null;
	  
	  try {
		output = memberService.getMemberIndexItem(input);
	} catch (Exception e) {
		return webHelper.redirect(null, e.getLocalizedMessage());
	}
	  
	  model.addAttribute("output", output);
      return new ModelAndView("user/inquiry");
   }
}