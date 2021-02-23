package study.shop.cidermarket.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.service.ProductService;

@Slf4j
@Controller
public class MyStoreAjaxContorller {
	/** WebHelper 주입 */
	@Autowired
	WebHelper webHelper;

	/** RegexHelper 주입 */
	@Autowired
	RegexHelper regexHelper;

	/** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("memberService")
	MemberService memberService;

	@Autowired
	@Qualifier("productService")
	ProductService productService;

	/** 판매상품 목록 페이지 */
	@RequestMapping(value = "/mystore/{shopaddress}", method = RequestMethod.GET)
	public ModelAndView get_mystore(Model model, @PathVariable("shopaddress") String shopaddress,
			@RequestParam(value = "smallKeyword", required = false) String smallKeyword,
			@RequestParam(value = "page", defaultValue = "1") int nowPage) {

		/** 로그인 된 회원아이디 가져오기 */
		int myNum = 0;
		// HttpSession session = webHelper.getRequest().getSession();
		// myNum = (int) session.getAttribute("myNum");
		/** 페이지 구현에 필요한 변수값 생성 */
		int totalCount = 0; // 전체 게시글 수
		int listCount = 4; // 한 페이지당 표시할 목록 수
		int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수

		Member input = new Member();
		Member output = null;
		List<Product> product = null;
		PageData pageData = null;
		Product pro = new Product();

		if (myNum != 0) {

			/** 데이터 조회 */
			input.setMembno(myNum);
			try {
				// 멤버 데이터 조회
				output = memberService.getMemberIndexItem(input);
			} catch (Exception e) {
				return webHelper.redirect(null, e.getLocalizedMessage());
			}
			pro.setSeller(myNum);

		} else {

			/** 데이터 조회 */
			input.setShopaddress(shopaddress);
			try {
				// 멤버 데이터 조회
				output = memberService.getMemberShopItem(input);
				input.setMembno(output.getMembno());
				output = memberService.getMemberIndexItem(input);
			} catch (Exception e) {
				return webHelper.redirect(null, e.getLocalizedMessage());
			}
			pro.setSeller(output.getMembno());

		}

		pro.setSubject(smallKeyword);
		pro.setTradecon("J");

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
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}

		// 모델 객체에 담기
		model.addAttribute("user", output);
		model.addAttribute("pageData", pageData);
		model.addAttribute("product", product);
		model.addAttribute("smallKeyword", smallKeyword);

		return new ModelAndView("user/mystore");

	}

	/** 숨긴상품 목록 페이지 */
	@RequestMapping(value = "/mystore_s/{shopaddress}", method = RequestMethod.GET)
	public ModelAndView get_mystore_s(Model model, @PathVariable("shopaddress") String shopaddress,
			@RequestParam(value = "smallKeyword", required = false) String smallKeyword,
			@RequestParam(value = "page", defaultValue = "1") int nowPage) {

		/** 1) 로그인 된 회원아이디 가져오기 */
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");

		/** 2) 페이지 구현에 필요한 변수값 생성 */
		int totalCount = 0; // 전체 게시글 수
		int listCount = 4; // 한 페이지당 표시할 목록 수
		int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수

		/** 2) 데이터 조회 */
		Member input = new Member();
		input.setMembno(myNum);

		Product pro = new Product();
		pro.setSeller(myNum);
		pro.setSubject(smallKeyword);
		pro.setTradecon("S");

		Member output = null;
		List<Product> product = null;
		PageData pageData = null;
		try {
			// 멤버 데이터 조회
			output = memberService.getMemberIndexItem(input);

			// 전체 상품 수 조회
			totalCount = productService.getMemberProductCount(pro);
			// 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
			pageData = new PageData(nowPage, totalCount, listCount, pageCount);

			// SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
			Product.setOffset(pageData.getOffset());
			Product.setListCount(pageData.getListCount());
			// 데이터 조회
			product = productService.getMemberProductList(pro);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}

		// 모델 객체에 담기
		model.addAttribute("user", output);
		model.addAttribute("output", output);
		model.addAttribute("pageData", pageData);
		model.addAttribute("product", product);
		model.addAttribute("smallKeyword", smallKeyword);

		return new ModelAndView("user/mystore_s");
	}

	/** 찜상품 목록 페이지 */
	@RequestMapping(value = "/mystore_mp/{shopaddress}", method = RequestMethod.GET)
	public ModelAndView get_mystore_mp(Model model, @PathVariable("shopaddress") String shopaddress,
			@RequestParam(value = "smallKeyword", required = false) String smallKeyword,
			@RequestParam(value = "page", defaultValue = "1") int nowPage) {

		/** 1) 로그인 된 회원아이디 가져오기 */
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");

		/** 2) 페이지 구현에 필요한 변수값 생성 */
		int totalCount = 0; // 전체 게시글 수
		int listCount = 4; // 한 페이지당 표시할 목록 수
		int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수

		/** 2) 데이터 조회 */
		Member input = new Member();
		input.setMembno(myNum);

		Product pro = new Product();
		pro.setSeller(myNum);
		pro.setSubject(smallKeyword);
		pro.setTradecon("MP");

		Member output = null;
		List<Product> product = null;
		PageData pageData = null;
		try {
			// 멤버 데이터 조회
			output = memberService.getMemberIndexItem(input);

			// 전체 상품 수 조회
			totalCount = productService.getMemberProductCount(pro);
			// 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
			pageData = new PageData(nowPage, totalCount, listCount, pageCount);

			// SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
			Product.setOffset(pageData.getOffset());
			Product.setListCount(pageData.getListCount());
			// 데이터 조회
			product = productService.getMemberProductList(pro);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}

		// 모델 객체에 담기
		model.addAttribute("user", output);
		model.addAttribute("output", output);
		model.addAttribute("pageData", pageData);
		model.addAttribute("product", product);
		model.addAttribute("smallKeyword", smallKeyword);

		return new ModelAndView("user/mystore_mp");
	}

}