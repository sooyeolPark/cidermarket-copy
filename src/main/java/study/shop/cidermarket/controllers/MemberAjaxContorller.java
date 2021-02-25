package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.service.MemberService;

@Controller
public class MemberAjaxContorller {
    /** WebHelper 주입 */
    // -> import org.springframework.beans.factory.annotation.Autowired;
    @Autowired WebHelper webHelper;
    
    /** RegexHelper 주입 */
    @Autowired RegexHelper regexHelper;
    
    /** Service 패턴 구현체 주입 */
    @Qualifier("memberService")
    @Autowired MemberService memberService;
    
    /** 로그인 페이지 */
    @RequestMapping(value="/member/login.cider", method=RequestMethod.GET)
    public ModelAndView login(Model model,
    		@RequestParam(value="email", defaultValue="") String email) {
    	
    	model.addAttribute("email", email);
		return new ModelAndView("user/login");
    }
    
    /** ID 찾기 페이지 */
    @RequestMapping(value="/member/find_id.cider", method=RequestMethod.GET)
    public ModelAndView findid(Model model) {
		return new ModelAndView("user/find_id");
    }
    
    /** PW 찾기 페이지 */
    @RequestMapping(value="/member/find_pw.cider", method=RequestMethod.GET)
    public ModelAndView findpw(Model model) {
		return new ModelAndView("user/find_pw");
    }
        
    /** 회원가입 작성 폼 페이지 */
    @RequestMapping(value="/member/join.cider", method=RequestMethod.GET)
    public ModelAndView add(Model model) {
        return new ModelAndView("user/join");
    }
}
