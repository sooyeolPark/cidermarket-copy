package study.shop.cidermarket.controllers;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.service.ItemIndexService;
import study.shop.cidermarket.service.OrderService;

@Slf4j
@Controller
public class OrderAjaxController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
    
	@Autowired
	@Qualifier("itemindexService")
	ItemIndexService itemindexService;
	
	@Autowired
	@Qualifier("orderService")
	OrderService orderService;
	
    /** 주문서 작성 페이지 */
    @RequestMapping(value="/user/order_sheet.cider", method=RequestMethod.GET)
    public ModelAndView orderSheet(Model model,
 		   @RequestParam(value="prodno", defaultValue="0") int prodno) {
    	
    	/** 1) 유효성 검사 */
        // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
        if (prodno == 0) {
            return webHelper.redirect(null, "상품번호가 없습니다.");
        }
        
        /** 2) 데이터 조회 */ 
        // 상품정보 불러오기
        // 데이터 조회에 필요한 조건값을 Beans에 저장하기
        Product input = new Product();
        input.setProdno(prodno);

        // 조회결과를 저장할 객체 선언
        Product output = null;

        try {
            // 데이터 조회
            output = itemindexService.getProductItem(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }
        
        /** 3) 모델에 담아서 페이지로 이동 */
        model.addAttribute("product", output);
       
    	return new ModelAndView("user/order_sheet");
    }
   
    /** 주문 완료 페이지 */
    @RequestMapping(value="/user/order_ok.cider", method=RequestMethod.GET)
    public ModelAndView orderOk(Model model,
  		   @RequestParam(value="recono", defaultValue="0") int recono) {
    	/** 1) 유효성 검사 */
    	if (recono == 0) {
            return webHelper.redirect(null, "레코드 넘버가 없습니다.");
        }
    	/** 2) 데이터 조뢰 */ 
        // 상품정보 불러오기
        // 데이터 조회에 필요한 조건값을 Beans에 저장하기
        Record input = new Record();
        input.setRecono(recono);

        // 조회결과를 저장할 객체 선언
        Record output = null;

        try {
            // 데이터 조회
            output = orderService.getRecord(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }
        
        // 상품정보 불러오기
        // 데이터 조회에 필요한 조건값을 Beans에 저장하기
        Product input_01 = new Product();
        input_01.setProdno(output.getProdno());

        // 조회결과를 저장할 객체 선언
        Product output_01 = null;

        try {
            // 데이터 조회
            output_01 = itemindexService.getProductItem(input_01);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }
        /** 3) 모델에 담아서 페이지로 이동 */
        model.addAttribute("record", output);
        model.addAttribute("product", output_01);
       
    	return new ModelAndView("user/order_ok");
    }
    
    
}
