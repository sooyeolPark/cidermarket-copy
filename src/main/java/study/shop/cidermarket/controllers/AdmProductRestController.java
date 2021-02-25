package study.shop.cidermarket.controllers;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Category;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Review;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.service.MyInfoService;
import study.shop.cidermarket.service.ProductService;

@Slf4j
@RestController
public class AdmProductRestController {
	/** WebHelper 주입 */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	@Autowired
	WebHelper webHelper;

	/** RegexHelper 주입 */
	@Autowired
	RegexHelper regexHelper;

	/** Service 패턴 구현체 주입 */
	@Qualifier("productService")
	@Autowired
	ProductService productService;

	 //------------Tradecon 변경 페이지 ----------------------------------------
	   @RequestMapping(value="/adm/product", method=RequestMethod.PUT)
	   public Map<String, Object> tradecon(Model model,
	   		@RequestParam(value="tradecon", defaultValue="") String tradecon,
		   @RequestParam(value="prodno", defaultValue="") int prodno) {
	   	
		   

		   
	   	/** 1) 데이터 조회하기 */
	   	Product input = new Product();
	   	input.setProdno(prodno);
	   	input.setTradecon(tradecon);
	   	
	   	List<Product> output = null;
	   	
	   	try {

			productService.editTradecon(input);
			output = productService.getProductList(input);
			
			} catch (Exception e) {
				return webHelper.getJsonError(e.getLocalizedMessage());
			}
	   	
	   	/** 2) View 처리 */
	    Map<String, Object> data = new HashMap<String, Object>();
	    data.put("item", output);
	   	
		return webHelper.getJsonData(data);
	   }

	   
	   //--------------------------------------------------------------------------------------
	   /** 삭제 처리 */
		@RequestMapping(value="/adm/product", method=RequestMethod.DELETE)
		public Map<String, Object> delete(
				@RequestParam(value="prodno", defaultValue="") String[] prodno,
				@RequestParam(value="count", defaultValue="0") int count) {

			/** 1) 파라미터 유효성 검사 */
			// 이 값이 존재하지 않는다면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
			if (prodno == null) {
				return webHelper.getJsonWarning("삭제할 카테고리가 없습니다.");
			}

			/** 2) 데이터 삭제하기 */
			// 데이터 삭제에 필요한 조건값을 Beans에 저장하기
			int[] arr = null;
			
			arr = Arrays.stream(prodno).mapToInt(Integer::parseInt).toArray();

			for (int i = 0; i<count; i++) {
				Product input = new Product();
				input.setProdno(arr[i]);
				

				
				try {
					productService.deleteProduct(input); // 데이터 삭제
				} catch (Exception e) {
					return webHelper.getJsonError(e.getLocalizedMessage());
				}
			}

			/** 3) 결과를 확인하기 위한 JSON 출력 */
			// 확인할 대상이 삭제된 결과값만 OK로 전달
			return webHelper.getJsonData();
		}

}