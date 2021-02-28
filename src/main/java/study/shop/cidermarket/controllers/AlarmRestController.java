package study.shop.cidermarket.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Alarm;
import study.shop.cidermarket.service.AlarmService;

@Controller
public class AlarmRestController {
	/** Helper 주입 */
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	
	/** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("AlarmService")
	AlarmService alarmService;

	
	/** 알람 삭제 */
	@RequestMapping(value = "/alarm", method = RequestMethod.DELETE)
	public Map<String, Object> alarmDel(
		@RequestParam(value = "alarno", defaultValue = "0") int alarno) {
			
		/** 데이터 삭제하기 */
		Alarm input = new Alarm();
		input.setAlarno(alarno);
		
		try {
			// 데이터 삭제하기
			alarmService.deleteAlarm(input);		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
		
		return webHelper.getJsonData();
	}
	
	
	
}
