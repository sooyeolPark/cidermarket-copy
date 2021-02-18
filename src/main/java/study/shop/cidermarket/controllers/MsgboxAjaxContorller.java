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

import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.service.MsgboxService;

@Controller
public class MsgboxAjaxContorller {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("SenderMsgboxService")
   MsgboxService smsgboxService;
   
   @Autowired
   @Qualifier("SStoreMsgboxService")
   MsgboxService sstmsgboxService;
   
   @Autowired
   @Qualifier("RStoreMsgboxService")
   MsgboxService rstmsgboxService;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("ReceiverMsgboxService")
   MsgboxService rmsgboxService;
   
   /**보낸 편지함 목록 페이지 */
   @RequestMapping(value="/msgbox/sender.cider", method=RequestMethod.GET)
   public ModelAndView list(Model model,
         @RequestParam(value="page", defaultValue="1") int nowPage) {
      
	   HttpSession session = webHelper.getRequest().getSession();
	   int myNum = (int)session.getAttribute("myNum");
	   
      /** 1) 페이지 구현에 필요한 변수값 생성 */
      int totalCount = 0;      // 전체 게시글 수
      int listCount = 10;      // 한 페이지당 표시할 목록 수
      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
      Msgbox input = new Msgbox();
      input.setSender(myNum);
      
      List<Msgbox> output = null;
      PageData pageData = null;
      
      try {
         // 전체 게시글 수 조회
         totalCount = smsgboxService.getMsgboxCount(input);
         // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
         pageData = new PageData(nowPage, totalCount, listCount, pageCount);
         
         // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
         Msgbox.setOffset(pageData.getOffset());
         Msgbox.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = smsgboxService.getMsgboxList(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
      
      return new ModelAndView("user/msgbox_sender");
   }
   
   /** 받은 편지함 목록 페이지 */
   @RequestMapping(value="/msgbox/receiver.cider", method=RequestMethod.GET)
   public ModelAndView list_r(Model model,
         @RequestParam(value="page", defaultValue="1") int nowPage) {
      
	   HttpSession session = webHelper.getRequest().getSession();
	   int myNum = (int)session.getAttribute("myNum");
	   
      /** 1) 페이지 구현에 필요한 변수값 생성 */
      int totalCount = 0;      // 전체 게시글 수
      int listCount = 10;      // 한 페이지당 표시할 목록 수
      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
      Msgbox input = new Msgbox();
      input.setReceiver(myNum);
      
      List<Msgbox> output = null;
      PageData pageData = null;
      
      try {
         // 전체 게시글 수 조회
         totalCount = rmsgboxService.getMsgboxCount(input);
         // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
         pageData = new PageData(nowPage, totalCount, listCount, pageCount);
         
         // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
         Msgbox.setOffset(pageData.getOffset());
         Msgbox.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = rmsgboxService.getMsgboxList(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
      
      return new ModelAndView("user/msgbox");
   }
   
   /** 보낸 쪽지 보관함 목록 페이지 */
   @RequestMapping(value="/msgbox/store_sender.cider", method=RequestMethod.GET)
   public ModelAndView list_sst(Model model,
         @RequestParam(value="page", defaultValue="1") int nowPage) {
      
	   HttpSession session = webHelper.getRequest().getSession();
	   int myNum = (int)session.getAttribute("myNum");
	   
      /** 1) 페이지 구현에 필요한 변수값 생성 */
      int totalCount = 0;      // 전체 게시글 수
      int listCount = 10;      // 한 페이지당 표시할 목록 수
      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
      
      /** 2) 데이터 조회하기 */
   // Sender로서 보관한 데이터 부터 불러오기
      Msgbox input = new Msgbox();
      input.setSender(myNum);
      
      List<Msgbox> output = null;
      PageData pageData = null;
      
      try {
         // 전체 게시글 수 조회
         totalCount = sstmsgboxService.getMsgboxCount(input);
         // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
         pageData = new PageData(nowPage, totalCount, listCount, pageCount);
         
         // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
         Msgbox.setOffset(pageData.getOffset());
         Msgbox.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = sstmsgboxService.getMsgboxList(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
      
      return new ModelAndView("user/msgbox_store_sender");
   }
   
   /** 받은 쪽지 보관함 목록 페이지 */
   @RequestMapping(value="/msgbox/store_receiver.cider", method=RequestMethod.GET)
   public ModelAndView list_rst(Model model,
         @RequestParam(value="page", defaultValue="1") int nowPage) {
      
	   HttpSession session = webHelper.getRequest().getSession();
	   int myNum = (int)session.getAttribute("myNum");
	   
      /** 1) 페이지 구현에 필요한 변수값 생성 */
      int totalCount = 0;      // 전체 게시글 수
      int listCount = 10;      // 한 페이지당 표시할 목록 수
      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
      
      /** 2) 데이터 조회하기 */
   // recevier로서 보관한 데이터 부터 불러오기
      Msgbox input = new Msgbox();
      input.setReceiver(myNum);
      
      List<Msgbox> output = null;
      PageData pageData = null;
      
      try {
         // 전체 게시글 수 조회
         totalCount = rstmsgboxService.getMsgboxCount(input);
         // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
         pageData = new PageData(nowPage, totalCount, listCount, pageCount);
         
         // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
         Msgbox.setOffset(pageData.getOffset());
         Msgbox.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = rstmsgboxService.getMsgboxList(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
      
      return new ModelAndView("user/msgbox_store_receiver");
   }
}