package study.shop.cidermarket.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BoardController {
        
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
    
    /** 관리자 이벤트 페이지 */
    @RequestMapping(value="/admin/event_adm.cider", method=RequestMethod.GET)
    public String eventAdmList() {
        return "admin/event_adm";
    }
        
}
