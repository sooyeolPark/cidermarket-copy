package study.shop.cidermarket.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.service.MsgboxService;

@RestController
public class MsgboxRestController {
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
   
  

   /** 보관함에 저장 */
   @RequestMapping(value="/msgbox/sender_save", method=RequestMethod.PUT)
   public Map<String, Object> put_save(
		   @RequestParam(value="msgno", defaultValue="0") int msgno) {

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
           smsgboxService.editMsgbox_save(input);

      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      return webHelper.getJsonData();
   }
   
   /** 사용자가 삭제버튼을 눌렀을 때 */
   @RequestMapping(value="/msgbox/sender_delete", method=RequestMethod.PUT)
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
           smsgboxService.editMsgbox_delete(input);

      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      return webHelper.getJsonData();
   }
   
  
   
   /** Sender 사용자가 삭제버튼을 눌렀을 때 */
   @RequestMapping(value="/msgbox/store_sender", method=RequestMethod.PUT)
   public Map<String, Object> put_delete_sst(
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
           sstmsgboxService.editMsgbox_delete(input);

      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      return webHelper.getJsonData();
   }
   
 
   
   /** Receiver 사용자가 삭제버튼을 눌렀을 때 */
   @RequestMapping(value="/msgbox/store_receiver", method=RequestMethod.PUT)
   public Map<String, Object> put_delete_rst(
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
           rstmsgboxService.editMsgbox_delete(input);

      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      return webHelper.getJsonData();
   }
   

   /** 작성 폼에 대한 action 페이지 */
   @RequestMapping(value="/msgbox/receiver", method=RequestMethod.POST)
   public Map<String, Object> post_r(
         @RequestParam(value="sender", defaultValue="0") int sender,
         @RequestParam(value="receiver", defaultValue="0") int receiver,
         @RequestParam(value="prodno", defaultValue="0") int prodno,
         @RequestParam(value="content", defaultValue="") String content) {
      
      /** 1) 사용자가 입력한 파라미터 유효성 검사 */
      if (!regexHelper.isValue(content))   { return webHelper.getJsonWarning("내용을 입력하세요."); }
      
      /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        Msgbox input = new Msgbox();
        input.setSender(sender);
        input.setReceiver(receiver);
        input.setProdno(prodno);
        input.setContent(content);
       
        try {
         // 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
           rmsgboxService.addMsgbox(input);

      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      return webHelper.getJsonData();
   }
   
   /** 보관함에 저장 */
   @RequestMapping(value="/msgbox/receiver_save", method=RequestMethod.PUT)
   public Map<String, Object> put_save_r(
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
           rmsgboxService.editMsgbox_save(input);

      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      return webHelper.getJsonData();
   }
   
   /** 사용자가 삭제버튼을 눌렀을 때 */
   @RequestMapping(value="/msgbox/receiver_delete", method=RequestMethod.PUT)
   public Map<String, Object> put_delete_r(
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
           rmsgboxService.editMsgbox_delete(input);

      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      return webHelper.getJsonData();
   }
}