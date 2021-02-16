package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Category;
import study.shop.cidermarket.service.CategoryService;

@RestController
public class CategoryAdmRestController {
	/** WebHelper 주입 */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	@Autowired
	WebHelper webHelper;

	/** RegexHelper 주입 */
	@Autowired
	RegexHelper regexHelper;

	/** Service 패턴 구현체 주입 */
	@Autowired
	CategoryService categoryService;

	/** 목록 페이지 */
	@RequestMapping(value = "/Category", method = RequestMethod.GET)
	public Map<String, Object> get_list(
			@RequestParam(value = "cateno", defaultValue = "0") int cateno,
			@RequestParam(value = "keyword", required = false) String keyword) {

		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Category input = new Category();
		input.setCateno(cateno);

		List<Category> output = null;
//      PageData pageData = null;

		try {
			/*
			 * // 전체 게시글 수 조회 totalCount = categoryService.getCategoryCount(input); // 페이지
			 * 번호 계산 --> 계산결과를 로그로 출력될 것이다. // pageData = new PageData(nowPage, totalCount,
			 * listCount, pageCount);
			 * 
			 * // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
			 * Category.setOffset(pageData.getOffset());
			 * Category.setListCount(pageData.getListCount());
			 */

			// 데이터 조회하기
			output = categoryService.getCategoryList(input);
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}

		/** 3) JSON 출력하기 */
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("item", output);
		data.put("keyword", keyword);
//      data.put("meta", pageData);

		return webHelper.getJsonData(data);
	}

	/*   *//** 상세 페이지 */
	/*
	 * @RequestMapping(value="/Category", method=RequestMethod.GET) public
	 * Map<String, Object> get_item(@PathVariable("cateno") int cateno) {
	 *//** 1) 데이터 조회하기 */
	/*
	 * // 데이터 조회에 필요한 조건값을 Beans에 저장하기 Category input = new Category();
	 * input.setCateno(cateno);
	 * 
	 * // 조회 결과를 저장할 객체 선언 Category output = null; try { // 데이터 조회 output =
	 * categoryService.getCategoryItem(input); } catch (Exception e) { return
	 * webHelper.getJsonError(e.getLocalizedMessage()); }
	 * 
	 *//** 2) JSON 출력하기 *//*
							 * Map<String, Object> data = new HashMap<String, Object>(); data.put("item",
							 * output); return webHelper.getJsonData(data); }
							 */

	/** 작성 폼에 대한 action 페이지 */
	@RequestMapping(value = "/Category", method = RequestMethod.POST)
	public Map<String, Object> post
			(@RequestParam(value = "name", defaultValue = "") String name) {

		/** 1) 사용자가 입력한 파라미터 유효성 검사 */
		// 일반 문자열 입력 컬럼 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈 문자열로 처리된다.
		if (!regexHelper.isValue(name)) {
			return webHelper.getJsonWarning("이름을 입력하세요.");
		}

		/** 2) 데이터 저장하기 */
		// 저장할 값들을 Beans에 담는다.
		Category input = new Category();
		input.setName(name);

		//input에 이름이 담겨있는 상황 
		// 저장된 결과를 조회하기 위한 객체
		Category output = null;

		try {
			// 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
			categoryService.addCategory(input);

			// 데이터 조회
			output = categoryService.getCategoryItem(input);
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}

		/** 3) 결과를 확인하기 위한 JSON 출력 */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("item", output);
		return webHelper.getJsonData(map);
	}

	/** 수정 폼에 대한 action 페이지 */
	@RequestMapping(value = "/Category", method = RequestMethod.PUT)
	public Map<String, Object> PUT(
			@RequestParam(value = "cateno", defaultValue = "0") int cateno,
			@RequestParam(value = "name", defaultValue = "") String name) {

		/** 1) 사용자가 입력한 파라미터 유효성 검사 */
		if (cateno == 0) {
			return webHelper.getJsonWarning("카테고리번호가 없습니다.");
		}
		// 일반 문자열 입력 컬럼 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈 문자열로 처리된다.
		if (!regexHelper.isValue(name)) {
			return webHelper.getJsonWarning("카테고리명 입력하세요.");
		}

		/** 2) 데이터 저장하기 */
		// 저장할 값들을 Beans에 담는다.
		Category input = new Category();
		input.setCateno(cateno);
		input.setName(name);

		// 저장된 결과를 조회하기 위한 객체
		Category output = null;

		try {
			// 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
			categoryService.editCategory(input);

			// 데이터 조회
			output = categoryService.getCategoryItem(input);
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}

		/** 3) 결과를 확인하기 위한 JSON 출력 */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("item", output);
		return webHelper.getJsonData(map);
	}

	/** 삭제 처리 */
	@RequestMapping(value = "/Category", method = RequestMethod.DELETE)
	public Map<String, Object> delete(@RequestParam(value = "cateno", defaultValue = "0") int cateno) {

		/** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않는다면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
		if (cateno == 0) {
			return webHelper.getJsonWarning("글 번호가 없습니다.");
		}

		/** 2) 데이터 삭제하기 */
		// 데이터 삭제에 필요한 조건값을 Beans에 저장하기
		Category input = new Category();
		input.setCateno(cateno);

		try {
			categoryService.deleteCategory(input); // 데이터 삭제
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}

		/** 3) 결과를 확인하기 위한 JSON 출력 */
		// 확인할 대상이 삭제된 결과값만 OK로 전달
		return webHelper.getJsonData();
	}

}