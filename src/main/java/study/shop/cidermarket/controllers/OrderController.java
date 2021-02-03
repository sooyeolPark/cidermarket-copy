package study.shop.cidermarket.controllers;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;

@Slf4j
@Controller
public class OrderController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
    
    /** 주문서 작성 페이지 */
    @RequestMapping(value="/user/order_sheet.cider", method=RequestMethod.GET)
    public String orderSheet() {
        return "user/order_sheet";
    }
   
    /** 주문 완료 페이지 */
    @RequestMapping(value="/user/order_ok.cider", method=RequestMethod.GET)
    public String orderOk() {
        return "user/order_ok";
    }
    
    
}
