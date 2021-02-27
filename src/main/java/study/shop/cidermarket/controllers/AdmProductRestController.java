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
import study.shop.cidermarket.model.Singo;
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
		@RequestParam(value="chkArray[]", defaultValue="0") List<Integer> prodno,
		@RequestParam(value="tradecon", defaultValue="0") String tradecon) {

	    	
	    	try {
	    		for(int i=0; i<prodno.size(); i++) {
	    			Product input = new Product();
	    			input.setTradecon(tradecon);
	    			input.setProdno(prodno.get(i));
	    			// 데이터 수정 --> 
	              productService.editTradecon(input);
	    		}
	         } catch (Exception e) {
	            return webHelper.getJsonError(e.getLocalizedMessage());
	         }
	           
	         /** 3) 결과를 확인하기 위한 JSON 출력 */
	         return webHelper.getJsonData();
	      }
		   


	   
	   //--------------------------------------------------------------------------------------
	    /** 상품관리 삭제 페이지 */
	    @RequestMapping(value="/adm/product", method=RequestMethod.DELETE)
	    public Map<String, Object> Delete(
	    		@RequestParam(value="chkArray[]", defaultValue="0") List<Integer> prodno
	    		) {
	        /** 1) 페이지 구현에 필요한 변수값 생성 */
	    	
	    	try {
	    		for(int i=0; i<prodno.size(); i++) {
	    			Product input = new Product();
	    		input.setProdno(prodno.get(i));
	    		
	    			// 데이터 수정 -->
	              productService.deleteProduct(input);
	    		}
	         } catch (Exception e) {
	            return webHelper.getJsonError(e.getLocalizedMessage());
	         }
	           
	         /** 3) 결과를 확인하기 위한 JSON 출력 */
	         return webHelper.getJsonData();
	    }

}