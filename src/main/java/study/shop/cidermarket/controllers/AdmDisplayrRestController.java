package study.shop.cidermarket.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.ProductService;

@RestController
public class AdmDisplayrRestController {
    /** WebHelper 주입 */
    // -> import org.springframework.beans.factory.annotation.Autowired;
    @Autowired WebHelper webHelper;
    
    /** RegexHelper 주입 */
    @Autowired RegexHelper regexHelper;
    
    /** Service 패턴 구현체 주입 */
    @Autowired
    @Qualifier("productService")
	ProductService productService;    
    
    
    /** 목록 페이지 */
    @RequestMapping(value = "/admin/display_adm", method = RequestMethod.PUT)
    public Map<String, Object> edit(Model model,
        @RequestParam(value="cateno", defaultValue="1") int cateno,
        @RequestParam(value="prodno", defaultValue="1") int prodno) {
     
        /** 1) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Product input = new Product();
        input.setProdno(prodno);
        input.setCateno(cateno);

        try {
            // 데이터 수정하기
            productService.editCategoryProduct(input);
        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
        }

        return webHelper.getJsonData();
    }
   
}

    


