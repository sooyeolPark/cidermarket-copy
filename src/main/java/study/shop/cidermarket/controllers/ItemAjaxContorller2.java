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
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Hashtag;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Membprod;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.model.Reply;
import study.shop.cidermarket.model.Rereply;
import study.shop.cidermarket.service.ItemIndexService;

@Controller
public class ItemAjaxContorller2 {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("itemindexService")
   ItemIndexService itemindexService;
   //
   /** 목록 페이지 */
   @RequestMapping(value="/item_index.cider", method=RequestMethod.GET)
   public ModelAndView get_index(Model model,
		   @RequestParam(value="prodno", defaultValue="0") int prodno) {
      
	   /** 1) 유효성 검사 */
       // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
       if (prodno == 0 | prodno==9999) {
           return webHelper.redirect(null, "삭제된 상품입니다.");
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
           output_01 = itemindexService.getFilesListItem(input_01);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 상품정보 불러오기
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Product input_02 = new Product();
       input_02.setProdno(prodno);

       // 조회결과를 저장할 객체 선언
       Product output_02 = null;

       try {
           // 데이터 조회
           output_02 = itemindexService.getProductItem(input_02);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 상품 개수
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Product input_03 = new Product();
       input_03.setSeller(output_02.getSeller());

       // 조회결과를 저장할 객체 선언
       int output_03 = 0;

       try {
           // 데이터 조회
           output_03 = itemindexService.getProductCount(input_03);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 판매자 정보 획득
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Member input_04 = new Member();
       input_04.setMembno(output_02.getSeller());

       // 조회결과를 저장할 객체 선언
       Member output_04 = null;

       try {
           // 데이터 조회
           output_04 = itemindexService.getSellerItem(input_04);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 판매자의 거래 성공 수 
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Record input_05 = new Record();
       input_05.setBuyer(output_02.getSeller());

       // 조회결과를 저장할 객체 선언
       int output_05 = 0;

       try {
           // 데이터 조회
           output_05 = itemindexService.getTradeCount(input_05);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 댓글 리스트
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Reply input_06 = new Reply();
       input_06.setProdno(prodno);

       // 조회결과를 저장할 객체 선언
       List<Reply> output_06 = null;

       try {
           // 데이터 조회
           output_06 = itemindexService.getReplyList(input_06);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 댓글 리스트
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Rereply input_07 = new Rereply();
       input_07.setProdno(prodno);

       // 조회결과를 저장할 객체 선언
       List<Rereply> output_07 = null;

       try {
           // 데이터 조회
           output_07 = itemindexService.getRereplyList(input_07);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 찜리스트
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Membprod input_08 = new Membprod();
       input_08.setProdno(prodno);

       // 조회결과를 저장할 객체 선언
       List<Membprod> output_08 = null;

       try {
           // 데이터 조회
           output_08 = itemindexService.getMembprodList(input_08);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 카테고리별 아이템 리스트
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Product input_09 = new Product();
       input_09.setCateno(output_02.getCateno());
       input_09.setProdno(output_02.getProdno());

       // 조회결과를 저장할 객체 선언
       List<Product> output_09 = null;
       
       // 4개 뽑아오게 변수 설정
       Product.setOffset(0);
       Product.setListCount(4);
       try {
           // 데이터 조회
           output_09 = itemindexService.getProductListByCategory(input_09);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 판매자의 아이템 리스트
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Product input_10 = new Product();
       input_10.setSeller(output_02.getSeller());
       input_10.setProdno(output_02.getProdno());

       // 조회결과를 저장할 객체 선언
       List<Product> output_10 = null;
       
       // 4개 뽑아오게 변수 설정
       Product.setOffset(0);
       Product.setListCount(4);
       try {
           // 데이터 조회
           output_10 = itemindexService.getProductListByMember(input_10);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 해쉬태그 리스트
       // 데이터 조회에 필요한 조건값을 Beans에 저장하기
       Hashtag input_11 = new Hashtag();
       input_11.setProdno(output_02.getProdno());

       // 조회결과를 저장할 객체 선언
       List<Hashtag> output_11 = null;
       try {
           // 데이터 조회
           output_11 = itemindexService.getHashtagList(input_11);
       } catch (Exception e) {
           return webHelper.redirect(null, e.getLocalizedMessage());
       }
       
       // 모델 객체에 담기
       model.addAttribute("fileimages", output_01);
       model.addAttribute("product", output_02);
       model.addAttribute("productcount", output_03);
       model.addAttribute("seller", output_04);
       model.addAttribute("sellercount", output_05);
       model.addAttribute("reply", output_06);
       model.addAttribute("rereply", output_07);
       model.addAttribute("membprod", output_08);
       model.addAttribute("itemlistcategory", output_09);
       model.addAttribute("itemlistseller", output_10);
       model.addAttribute("hashtag", output_11);
	
      return new ModelAndView("user/item_index");
   }
 
}