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
public class ReviewController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
    
    /** 거래후기 읽기 페이지 */
    @RequestMapping(value="/user/review_view.cider", method=RequestMethod.GET)
    public String reviewView() {
        return "user/review_view";
    }
   
    /** 거래후기 쓰기 페이지 */
    @RequestMapping(value="/user/review_write.cider", method=RequestMethod.GET)
    public String reviewWrite() {
        return "user/review_write";
    }
    
    
}
