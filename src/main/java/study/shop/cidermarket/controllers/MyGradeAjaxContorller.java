package study.shop.cidermarket.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.service.RecordService;

@Controller
public class MyGradeAjaxContorller {
	/** WebHelper 주입 */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	@Autowired
	WebHelper webHelper;

	/** RegexHelper 주입 */
	@Autowired
	RegexHelper regexHelper;

	/** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("recordService")
	RecordService recordService;
	
	@Autowired
    @Qualifier("memberService")
    MemberService memberService;

	//
	/** 목록 페이지 */
	@RequestMapping(value = "/mystore/{shopaddress}/mygrade.cider", method = RequestMethod.GET)
	public ModelAndView get_list(Model model, @PathVariable("shopaddress") String shopaddress) {

		// 회원정보 조회
		Member input_shop = new Member();
		input_shop.setShopaddress(shopaddress);
		Member user = null;
		
		try {
			user = memberService.getMemberShopItem(input_shop); 
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		
		Member input_user = new Member();
		input_user.setMembno(user.getMembno());

		try {
			// 멤버 데이터 조회
			user = memberService.getMemberIndexItem(input_user);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		
		// 판매갯수 불러오기
		Record input_01 = new Record();
		input_01.setSeller(user.getMembno());

		// 조회결과를 저장할 객체 선언
		Record output_sell = null;

		try {
			// 데이터 조회
			output_sell = recordService.getRecordSellEndCountByMonth(input_01);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}

		// 구매 갯수 불러오기
		Record input_02 = new Record();
		input_02.setBuyer(user.getMembno());

		// 조회결과를 저장할 객체 선언
		Record output_buy = null;

		try {
			// 데이터 조회
			output_buy = recordService.getRecordBuyEndCountByMonth(input_02);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}

		
		// 모델 객체에 담기
		model.addAttribute("output_sell", output_sell);
		model.addAttribute("output_buy", output_buy);
		model.addAttribute("user", user);

		return new ModelAndView("user/mystore_mygrade");
	}

}