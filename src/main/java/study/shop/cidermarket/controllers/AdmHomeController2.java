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
public class AdmHomeController2 {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
	
	/** 신고게시판 */
	@RequestMapping(value = "/admin/singo_adm.cider", method = RequestMethod.GET)
	public String singoAdm(Locale locale, Model model) {
		return "admin/singo_adm";
	}
	
	/** 일반문의 - 답변*/
	@RequestMapping(value = "/admin/question_reply_adm.cider", method = RequestMethod.GET)
	public String questionReplyAdm(Locale locale, Model model) {
		return "admin/question_reply_adm";
	}
	
	/** 일반문의 */
	@RequestMapping(value = "/admin/question_adm.cider", method = RequestMethod.GET)
	public String questionAdm(Locale locale, Model model) {
		return "admin/question_adm";
	}
	
	/** 상품관리 - 상품목록 */
	@RequestMapping(value = "/admin/product_adm.cider", method = RequestMethod.GET)
	public String productAdm(Locale locale, Model model) {
		return "admin/product_adm";
	}
	
	/** 운영정책 */
	@RequestMapping(value = "/admin/policy_adm.cider", method = RequestMethod.GET)
	public String policyAdm(Locale locale, Model model) {
		return "admin/policy_adm";
	}
	
	/** 탈퇴회원관리 */
	@RequestMapping(value = "/admin/outmember_adm.cider", method = RequestMethod.GET)
	public String outMemberAdm(Locale locale, Model model) {
		return "admin/outmember_adm";
	}
}
