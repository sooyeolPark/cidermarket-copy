package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.service.MemberService;

@RestController
public class MemberRestController {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired MemberService memberService;
   
   /** 관리자 멤버 목록 페이지 */
   @RequestMapping(value="/member.cider", method=RequestMethod.GET)
   public Map<String, Object> get_list(
         // 검색어
         @RequestParam(value="keyword", required=false) String keyword,
         @RequestParam(value="page", defaultValue="1") int nowPage) {
      
      /** 1) 페이지 구현에 필요한 변수값 생성 */
      int totalCount = 0;      // 전체 게시글 수
      int listCount = 10;      // 한 페이지당 표시할 목록 수
      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
      Member input = new Member();
      input.setEmail(keyword);
      
      List<Member> output = null;
      PageData pageData = null;
      
      try {
         // 전체 게시글 수 조회
         totalCount = memberService.getMemberCount(input);
         // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
         pageData = new PageData(nowPage, totalCount, listCount, pageCount);
         
         // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
         Member.setOffset(pageData.getOffset());
         Member.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = memberService.getMemberList(input);
      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("keyword", keyword);
      data.put("item", output);
      data.put("pageData", pageData);
      
      return webHelper.getJsonData(data);
   }
   
   /** 내상점 내정보설정 페이지 */
   @RequestMapping(value="/member.cider/{bbsno}", method=RequestMethod.GET)
   public Map<String, Object> get_item(@PathVariable("membno") int membno) {
      /** 1) 데이터 조회하기 */
      // 데이터 조회에 필요한 조건값을 Beans에 저장하기
      Member input = new Member();
      input.setMembno(membno);
      
      // 조회 결과를 저장할 객체 선언
      Member output = null;
      try {
         // 데이터 조회
         output = memberService.getMemberItem(input);
      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
      
      /** 2) JSON 출력하기 */
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("item", output);
      return webHelper.getJsonData(data);
   }
   
   /** 회원가입 작성 폼에 대한 action 페이지 */
   @RequestMapping(value="/member.cider", method=RequestMethod.POST)
   public Map<String, Object> post(
         @RequestParam(value="email", defaultValue="") String email,
         @RequestParam(value="password", defaultValue="") String password,
         @RequestParam(value="tel", defaultValue="") String tel) {
      
      /** 1) 사용자가 입력한 파라미터 유효성 검사 */
      // 일반 문자열 입력 컬럼 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈 문자열로 처리된다.
      if (!regexHelper.isValue(email))  	{ return webHelper.getJsonWarning("내용을 입력하세요."); }
      if (!regexHelper.isValue(password))  	{ return webHelper.getJsonWarning("내용을 입력하세요."); }
      if (!regexHelper.isValue(tel))  		{ return webHelper.getJsonWarning("내용을 입력하세요."); }
      
      /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        Member input = new Member();
        input.setEmail(email);
        input.setPassword(password);
        input.setTel(tel);
        
        // 저장된 결과를 조회하기 위한 객체
        Member output = null;
        
        try {
         // 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
           memberService.addMember(input);
           
           // 데이터 조회
           output = memberService.getMemberItem(input);
      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("item", output);
      return webHelper.getJsonData(map);
   }
   
   
}