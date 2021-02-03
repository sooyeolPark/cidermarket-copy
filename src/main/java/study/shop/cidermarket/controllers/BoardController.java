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
public class BoardController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
    
    /** 공지사항 페이지 */
    @RequestMapping(value="/user/notice_list.cider", method=RequestMethod.GET)
    public String noticeList() {
        return "user/notice_list";
    }
    
    /** 공지사항 읽기 페이지 */
    @RequestMapping(value="/user/notice_view.cider", method=RequestMethod.GET)
    public String noticeView() {
        return "user/notice_view";
    }
    
    /** 이벤트 페이지 */
    @RequestMapping(value="/user/event_list.cider", method=RequestMethod.GET)
    public String eventList() {
        return "user/event_list";
    }
    
    /** 이벤트 읽기 페이지 */
    @RequestMapping(value="/user/event_view.cider", method=RequestMethod.GET)
    public String eventView() {
        return "user/event_view";
    }
    
    
}
