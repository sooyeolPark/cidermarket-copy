package study.shop.cidermarket.controllers;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Singo;
import study.shop.cidermarket.service.AdmSingoService;

@Slf4j
@RestController
public class AdmSingoRestController {
	
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
	
	   /** Service 패턴 구현체 주입 */
	   @Autowired
	   @Qualifier("admsingoService")
	   AdmSingoService admsingoService;
    
    /** 상품의 거래상태를 바꿔주는 페이지 */
    @RequestMapping(value="/admin/singo_adm_update", method=RequestMethod.PUT)
    public Map<String, Object> singoAdm(
    		@RequestParam(value="chkArray[]", defaultValue="0") List<Integer> prodno,
    		@RequestParam(value="chkTradecon[]", defaultValue="0") List<String> chkTradecon,
    		@RequestParam(value="tradecon") String tradecon) {
        /** 1) 거래완료된 상품은 상태 변경 막기*/
    	for(int i=0; i<chkTradecon.size(); i++) {
    		if(chkTradecon.get(i).trim().equals("W")) {		
    			return webHelper.getJsonWarning("거래 완료된 상품은 상태 변경을 하실 수 없습니다.");
    		}
    		if(chkTradecon.get(i).trim().equals("S")&&tradecon.equals("J")) {		
    			return webHelper.getJsonWarning("숨긴상품은 거래 재개 하실 수 없습니다.");
    		}
    	}
    	/** 2) 데이터 수정 **/
    	try {
    		for(int i=0; i<prodno.size(); i++) {
    			Product input = new Product();
    			input.setTradecon(tradecon);
    		input.setProdno(prodno.get(i));
    			// 데이터 수정 --> 
              admsingoService.editSingo(input);
    		}
         } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
         }
           
         /** 3) 결과를 확인하기 위한 JSON 출력 */
         return webHelper.getJsonData();
      }
    
    /** 신고게시판 삭제 페이지 */
    @RequestMapping(value="/admin/singo_adm_delete", method=RequestMethod.DELETE)
    public Map<String, Object> singoAdmDelete(
    		@RequestParam(value="chkArray[]", defaultValue="0") List<Integer> singono) {
        /** 1) 페이지 구현에 필요한 변수값 생성 */
    	
    	try {
    		for(int i=0; i<singono.size(); i++) {
    			Singo input = new Singo();
    		input.setSingono(singono.get(i));
    			// 데이터 수정 --> 
              admsingoService.deleteSingo(input);
    		}
         } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
         }
           
         /** 3) 결과를 확인하기 위한 JSON 출력 */
         return webHelper.getJsonData();
      }
}