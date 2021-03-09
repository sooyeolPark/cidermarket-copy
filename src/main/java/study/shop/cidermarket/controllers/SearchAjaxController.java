package study.shop.cidermarket.controllers;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.ItemListService;

@Controller
public class SearchAjaxController {
	/** Helper 주입 */
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	
	/** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("itemlistService")
	ItemListService itemListService;
	
	/** 검색 페이지 */
	@RequestMapping(value = "/search.cider", method = RequestMethod.GET)
	public ModelAndView search(Model model, HttpServletResponse response, HttpServletRequest request,
			@RequestParam(value="page", defaultValue="1") int nowPage,
			@RequestParam(value="keyword", defaultValue="") String keyword,
			@RequestParam(value="filter", defaultValue="0") int filter,
			@RequestParam(value = "sort", defaultValue = "") String sort) {

		Cookie[] chk_cookies = request.getCookies();
		//쿠키값이 null이 아니고 키워드가 있을경우 기존에 중복되는 쿠키들을 삭제
		if(chk_cookies!=null && keyword != "") {		
			for(int i =0; i<chk_cookies.length; i++) {
				if(keyword.trim().equals(chk_cookies[i].getValue().trim())) {
					// 유효시간을 과거 시점으로 지정하면 즉시 삭제된다.
					// 그 밖의 정보(유효경로, 도메인)는 저장시에 설정한 값과 동일해야 한다.
					Cookie search = new Cookie(chk_cookies[i].getName(), null);
					chk_cookies[i].setMaxAge(-1);
					search.setPath("/");
					search.setDomain("localhost");
					response.addCookie(search);
				}
			}
		}
		
		
		if (keyword != null) {
			/** 입력값이 존재할 경우 쿠키 저장*/
			Cookie search = new Cookie("mySearch"+String.format("%d", System.currentTimeMillis()), keyword);	// 쿠키 생성 (이름, 값 설정)
			search.setMaxAge(60*60*24*7);			// 쿠키의 유효시간(초) - 지정하지 않을 경우 브라우저를 닫으면 즉시 삭제
			search.setPath("/");			// 쿠키가 유효한 경로 설정 - 사이트 최상단 디렉토리 지정(사이트 전역에서 유효)
			search.setDomain("localhost"); // 쿠카가 유효한 도메인 설정 --> 상용화시에는 사이트에 맞게 수정해야 함
			response.addCookie(search);	// 쿠키 저장하기
		}

		
		/** 1) 페이지 구현에 필요한 변수값 생성 */
		int totalCount = 0;		// 전체 게시글 수
		int listCount = 4;		// 한 페이지당 표시할 목록 수
		int pageCount = 5;		// 한 그룹당 표시할 페이지 번호 수
		
		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Product input = new Product();
		input.setSubject(keyword);
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
			// 데이터 조회하기
			if (sort.equals("lowprice")) {
				output = itemListService.selectListByPriceAsc(input);  // 저가순
			} else if(sort.equals("highprice")) {
				output = itemListService.selectListByPriceDesc(input);  // 고가순
			} else {
				output = itemListService.selectListByRegdate(input);  // 최신순 조회(기본값)			
			}
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		
		/** 3) View 처리 */
		model.addAttribute("keyword", keyword);
		model.addAttribute("output", output);
		model.addAttribute("pageData", pageData);
		model.addAttribute("sort", sort);
		model.addAttribute("filter", filter);
		
		return new ModelAndView("user/search_item_list");
	}

}
