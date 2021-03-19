package study.shop.cidermarket.controllers;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

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
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.FilesService;
import study.shop.cidermarket.service.ItemIndexService;
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
	@Autowired
	@Qualifier("productService")
	ProductService productService;
	
	@Autowired
	@Qualifier("filesBbsService")
	FilesService filesBbsService;
	
	@Autowired   
	@Qualifier("filesProductService")
	FilesService filesProductService;
	
	@Autowired
    @Qualifier("itemindexService")
    ItemIndexService itemindexService;
	

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
	    		@RequestParam(value="prodno", defaultValue="") String[] prodno,
	    		@RequestParam(value="tradecon", defaultValue="") String[] tradecon,
	    		@RequestParam(value="count", defaultValue="0") int count) {
	    	
	    	/** 1) 파라미터 유효성 검사 */
	        // 이 값이 존재하지 않는다면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
	        if (prodno == null) {
	            return webHelper.getJsonWarning("삭제할 상품이 없습니다.");
	        }
	        
	        int[] arr = null;
	        if (prodno[0].equals("on")) {
	        	prodno = Arrays.copyOfRange(prodno, 1, count+1);
	        	tradecon = Arrays.copyOfRange(tradecon, 1, count+1);
	        } 
	        arr = Arrays.stream(prodno).mapToInt(Integer::parseInt).toArray();
	    	
	        for (int i = 0; i<count; i++) {
	        	/** 2) 데이터 삭제 */
	    		Product input = new Product();
	    		input.setProdno(arr[i]);
	    		input.setTradecon(tradecon[i]);
	    		
	    		Files f = new Files();
	    		f.setRefid(arr[i]);
	    		f.setReftable("product");
	    		List<Files> files = null;
	    		
	    		try {
	    			files = itemindexService.getFilesListItem(f);
	    			if (files.size() > 0) {
		        		filesProductService.deleteRefFiles(f);  // 테이블에서 데이터 삭제
			            for (Files file : files) {
			            	webHelper.deleteFile(file.getFilepath());
			            	webHelper.deleteFile(file.getThumbnailPath());
			            }
		        	}
	    			productService.deleteProduct(input);
				} catch (Exception e) {
					return webHelper.getJsonError(e.getLocalizedMessage());
				}
	        }
	    	
	           
	         /** 3) 결과를 확인하기 위한 JSON 출력 */
	         return webHelper.getJsonData();
	    }

}