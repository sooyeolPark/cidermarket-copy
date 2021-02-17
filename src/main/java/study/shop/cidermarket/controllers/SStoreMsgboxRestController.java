package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.service.MsgboxService;

@RestController
public class SStoreMsgboxRestController {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("SStoreMsgboxService")
   MsgboxService msgboxService;
   
   /** 목록 페이지 */
   @RequestMapping(value="/msgbox/store_sender", method=RequestMethod.GET)
   public Map<String, Object> get_list(
         @RequestParam(value="membno", defaultValue="3") int membno,
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
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("item", output);
      data.put("meta", pageData);
      
      return webHelper.getJsonData(data);
   }
   
   /** Sender 사용자가 삭제버튼을 눌렀을 때 */
   @RequestMapping(value="/msgbox/store_sender", method=RequestMethod.PUT)
   public Map<String, Object> put_delete(
		   @RequestParam(value="msgno", defaultValue="0") int msgno) {
      
      /** 1) 사용자가 입력한 파라미터 유효성 검사 */
	   /** 1) 파라미터 유효성 검사 */
       // 이 값이 존재하지 않는다면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
       if (msgno == 0) {
           return webHelper.getJsonWarning("선택된 쪽지가 없습니다.");
       }
      
      /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        Msgbox input = new Msgbox();
        input.setMsgno(msgno);
       
        try {
         // 데이터 저장 --> 
           msgboxService.editMsgbox_delete(input);

      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      return webHelper.getJsonData();
   }
 
}