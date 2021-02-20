package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.service.OrderService;

@Slf4j
@RestController
public class OrderRestController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
    
	@Autowired
	@Qualifier("orderService")
	OrderService orderService;
	   
    /** 주문서 작성 페이지 */
    @RequestMapping(value="/order_ok", method=RequestMethod.POST)
    public Map<String, Object> orderSheet(Model model,
 		   @RequestParam(value="user_name", defaultValue="") String name,
 		   @RequestParam(value="user_tel", defaultValue="") String tel,
 		   @RequestParam(value="ipostcode", defaultValue="") String postcode,
 		   @RequestParam(value="iroadAddress", defaultValue="") String addr_01,
 		   @RequestParam(value="ijibunAddress", defaultValue="") String addr_02,
 		   @RequestParam(value="iextraAddress", defaultValue="") String addr_03,
 		   @RequestParam(value="idetailAddress", defaultValue="") String addr_04,
 		   @RequestParam(value="buy_how", defaultValue="") String pay,
 		   @RequestParam(value="buyer", defaultValue="0") int buyer,
 		   @RequestParam(value="prodno", defaultValue="0") int prodno) {
    	
    	/** 1) 사용자가 입력한 파라미터에 대한 유효성 검사 */
		// 일반 문자열 입력 칼럽 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈문자열로 처리된다.
		if(!regexHelper.isValue(name))	{return webHelper.getJsonWarning("이름을 입력하세요");}
		if(!regexHelper.isCellPhone(tel))	{return webHelper.getJsonWarning("전화번호는 숫자로만 입력하세요");}
		log.debug(postcode);
		if(!regexHelper.isValue(postcode))	{return webHelper.getJsonWarning("주소를 입력하세요");}
		if(!regexHelper.isValue(addr_04))	{return webHelper.getJsonWarning("상세 주소를 입력하세요");}		
		
		/** 2) 데이터 저장하기 */
		// 저장할 값들을 Beans에 담는다.
		Record input = new Record();
		Product input_01 = new Product();
		//주소값을 합친다.
		String address = "("+postcode+") " + addr_01 + " " + addr_02 + " " + addr_03 + " " + addr_04;
		
		//Record 테이블에 접근할 객체
		input.setProdno(prodno);
		input.setBuyer(buyer);
		input.setName(name);
		input.setTel(tel);
		input.setAddress(address);
		input.setPay(pay);
		
		//Product 테이블에 접근할 객체
		input_01.setProdno(prodno);
		// 저장된 결과를 조회하기 위한 객체
		Record output = null;
		
		try {
			//데이터 저장
			//--> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 pk값이 저장된다.
			orderService.addRecord(input);
			//Product 테이블에서 데이터 변경
			orderService.editProduct(input_01);
			//데이터 조회
			output = orderService.getRecord(input);
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
		
		
		/** 3) 결과를 확인하기 위한 JSON 출력 */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("item", output);
		return webHelper.getJsonData(map);
	}
   
    
}
