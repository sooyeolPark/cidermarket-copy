package study.shop.cidermarket.controllers;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Bbs;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.service.BbsService;
import study.shop.cidermarket.service.FilesService;

@RestController
public class AdmQuestionRestController {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("QuestionService")
   BbsService bbsService;
   
   @Autowired
   @Qualifier("filesBbsService")
   FilesService filesBbsService;
   

 //--------------------------------------------------------------------------------
   /** 수정 폼에 대한 action 페이지 */
   @RequestMapping(value="/admin/question", method=RequestMethod.PUT)
   public Map<String, Object> PUT(
         @RequestParam(value="bbsno", defaultValue="0") int bbsno,
         @RequestParam(value="reply", defaultValue="") String reply) {
      
      /** 1) 사용자가 입력한 파라미터 유효성 검사 */
      if (bbsno == 0)                  { return webHelper.getJsonWarning("글번호가 없습니다."); }
      // 일반 문자열 입력 컬럼 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈 문자열로 처리된다.
      if (!regexHelper.isValue(reply))   { return webHelper.getJsonWarning("내용을 입력하세요."); }
      
      /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        Bbs input = new Bbs();
        input.setBbsno(bbsno);
        input.setReply(reply);
        
        // 저장된 결과를 조회하기 위한 객체
        Bbs output = null;
        
        
        try {
         // 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
           bbsService.editBbs(input);
           
           // 데이터 조회
           output = bbsService.getBbsItem(input);
      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("item", output);
      return webHelper.getJsonData(map);
   }
   
   
   /** 삭제 처리 */
   @RequestMapping(value = "/admin/question", method = RequestMethod.DELETE)
   public Map<String, Object> delete(
           @RequestParam(value="bbsno", defaultValue="") String[] bbsno,
           @RequestParam(value="count", defaultValue="0") int count) {
       
       /** 1) 파라미터 유효성 검사 */
       // 이 값이 존재하지 않는다면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
       if (bbsno == null) {
           return webHelper.getJsonWarning("삭제할 글이 없습니다.");
       }
       
       int[] arr = null;
       if (bbsno[0].equals("on")) {
       	bbsno = Arrays.copyOfRange(bbsno, 1, count+1);
       } 
       arr = Arrays.stream(bbsno).mapToInt(Integer::parseInt).toArray();
       
       for (int i = 0; i<count; i++) {
       	System.out.println("arr.length=" + arr.length + ", bbsno["+i+"]=" + bbsno[i]+", arr["+i+"]=" + arr[i]+ "\n");
       }
       for (int i = 0; i<count; i++) {

	        /** 2) 데이터 삭제하기 */
	        // 데이터 삭제에 필요한 조건값을 Beans에 저장하기
    	    Files f = new Files();
    	    f.setRefid(arr[i]);
    	    f.setReftable("bbs");
    	    List<Files> files = null;
	        
    	    Bbs input = new Bbs();
	        input.setBbsno(arr[i]);
	
	        try {
	        	files = filesBbsService.getRefFilesList(f);
	        	if (files.size() > 0) {
		        	filesBbsService.deleteRefFiles(f); // 데이터 삭제
		            for (Files file : files) {
		            	webHelper.deleteFile(file.getFilepath());
		            }
	        	}
	        	bbsService.deleteBbs(input); // 데이터 삭제
	        } catch (Exception e) {
	            return webHelper.getJsonError(e.getLocalizedMessage());
	        }
       }
       
       /** 3) 결과를 확인하기 위한 JSON 출력 */
       // 확인할 대상이 삭제된 결과값만 OK로 전달
       return webHelper.getJsonData();
   }
    
    
}