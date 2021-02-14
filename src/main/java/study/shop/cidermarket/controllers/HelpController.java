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
public class HelpController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
    
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
    
    /** 문의내역 목록 페이지 */
    //@RequestMapping(value="/user/inquiry_list.cider", method=RequestMethod.GET)
    //public String inquiryList() {
    //    return "user/inquiry_list";
    //}
    
    /** 문의내역 읽기 페이지 */
    //@RequestMapping(value="/user/inquiry_view.cider", method=RequestMethod.GET)
    //public String inquiryView() {
    //    return "user/inquiry_view";
    //}
    
    /** 문의내역 쓰기 페이지 */
    //@RequestMapping(value="/user/inquiry.cider", method=RequestMethod.GET)
    //public String inquiry() {
    //    return "user/inquiry";
    //}
    
}
