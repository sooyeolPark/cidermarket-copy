package study.shop.cidermarket.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HelpController {

    /** 헬프센터 페이지 */
    @RequestMapping(value="/help/help.cider", method=RequestMethod.GET)
    public String help() {
        return "user/help";
    }
    
    /** 이용약관 페이지 */
    @RequestMapping(value="/help/terms.cider", method=RequestMethod.GET)
    public String terms() {
        return "user/terms";
    }
    
    /** 개인정보취급방침 페이지 */
    @RequestMapping(value="/help/protection.cider", method=RequestMethod.GET)
    public String protection() {
        return "user/protection";
    }
    
    /** 위치정보수집 페이지 */
    @RequestMapping(value="/help/location.cider", method=RequestMethod.GET)
    public String location() {
        return "user/location";
    }
    
}
