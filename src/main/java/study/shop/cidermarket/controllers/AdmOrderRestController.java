package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Review;
import study.shop.cidermarket.service.MemberService;
import study.shop.cidermarket.service.MyInfoService;

@Slf4j
@RestController
public class AdmOrderRestController {
	/** WebHelper 주입 */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	@Autowired
	WebHelper webHelper;

	/** RegexHelper 주입 */
	@Autowired
	RegexHelper regexHelper;

	/** Service 패턴 구현체 주입 */
	@Qualifier("MyInfoService")
	@Autowired
	MyInfoService myInfoService;

// --------------------------------------------------------------------------------작성폼에
	// 대한 action페이지
	/*
	 * @RequestMapping(value = "/reviewWrite", method = RequestMethod.POST) public
	 * Map<String, Object> post(
	 * 
	 * @RequestParam(value = "prodno", required = false) int prodno,
	 * 
	 * @RequestParam(value = "regdate", required = false) String regdate,
	 * 
	 * @RequestParam(value = "rate", required = false) int rate,
	 * 
	 * @RequestParam(value = "content", required = false) String content,
	 * 
	 * @RequestParam(value = "recono", required = false) int recono,
	 * 
	 * @RequestParam(value = "receiver", required = false) int receiver) {
	 * 
	 * HttpSession session = webHelper.getRequest().getSession(); int myNum = (int)
	 * session.getAttribute("myNum");
	 * 
	 *//** 1) 유효성 검사 */
	/*
	 * // 일반 문자열 입력 칼럽 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈문자열로 처리된다. if
	 * (!regexHelper.isValue(content)) { return
	 * webHelper.getJsonWarning("리뷰내용을 입력해주세요"); }
	 * 
	 * // 숫자형으로 선언된 파라미터()
	 *//** 2) 데이터 입력하기 */
	/*
	*//** Product 입력 */
	/*
	 * // 데이터 입력에 필요한 조건값을 Beans에 저장하기 Review input = new Review();
	 * input.setProdno(prodno); input.setRegdate(regdate); input.setRate(rate);
	 * input.setContent(content); input.setRecono(recono); input.setSender(myNum);
	 * input.setReceiver(receiver); // 세션 구현한 뒤 추가
	 * 
	 * // 조회 결과를 저장할 객체 선언 Review output = null; try { // 데이터 저장 // --> 데이터 저장에 성공하면
	 * 파라미터로 전달하는 input 객체에 pk값이 저장된다. reviewService.addReview(input);
	 * 
	 * // 데이터 조회 output = reviewService.getReviewItem(input);
	 * log.debug("----------------------" + output.getRegdate() +
	 * "-------------------"); } catch (Exception e) { return
	 * webHelper.getJsonError(e.getLocalizedMessage()); }
	 * 
	 *//** 3) JSON 출력하기 *//*
							 * Map<String, Object> data = new HashMap<String, Object>(); data.put("item",
							 * output); return webHelper.getJsonData(data); }
							 */

}