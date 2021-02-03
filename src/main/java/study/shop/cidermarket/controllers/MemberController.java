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
public class MemberController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
    
    /** 로그인 페이지 */
    @RequestMapping(value="/user/login.cider", method=RequestMethod.GET)
    public String login() {
        return "user/login";
    }
    
    /** 아이디찾기 페이지 */
    @RequestMapping(value="/user/find_id.cider", method=RequestMethod.GET)
    public String findId() {
        return "user/find_id";
    }
    
    /** 비밀번호찾기 페이지 */
    @RequestMapping(value="/user/find_pw.cider", method=RequestMethod.GET)
    public String findPw() {
        return "user/find_pw";
    }
    
    /** 회원가입 페이지 */
    @RequestMapping(value="/user/join.cider", method=RequestMethod.GET)
    public String join() {
        return "user/join";
    }
}
