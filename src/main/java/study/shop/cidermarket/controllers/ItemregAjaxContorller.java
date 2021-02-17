package study.shop.cidermarket.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Category;
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
}