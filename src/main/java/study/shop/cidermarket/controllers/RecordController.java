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
public class RecordController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
    
    /** 거래내역 판매 페이지 */
    @RequestMapping(value="/user/record_sell.cider", method=RequestMethod.GET)
    public String recordSell() {
        return "user/record_sell";
    }
   
    /** 거래내역 구매 페이지 */
    @RequestMapping(value="/user/record_buy.cider", method=RequestMethod.GET)
    public String recordBuy() {
        return "user/record_buy";
    }
    
    
}
