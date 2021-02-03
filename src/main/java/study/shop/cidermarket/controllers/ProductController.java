package study.shop.cidermarket.controllers;

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
public class ProductController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
	
	/** 상품목록 페이지 */
	@RequestMapping(value = "/user/item_list.cider", method = RequestMethod.GET)
	public String itemList(Model model) {
		return "user/item_list";
	}
	
	/** 상품상세 페이지 */
	@RequestMapping(value = "/user/item_index.cider", method = RequestMethod.GET)
	public String itemIndex(Model model) {
		return "user/item_index";
	}
	
	/** 상품등록 페이지 */
	@RequestMapping(value = "/user/item_reg.cider", method = RequestMethod.GET)
	public String itemReg(Model model) {
		return "user/item_reg";
	}
	
}
