package study.shop.cidermarket.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Category;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Hashtag;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.ItemregService;

@Controller
public class ItemregAjaxContorller {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("itemregService")
   ItemregService itemregService;
   
   /** 목록 페이지 */
   @RequestMapping(value="/itemreg.cider", method=RequestMethod.GET)
   public ModelAndView list(Model model) {
      /** 2) 데이터 조회하기 */
      // 카테고리 데이터 부터 불러오기
      
      List<Category> output = null;
      
      try {
    	  output = itemregService.getCategoryList();
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      model.addAttribute("output", output);
      
      return new ModelAndView("user/item_reg");
   }
   
   /** 목록 페이지 */
   @RequestMapping(value="/itemupdate.cider", method=RequestMethod.GET)
   public ModelAndView update(Model model,
		   @RequestParam(value="prodno", defaultValue="0") int prodno) {
	   
	   /** 1) 유효성 검사 */
       // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
       if (prodno == 0) {
           return webHelper.redirect(null, "상품번호가 없습니다.");
       }
       
      /** 2) 데이터 조회하기 */
     //이미지 파일 경로 불러오기
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Files input_01 = new Files();
       input_01.setRefid(prodno);

       // 조회결과를 저장할 객체 선언
       List<Files> output_01 = null;

       try {
           // 데이터 조회
           output_01 = itemregService.getFilesListItem(input_01);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       Files temp = new Files();
       temp.setFilepath("X");
       int list_count = output_01.size();
       if(list_count<9) {
    	   for(int i = 0; i < 8-list_count ; i++) {
    		   output_01.add(temp);
    	   }
       }
       
      // 카테고리 데이터 부터 불러오기
      
      List<Category> output_02 = null;
      
      try {
    	  output_02 = itemregService.getCategoryList();
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
   // 상품정보 불러오기
      // 데이터 조회에 필요한 조건값을 Beans에 저장하기
      Product input_03 = new Product();
      input_03.setProdno(prodno);

      // 조회결과를 저장할 객체 선언
      Product output_03 = null;

      try {
          // 데이터 조회
          output_03 = itemregService.getProductItem(input_03);
      } catch (Exception e) {
          return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
      //해쉬태그 정보 불러오기
      Hashtag input_04 = new Hashtag();
      input_04.setProdno(prodno);

      // 조회결과를 저장할 객체 선언
      List<Hashtag> output_04 = null;
      try {
          // 데이터 조회
          output_04 = itemregService.getHashtagList(input_04);
      } catch (Exception e) {
          return webHelper.redirect(null, e.getLocalizedMessage());
      }
      /** 3) View 처리 */
      model.addAttribute("fileimages", output_01);
      model.addAttribute("category", output_02);
      model.addAttribute("product", output_03);
      model.addAttribute("hashtag", output_04);
      
      return new ModelAndView("user/item_update");
   }
   
   
}