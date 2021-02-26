package study.shop.cidermarket.controllers;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Singo;
import study.shop.cidermarket.service.AdmSingoService;

@Slf4j
@Controller
public class AdmSingoAjaxController {
	
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	@Autowired SqlSession sqlSession;
	
	   /** Service 패턴 구현체 주입 */
	   @Autowired
	   @Qualifier("admsingoService")
	   AdmSingoService admsingoService;
    
    /** 관리자 회원관리 페이지 */
    @RequestMapping(value="/admin/singo_adm.cider", method=RequestMethod.GET)
    public ModelAndView singoAdm(Model model,
    		@RequestParam(value="orderby", defaultValue="desc") String orderby,
    		@RequestParam(value="type", defaultValue="A") String type,
    		@RequestParam(value="page", defaultValue="1") int nowPage,
    		@RequestParam(value="search", defaultValue="") String search,
    		@RequestParam(value="listCount", defaultValue="10") int listCount) {
        /** 1) 페이지 구현에 필요한 변수값 생성 */
        int totalCount = 0;      // 전체 게시글 수
        int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
        
        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Singo input = new Singo();
        //받아온 신고유형 타입값의 파라미터 값을 type에 넣어준다.(신고유형)
        input.setType(type);
        //받아온 정렬순의 파라미터 값을 regdate에 넣어주어 전달한다.(전달만 regdate로 한다.)
        input.setRegdate(orderby);
        //검색값있으면 content에 넣어 전달 (전달만 Content로 한다.)
        if(search!="" && search!=null) {
        	input.setContent(search);
        }
        
        List<Singo> output = null;
        PageData pageData = null;
        
        try {
           // 전체 게시글 수 조회
           totalCount = admsingoService.getSingoCount(input);
           // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
           pageData = new PageData(nowPage, totalCount, listCount, pageCount);
           
           // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
           Singo.setOffset(pageData.getOffset());
           Singo.setListCount(pageData.getListCount());
           
       	   output = admsingoService.getSingoList(input);
        	   	             
        } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
        }
        
        /** 3) View 처리 */
        model.addAttribute("search", search);
        model.addAttribute("orderby", orderby);
        model.addAttribute("type", type);
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);
    	return new ModelAndView("admin/singo_adm");
    }
}
