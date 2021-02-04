package study.shop.cidermarket.controllers;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;

@Slf4j
@Controller
public class AdmHomeController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
	
	/** 관리자 메인 페이지 */
	@RequestMapping(value = "/admin/home_adm.cider", method = RequestMethod.GET)
	public String homeAdm(Locale locale, Model model) {
		log.debug("관리자 index 화면이 실행되었습니다.");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		return "admin/home_adm";
	}
	
	/** 관리자 로그인 페이지 */
    @RequestMapping(value="/admin/login_adm.cider", method=RequestMethod.GET)
    public String loginAdm() {
        return "admin/login_adm";
    }
    
    /** 관리자 회원관리 페이지 */
    @RequestMapping(value="/admin/member_adm.cider", method=RequestMethod.GET)
    public String memberAdm() {
        return "admin/member_adm";
    }
    
    /** 관리자 공지사항 읽기 페이지 */
    @RequestMapping(value="/admin/notice_read_adm.cider", method=RequestMethod.GET)
    public String noticeReadAdm() {
        return "admin/notice_read_adm";
    }
    
    /** 관리자 공지사항 쓰기 페이지 */
    @RequestMapping(value="/admin/notice_write_adm.cider", method=RequestMethod.GET)
    public String noticeWriteAdm() {
        return "admin/notice_write_adm";
    }
    
    /** 관리자 주문관리 페이지 */
    @RequestMapping(value="/admin/order_adm.cider", method=RequestMethod.GET)
    public String orderAdm() {
        return "admin/order_adm";
    }
}
