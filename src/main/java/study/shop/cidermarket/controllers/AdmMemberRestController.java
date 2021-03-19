package study.shop.cidermarket.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.AdmMemberService;
import study.shop.cidermarket.service.FilesService;
import study.shop.cidermarket.service.ItemIndexService;
import study.shop.cidermarket.service.ProductService;

@Slf4j
@RestController
public class AdmMemberRestController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
	
    /** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("admmemberService")
	AdmMemberService admmemberService;
	
	@Autowired 
    @Qualifier("productService")
    ProductService productService;
   
    @Autowired
    @Qualifier("itemindexService")
    ItemIndexService itemindexService;
   
    @Autowired   
    @Qualifier("filesProductService")
    FilesService filesProductService;
    
    /** 관리자 회원관리 페이지 */
    @RequestMapping(value="/admin/member_adm", method=RequestMethod.PUT)
    public Map<String, Object> memberAdm(
    		@RequestParam(value="membno", defaultValue="default") int membno) {
        /** 1) 페이지 구현에 필요한 변수값 생성 */
        if (membno == 0) {
            return webHelper.getJsonWarning("선택된 회원 없습니다.");
        }
        
        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Member input = new Member();
        input.setMembno(membno);
        //탈퇴 처리이기 때문에 Outmember에다가 a를 기록
        input.setOutmember("A");
    	try {
            // 데이터 저장 --> 
              admmemberService.editMember(input);

         } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
         }
    	
    	Product input_pro = new Product();
       	input_pro.setSeller(membno);
       	List<Product> output = new ArrayList<Product>();
    	try {
    		output = productService.getProductOutList(input_pro);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	if(output!=null) {
    		for(int i=0; i<output.size(); i++) {
    			int prodno = output.get(i).getProdno();
    			String tradecon = output.get(i).getTradecon(); 
    			/** 1) 거래완료된 상품은 상태 변경 막기*/
        		if(prodno==0) {		
        			return webHelper.getJsonWarning("상품번호가 없습니다.");
        		} else if (tradecon.trim().equals("W")) {
        			break;
        		}
        		
        		/** 2) 데이터 삭제 */
        		Product input_pro2 = new Product();
        		input_pro2.setProdno(prodno);
        		input_pro2.setTradecon(tradecon);
        		
        		Files f = new Files();
        		f.setRefid(prodno);
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
        			productService.deleteProduct(input_pro2);
    			} catch (Exception e) {
    				return webHelper.getJsonError(e.getLocalizedMessage());
    			}
    		}
    	}
               
             /** 3) 결과를 확인하기 위한 JSON 출력 */
             return webHelper.getJsonData();
         }
    
	/** 탈퇴회원관리 */
	@RequestMapping(value = "/admin/outmember_adm", method = RequestMethod.PUT)
	public Map<String, Object> outMemberAdm(
    		@RequestParam(value="membno", defaultValue="default") int membno) {
        /** 1) 페이지 구현에 필요한 변수값 생성 */
        if (membno == 0) {
            return webHelper.getJsonWarning("선택된 회원 없습니다.");
        }
        
        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Member input = new Member();
        input.setMembno(membno);
        //복구 처리이기 때문에 Outmember에다가 n를 기록
        input.setOutmember("N");
    	try {
            // 데이터 저장 --> 
              admmemberService.editMember(input);
         } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
         }

         /** 3) 결과를 확인하기 위한 JSON 출력 */
         return webHelper.getJsonData();
      }
}
