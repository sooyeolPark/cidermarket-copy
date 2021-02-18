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
public class MystoreController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
    
    /** 내상점 페이지 */
    @RequestMapping(value="/user/mystore.cider", method=RequestMethod.GET)
    public String mystore() {
        return "user/mystore";
    }
   
    /** 내상점 페이지 */
    @RequestMapping(value="/user/mystore_who.cider", method=RequestMethod.GET)
    public String mystoreWho() {
        return "user/mystore_who";
    }
    

    
    /** 내상점-내정보설정 페이지 */
    @RequestMapping(value="/user/mystore_myinfo.cider", method=RequestMethod.GET)
    public String mystoreMyinfo() {
        return "user/mystore_myinfo";
    }
    
    /** 내상점-나의등급 페이지 */
    @RequestMapping(value="/user/mystore_mygrade.cider", method=RequestMethod.GET)
    public String mystoreMygrade() {
        return "user/mystore_mygrade";
    }
    
    
}
