package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.ItemListService;
import study.shop.cidermarket.service.ProductService;

@Slf4j
@RestController
public class ItemRestController {
	/** Helper 주입 */
	@Autowired
	WebHelper webHelper;
	@Autowired
	RegexHelper regexHelper;

	/** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("itemlistService")
	ItemListService itemListService;
	
   @Autowired
   @Qualifier("productService")
   ProductService productService;

	/** 목록 페이지 */
//---------------------------------------------------------------------------------------------	
	@RequestMapping(value = "/Item_list", method = RequestMethod.GET)
	public Map<String, Object> get_json_list(
			@RequestParam(value="cateno", defaultValue = "1") int cateno,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "page", defaultValue = "1") int nowPage,
			 @RequestParam(value="filter", defaultValue="0") int filter,
			@RequestParam(value = "sort", defaultValue = "") String sort) {

		/** 1) 페이지 구현에 필요한 변수값 생성 */
		int totalCount = 0; // 전체 게시글 수
		int listCount = 4; // 한 페이지당 표시할 목록 수
		int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수

		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Product input = new Product();
		input.setCateno(cateno);
		if(filter!=0) {
		input.setProdno(filter);
		}
		List<Product> output = null;
		PageData pageData = null;
		
		try {
			// 전체 게시글 수 조회
			totalCount = itemListService.getItemListCount(input);
			// 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
			pageData = new PageData(nowPage, totalCount, listCount, pageCount);

			// SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
			Product.setOffset(pageData.getOffset());
			Product.setListCount(pageData.getListCount());

			// 데이터 조회하기
			if (sort.equals("lowprice")) {
				output = itemListService.selectListByPriceAsc(input);  // 저가순
			} else if(sort.equals("highprice")) {
				output = itemListService.selectListByPriceDesc(input);  // 고가순
			} else {
				output = itemListService.selectListByRegdate(input);  // 최신순 조회(기본값)			
			}
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}

		/** 3) JSON 출력하기 */
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("item", output);
		data.put("keyword", keyword);
		data.put("pageData", pageData);
		data.put("sort", sort);
		data.put("filter", filter);

		return webHelper.getJsonData(data);
	}

	   
}
