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

import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Category;
import study.shop.cidermarket.service.CategoryService;

@Controller
public class AdmCategoryAjaxContorller {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("categoryService")
   CategoryService categoryService;
   
   /** 목록 페이지 */
   @RequestMapping(value="/admin/category_adm.cider", method=RequestMethod.GET)
   public ModelAndView list(Model model) {
         // 검색어

      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.

      
      List<Category> output = null;
      
      try {
   
         // 데이터 조회하기
         output = categoryService.getCategoryList(null);
      } catch (Exception e) {
         return webHelper.redirect(null, e.getLocalizedMessage());
      }
      
      /** 3) View 처리 */
      model.addAttribute("output", output);
      
      return new ModelAndView("admin/category_adm");
   }
   
   
   
  
}