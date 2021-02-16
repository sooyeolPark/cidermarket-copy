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
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.service.MsgboxService;

@Controller
public class RStoreMsgboxAjaxContorller {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("RStoreMsgboxService")
   MsgboxService msgboxService;

   /** 목록 페이지 */
   @RequestMapping(value="/msgbox/store_receiver.cider", method=RequestMethod.GET)
   public ModelAndView list(Model model,
         @RequestParam(value="membno", defaultValue="3") int membno,
         // 페이지 구현에서 사용할 현재 페이지 번호
         @RequestParam(value="page", defaultValue="1") int nowPage) {
      
      /** 1) 페이지 구현에 필요한 변수값 생성 */
      int totalCount = 0;      // 전체 게시글 수
      int listCount = 10;      // 한 페이지당 표시할 목록 수
      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
      
      /** 2) 데이터 조회하기 */
   // recevier로서 보관한 데이터 부터 불러오기
      Msgbox input = new Msgbox();
      input.setReceiver(membno);
      
      List<Msgbox> output = null;
      PageData pageData = null;
      
      try {
         // 전체 게시글 수 조회
         totalCount = msgboxService.getMsgboxCount(input);
         // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
         pageData = new PageData(nowPage, totalCount, listCount, pageCount);
         
         // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
         Msgbox.setOffset(pageData.getOffset());
         Msgbox.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = msgboxService.getMsgboxList(input);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      model.addAttribute("output", output);
      model.addAttribute("pageData", pageData);
      
      return new ModelAndView("user/msgbox_store_receiver");
   }
}