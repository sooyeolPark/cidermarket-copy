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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;

@Slf4j
@Controller
public class AdmHomeAjaxController {
	
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
    public ModelAndView loginAdm(Model model,
    		@RequestParam(value="email", defaultValue="") String email) {
    	
    	model.addAttribute("email", email);
        return new ModelAndView("admin/login_adm");
    }
	
	/** 일반문의 - 답변*/
	@RequestMapping(value = "/admin/question_reply_adm.cider", method = RequestMethod.GET)
	public String questionReplyAdm() {
		return "admin/question_reply_adm";
	}

	
	/** 상품관리 - 상품목록 */
	@RequestMapping(value = "/admin/product_adm.cider", method = RequestMethod.GET)
	public String productAdm() {
		return "admin/product_adm";
	}

}
