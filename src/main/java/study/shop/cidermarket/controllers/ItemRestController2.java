package study.shop.cidermarket.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Hashtag;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.FilesService;
import study.shop.cidermarket.service.HashtagService;
import study.shop.cidermarket.service.ProductService;

@Slf4j
@RestController
public class ItemRestController2 {
	/** Helper 주입 */
	@Autowired WebHelper webHelper;
	@Autowired RegexHelper regexHelper;
	
	/** Service 패턴 구현체 주입 */
	@Autowired ProductService productService;
	@Autowired HashtagService hashtagService;
	@Autowired   
	@Qualifier("filesProductService")
	FilesService filesProductService;
	
	   // 작성 폼에 대한 action page
	   @RequestMapping(value="/Item_index", method=RequestMethod.POST)
	   public Map<String, Object> get_item(
			   @RequestParam(name="image0", required=false) MultipartFile image0,
			   @RequestParam(name="image1", required=false) MultipartFile image1,
			   @RequestParam(name="image2", required=false) MultipartFile image2,
			   @RequestParam(name="image3", required=false) MultipartFile image3,
			   @RequestParam(name="image4", required=false) MultipartFile image4,
			   @RequestParam(name="image5", required=false) MultipartFile image5,
			   @RequestParam(name="image6", required=false) MultipartFile image6,
			   @RequestParam(name="image7", required=false) MultipartFile image7,
			   @RequestParam(value="item_subject", defaultValue="") String item_subject,
			   @RequestParam(value="item_category", defaultValue="0") int item_category,
			   @RequestParam(value="item_content", defaultValue="") String item_content,
			   @RequestParam(value="hash1", required=false) String hash1,
			   @RequestParam(value="hash2", required=false) String hash2,
			   @RequestParam(value="hash3", required=false) String hash3,
			   @RequestParam(value="hash4", required=false) String hash4,
			   @RequestParam(value="hash5", required=false) String hash5,
			   @RequestParam(value="item_prodcon", defaultValue="") String item_prodcon,
			   @RequestParam(value="item_price", defaultValue="0") int item_price,
			   @RequestParam(value="optionsRadios", defaultValue="") String item_how,
			   @RequestParam(value="item_delfee", defaultValue="0") int item_delfee) {
		
		   /** 1) 유효성 검사 */
			// 일반 문자열 입력 칼럽 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈문자열로 처리된다.
			if(!regexHelper.isValue(item_subject))	{return webHelper.getJsonWarning("상품 제목을 입력하세요.");}
			if(!regexHelper.isValue(item_content))	{return webHelper.getJsonWarning("상품 상세설명을 입력하세요.");}
			if(item_category==0)	{return webHelper.getJsonWarning("카테고리 분류를 선택해주세요");}
			if(image0==null && image1==null && image2==null && image3==null && image4==null && 
					image5==null && image6==null && image7==null) {
				return webHelper.getJsonWarning("사진은 최소 1장 이상 등록해주세요.");
			}
						
			// 숫자형으로 선언된 파라미터()
		   /** 2) 데이터 입력하기 */
	      /** Product 입력 */
		  // 데이터 입력에 필요한 조건값을 Beans에 저장하기
	      Product input = new Product();
	      input.setCateno(item_category);
	      input.setSubject(item_subject);
	      input.setPrice(item_price);
	      input.setFee(item_delfee);
	      input.setDetail(item_content);
	      input.setProdcon(item_prodcon);
	      input.setHow(item_how);
	      input.setSeller(3);		//세션 구현한 뒤 추가
	  	      
	      // 조회 결과를 저장할 객체 선언
	      Product output = null;
	      try {
	    	//데이터 저장
				//--> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 pk값이 저장된다.
				productService.addProduct(input);
	         // 데이터 조회
	         output = productService.getProductItem(input);
	      } catch (Exception e) {
	         return webHelper.getJsonError(e.getLocalizedMessage());
	      }
	      
	      /** Hashtag 입력 hash태그는 필수요소가 아니므로 없을 경우를 대비하여 if문으로 구현*/
	      boolean isHash;
	      if(hash1.equals("") && hash2.equals("") && hash3.equals("") && hash4.equals("") && hash5.equals("")) {
	    	  isHash=false;
	      } else {
	    	  isHash = true;
	      }
	      if(isHash) {
	    	// 조회 결과를 저장할 객체 선언
				//hash태그 있으면 ArrayList에 담는다.
				List<String> hash= new ArrayList<String>();
				if(hash1!=null && !hash1.equals("")) {hash.add(hash1);}
				if(hash2!=null && !hash2.equals("")) {hash.add(hash2);}
				if(hash3!=null && !hash3.equals("")) {hash.add(hash3);}
				if(hash4!=null && !hash4.equals("")) {hash.add(hash4);}
				if(hash5!=null && !hash5.equals("")) {hash.add(hash5);}
				
				//for문으로 데이터 입력 처리
				for(int i = 0; i<hash.size(); i++) {
				Hashtag input1 = new Hashtag();
				input1.setTagname(hash.get(i));
				input1.setProdno(output.getProdno());
					try {
				    	//데이터 저장
							hashtagService.addHashtag(input1);
				      } catch (Exception e) {
				         return webHelper.getJsonError(e.getLocalizedMessage());
				      }  
			      }
				
				}
	      //데이터 입력 for문이 완료되면 데이터를 조회할 객체를 만들어 놓는다.
			List<Hashtag> output1 = null;
			Hashtag input1 = new Hashtag();
			input1.setProdno(output.getProdno());
			try {
				output1 = hashtagService.getHashtagList(input1);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	      /** 파일 Path 입력 */
			//파일이 있으면 ArrayList에 담는다.
			List<MultipartFile> files= new ArrayList<MultipartFile>();
			if(image0!=null) {files.add(image0);}
			if(image1!=null) {files.add(image1);}
			if(image2!=null) {files.add(image2);}
			if(image3!=null) {files.add(image3);}
			if(image4!=null) {files.add(image4);}
			if(image5!=null) {files.add(image5);}
			if(image6!=null) {files.add(image6);}
			if(image7!=null) {files.add(image7);}
			
			
			
			//for문으로 데이터 입력 처리
			for(int i = 0; i<files.size(); i++) {
				// 저장된 결과를 조회하기 위한 객체
				Files f = null;
				try {
					f = webHelper.saveMultipartFile(files.get(i));
			        f.setFname("product"+output.getProdno()+i);
			        f.setReftable("product");
			        f.setRefid(output.getProdno());
			        
			        /** [신규] 파일 형식이 이미지인 경우 썸네일 이미지 생성하기 */
			        if (f != null && f.getType().indexOf("image") > -1) {
			            // 필요한 이미지 사이즈로 썸네일을 생성할 수 있다.
			            String thumbnailPath = null;
			            try {
			                thumbnailPath = webHelper.createThumbnail(f.getFilepath(), 100, 100, false);
			            } catch (Exception e) {
			                e.printStackTrace();
			                return webHelper.getJsonWarning("썸네일 이미지 생성에 실패했습니다.");
			            }
			            // 썸네일 경로를 URL로 변환
			            String thumbnailUrl = webHelper.getUploadUrl(thumbnailPath);
			            // 리턴할 객체에 썸네일 정보 추가
			            f.setThumbnailPath(thumbnailPath);
			            f.setThumbnailUrl(thumbnailUrl);
			           }
			        //files 테이블에 데이터 입력
			        filesProductService.addFiles(f);			        
			      } catch (NullPointerException e) {
			            e.printStackTrace();
			            return webHelper.getJsonWarning("업로드 된 파일이 없습니다.");
			      } catch (Exception e) {
			         return webHelper.getJsonError(e.getLocalizedMessage());
			      }

			}
	      /** 2) JSON 출력하기 */
	      Map<String, Object> data = new HashMap<String, Object>();
	      data.put("item", output);
	      data.put("hash", output1);
	      return webHelper.getJsonData(data);
	   }
	
	
}
