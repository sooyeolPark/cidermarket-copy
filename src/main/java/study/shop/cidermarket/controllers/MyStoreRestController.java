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

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Msgbox;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.service.MsgboxService;
import study.shop.cidermarket.service.ProductService;
import study.shop.cidermarket.service.RecordService;

@Slf4j
@RestController
public class MyStoreRestController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	
	/** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("productService")
	ProductService productService;
	
	@Autowired
	@Qualifier("memberService")
    MemberService memberService;
	
	/** 거래내역 판매 택배거래확정 정보 갱신 페이지 */
	@RequestMapping(value="/mystore.cider/{shopaddress}", method=RequestMethod.PUT)
	public Map<String, Object> get_mystore_json(
			@RequestParam(value="shopaddress", defaultValue="") String shopaddress,
			@RequestParam(value="smallKeyword", required=false) String smallKeyword,
			@RequestParam(value="page", defaultValue="1") int nowPage) {
                
		/** 페이지 구현에 필요한 변수값 생성 */
	   int totalCount = 0;		// 전체 게시글 수
	   int listCount = 4;		// 한 페이지당 표시할 목록 수
	   int pageCount = 5;		// 한 그룹당 표시할 페이지 번호 수
	   
	   Member input = new Member();
	   input.setShopaddress(shopaddress);
	   
	   Member output = null;
	   List<Product> product = null;
	   PageData pageData = null;
	   
	   Product pro = new Product();
	   pro.setSubject(smallKeyword);
	   pro.setTradecon("J");
	   
	   /** 데이터 조회 */
	   try {
		   // 전체 상품 수 조회
		   totalCount = productService.getMemberProductCount(pro);
		   // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
		   pageData = new PageData(nowPage, totalCount, listCount, pageCount);
		   
		   // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
		   Product.setOffset(pageData.getOffset());
		   Product.setListCount(pageData.getListCount());
		   // 데이터 조회
		   product = productService.getMemberProductList(pro);
		   // 멤버 데이터 조회
		    output = memberService.getMemberShopItem(input);
	   } catch (Exception e) {
		   return webHelper.getJsonError(e.getLocalizedMessage());
	   }		   
	   pro.setSeller(output.getMembno());

        
	   /** 2) JSON 출력하기 */
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("smallKeyword", smallKeyword);
		data.put("item", output);
		data.put("meta", pageData);
		return webHelper.getJsonData(data);
	}

    
	
	
    
}
