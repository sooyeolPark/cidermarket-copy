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
import org.springframework.web.multipart.MultipartFile;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Category;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.CategoryService;
import study.shop.cidermarket.service.FilesService;

@RestController
public class AdmCategoryRestController {
	/** WebHelper 주입 */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	@Autowired
	WebHelper webHelper;

	/** RegexHelper 주입 */
	@Autowired
	RegexHelper regexHelper;

	/** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("categoryService")
	CategoryService categoryService;
	
	@Autowired
    @Qualifier("filesCateService")
    FilesService filesCateService;

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

		try {
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


	/** 작성 폼에 대한 action 페이지 */
	@RequestMapping(value = "/Category", method = RequestMethod.POST)
	public Map<String, Object> post(
			@RequestParam(value = "name", defaultValue = "") String name,
			@RequestParam(required=false) MultipartFile photo) {

		/** 1) 사용자가 입력한 파라미터 유효성 검사 */
		// 일반 문자열 입력 컬럼 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈 문자열로 처리된다.
		if (!regexHelper.isValue(name)) {
			return webHelper.getJsonWarning("이름을 입력하세요.");
		}
		if (photo == null) {
			return webHelper.getJsonWarning("정사각형의 카테고리 심볼이미지를 등록하세요.");
		}

		/** 2) 데이터 저장하기 */
		// 저장할 값들을 Beans에 담는다.
		Category input = new Category();
		input.setName(name);

		//input에 이름이 담겨있는 상황 
		// 저장된 결과를 조회하기 위한 객체
		Category output = null;
		Files f = null;
		
		try {
			// 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
			categoryService.addCategory(input);

			// 데이터 조회
			output = categoryService.getCategoryItem(input);
			
			// 파일 업로드
            f = webHelper.saveMultipartFile(photo);
            f.setFname("cate_"+output.getCateno());
            f.setReftable("category");
            f.setRefid(output.getCateno());
            filesCateService.addFiles(f);
            f = filesCateService.getFilesItem(f);
		} catch (NullPointerException e) {
            e.printStackTrace();
            return webHelper.getJsonWarning("업로드 된 파일이 없습니다.");
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}

		/** 3) 결과를 확인하기 위한 JSON 출력 */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("item", output);
		map.put("file", f);
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
	@RequestMapping(value="/Category", method=RequestMethod.DELETE)
	public Map<String, Object> delete(
			@RequestParam(value="cateno", defaultValue="") String[] cateno,
			@RequestParam(value="count", defaultValue="0") int count) {

		/** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않는다면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
		if (cateno == null) {
			return webHelper.getJsonWarning("삭제할 카테고리가 없습니다.");
		}

		/** 2) 데이터 삭제하기 */
		// 데이터 삭제에 필요한 조건값을 Beans에 저장하기
		int[] arr = null;
		
		arr = Arrays.stream(cateno).mapToInt(Integer::parseInt).toArray();

		for (int i = 0; i<count; i++) {
			Category input = new Category();
			input.setCateno(arr[i]);
			
			Product input_01 = new Product();
			input_01.setCateno(arr[i]);
			
			Files f = new Files();
			f.setRefid(arr[i]);
			f.setReftable("category");
			
			Files f_01 = new Files();
			f_01.setRefid(arr[i]);
			
			Files output_01 = null;
			try {
				output_01 = categoryService.getFilesItem(f_01); // 선택된 카테고리의 filepath 조회
				categoryService.updateProductCateno(input_01); //Product테이블에서 cateno을 기타로 바꿔준다.
				categoryService.deleteCategory(input); // 데이터 삭제
				filesCateService.deleteFiles(f); // 데이터 삭제
			} catch (Exception e) {
				return webHelper.getJsonError(e.getLocalizedMessage());
			}
			
			//조회한 filepath를 불러와 파일 삭제
			try {
				webHelper.deleteFile(output_01.getFilepath());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		/** 3) 결과를 확인하기 위한 JSON 출력 */
		// 확인할 대상이 삭제된 결과값만 OK로 전달
		return webHelper.getJsonData();
	}

}