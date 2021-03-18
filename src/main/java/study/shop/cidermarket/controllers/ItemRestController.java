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
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Membprod;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.model.Record;
import study.shop.cidermarket.model.Reply;
import study.shop.cidermarket.model.Rereply;
import study.shop.cidermarket.model.Singo;
import study.shop.cidermarket.service.FilesService;
import study.shop.cidermarket.service.HashtagService;
import study.shop.cidermarket.service.ItemIndexService;
import study.shop.cidermarket.service.ItemListService;
import study.shop.cidermarket.service.ItemregService;
import study.shop.cidermarket.service.ProductService;

@Slf4j
@RestController
public class ItemRestController {
	/** Helper 주입 */
	@Autowired
	WebHelper webHelper;
	@Autowired
	RegexHelper regexHelper;

	/** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("itemlistService")
	ItemListService itemListService;
	
   @Autowired
   @Qualifier("productService")
   ProductService productService;
   
	@Autowired 
	@Qualifier("hashtagService")
	HashtagService hashtagService;
	
	@Autowired   
	@Qualifier("filesProductService")
	FilesService filesProductService;
	
	@Autowired   
	@Qualifier("itemregService")
	ItemregService itemregService;

	/** 목록 페이지 */
//---------------------------------------------------------------------------------------------	
	@RequestMapping(value = "/Item_list", method = RequestMethod.GET)
	public Map<String, Object> get_json_list(
			@RequestParam(value="cateno", defaultValue = "1") int cateno,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "page", defaultValue = "1") int nowPage,
			@RequestParam(value="filter", defaultValue="0") int filter,
			@RequestParam(value = "sort", defaultValue = "") String sort) {

		/** 1) 페이지 구현에 필요한 변수값 생성 */
		int totalCount = 0; // 전체 게시글 수
		int listCount = 4; // 한 페이지당 표시할 목록 수
		int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수

		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Product input = new Product();
		input.setCateno(cateno);
		if(filter!=0) {
			input.setProdno(filter);
		}
		List<Product> output = null;
		PageData pageData = null;
		
		try {
			// 전체 게시글 수 조회
			totalCount = itemListService.getItemListCount(input);
			// 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
			pageData = new PageData(nowPage, totalCount, listCount, pageCount);

			// SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
			Product.setOffset(pageData.getOffset());
			Product.setListCount(pageData.getListCount());

			// 데이터 조회하기
			if (sort.equals("lowprice")) {
				output = itemListService.selectListByPriceAsc(input);  // 저가순
			} else if(sort.equals("highprice")) {
				output = itemListService.selectListByPriceDesc(input);  // 고가순
			} else {
				output = itemListService.selectListByRegdate(input);  // 최신순 조회(기본값)			
			}
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}

		/** 3) JSON 출력하기 */
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("item", output);
		data.put("keyword", keyword);
		data.put("pageData", pageData);
		data.put("sort", sort);
		data.put("filter", filter);

		return webHelper.getJsonData(data);
	}

	   // 상품 등록 폼에 대한 action page
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
			   @RequestParam(value="seller", defaultValue="0") int seller,
			   @RequestParam(value="item_delfee", defaultValue="0") int item_delfee) {
		
		   /** 1) 유효성 검사 */
			// 일반 문자열 입력 칼럽 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈문자열로 처리된다.
			if(!regexHelper.isValue(item_subject))	{return webHelper.getJsonWarning("상품 제목을 입력하세요.");}
			if(!regexHelper.isValue(item_content))	{return webHelper.getJsonWarning("상품 상세설명을 입력하세요.");}
			if(item_category==0)	{return webHelper.getJsonWarning("카테고리 분류를 선택해주세요.");}
			if(seller==0)	{return webHelper.getJsonWarning("로그인을 해주세요.");}
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
	      input.setSeller(seller);
	  	      
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
	      
	      //직거래나 상관없음을 눌렀을 때 record 테이블에 기록
	      if(item_how!="T") {
	    	  Record input_record = new Record(); 
	    	  input_record.setProdno(output.getProdno());
	    	  
	    	  try {
				itemregService.addRecord(input_record);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
			
			//첫번째 파일을 대표이미지로 저장
				// 저장된 결과를 조회하기 위한 객체
				Files f1 = null;
				try {
					f1 = webHelper.saveMultipartFile(files.get(0));
			        f1.setFname("product"+output.getProdno());
			        f1.setReftable("product");
			        f1.setRefid(output.getProdno());
			        
			        /** [신규] 파일 형식이 이미지인 경우 썸네일 이미지 생성하기 */
			        if (f1 != null && f1.getType().indexOf("image") > -1) {
			            // 필요한 이미지 사이즈로 썸네일을 생성할 수 있다.
			            String thumbnailPath = null;
			            try {
			                thumbnailPath = webHelper.createThumbnail(f1.getFilepath(), 600, 600, true);
			            } catch (Exception e) {
			                e.printStackTrace();
			                return webHelper.getJsonWarning("썸네일 이미지 생성에 실패했습니다.");
			            }
			            // 썸네일 경로를 URL로 변환
			            String thumbnailUrl = webHelper.getUploadUrl(thumbnailPath);
			            // 리턴할 객체에 썸네일 정보 추가
			            f1.setThumbnailPath(thumbnailPath);
			            f1.setThumbnailUrl(thumbnailUrl);
			           }
			        //files 테이블에 데이터 입력
			        filesProductService.addFiles(f1);			        
			      } catch (NullPointerException e) {
			            e.printStackTrace();
			            return webHelper.getJsonWarning("업로드 된 파일이 없습니다.");
			      } catch (Exception e) {
			         return webHelper.getJsonError(e.getLocalizedMessage());
			      }
			
			
			//두번째 파일이 있으면 두번째 파일부터 다시 입력
			if(files.size()>1) {
				//for문으로 데이터 입력 처리
				for(int i = 1; i<files.size(); i++) {
					// 저장된 결과를 조회하기 위한 객체
					Files f = null;
					try {
						f = webHelper.saveMultipartFile(files.get(i));
				        f.setFname("product"+output.getProdno()+String.format("%d", System.currentTimeMillis()));
				        f.setReftable("product");
				        f.setRefid(output.getProdno());
				        
				        /** [신규] 파일 형식이 이미지인 경우 썸네일 이미지 생성하기 */
				        if (f != null && f.getType().indexOf("image") > -1) {
				            // 필요한 이미지 사이즈로 썸네일을 생성할 수 있다.
				            String thumbnailPath = null;
				            try {
				                thumbnailPath = webHelper.createThumbnail(f.getFilepath(), 600, 600, true);
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
			}
			
	      /** 2) JSON 출력하기 */
	      Map<String, Object> data = new HashMap<String, Object>();
	      data.put("item", output);
	      return webHelper.getJsonData(data);
	   }
	
	   /** ============================================================================================= */
	   
	   /** Service 패턴 구현체 주입 */
	   @Autowired
	   @Qualifier("itemindexService")
	   ItemIndexService itemindexService;
	   //
	   /** 목록 페이지 */
	   @RequestMapping(value="/item_index/{prodno}", method=RequestMethod.GET)
	   public Map<String, Object> get_index(@PathVariable("prodno") int prodno) {
	      
		   /** 1) 유효성 검사 */
	       // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
	       if (prodno == 0) {
	    	   return webHelper.getJsonWarning("상품번호가 없습니다.");
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
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
	    	   return webHelper.getJsonError(e.getLocalizedMessage());
	       }
	       
	        /** 2) JSON 출력하기 */
	        Map<String, Object> data = new HashMap<String, Object>();
	       
	       data.put("fileimages", output_01);
	       data.put("product", output_02);
	       data.put("productcount", output_03);
	       data.put("seller", output_04);
	       data.put("sellercount", output_05);
	       data.put("reply", output_06);
	       data.put("rereply", output_07);
	       data.put("membprod", output_08);
	       data.put("itemlistcategory", output_09);
	       data.put("itemlistseller", output_10);
	       data.put("hashtag", output_11);
	       
	       return webHelper.getJsonData(data);
		
	   }
	   
	// 신고 작성 폼에 대한 action page
	   @RequestMapping(value="/admin/singo", method=RequestMethod.POST)
	   public Map<String, Object> singo(
			   	@RequestParam(value="singo_type", defaultValue="") String type,
		        @RequestParam(value="singo_content", defaultValue="") String content,
		        @RequestParam(value="singo_sender", defaultValue="0") int writer,
		        @RequestParam(value="singo_prodno", defaultValue="0") int prodno) {
		      
		      /** 1) 사용자가 입력한 파라미터 유효성 검사 */
		      if (content=="" || content.trim().equals(""))   { return webHelper.getJsonWarning("내용을 입력하세요."); }
		      if (type=="" || type.trim().equals(""))   { return webHelper.getJsonWarning("신고사유를 입력하세요."); }
		      
		      /** 2) 데이터 저장하기 */
		        // 저장할 값들을 Beans에 담는다.
		        Singo input = new Singo();
		        input.setType(type);
		        input.setContent(content);
		        input.setMembno(writer);
		        input.setProdno(prodno);
		       
		        try {
		         // 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
		           itemindexService.addSingo(input);

		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      }
		        
		      /** 3) 결과를 확인하기 위한 JSON 출력 */
		      return webHelper.getJsonData();
		   }
	   
		// 댓글 작성 폼에 대한 action page
	   @RequestMapping(value="/reply", method=RequestMethod.POST)
	   public Map<String, Object> add_reply(
		        @RequestParam(value="reply_content", defaultValue="") String content,
		        @RequestParam(value="reply_writer", defaultValue="0") int writer,
		        @RequestParam(value="reply_prodno", defaultValue="0") int prodno) {
		      
		      /** 2) 데이터 저장하기 */
		        // 저장할 값들을 Beans에 담는다.
		        Reply input = new Reply();
		        input.setContent(content);
		        input.setWriter(writer);
		        input.setProdno(prodno);
		       
		        try {
		         // 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
		           itemindexService.addReply(input);

		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      }
		        
		      /** 3) 결과를 확인하기 위한 JSON 출력 */
		      return webHelper.getJsonData();
		   }
	   
		// 대댓글 작성 폼에 대한 action page
	   @RequestMapping(value="/rereply", method=RequestMethod.POST)
	   public Map<String, Object> add_rereply(
		        @RequestParam(value="rereply_content", defaultValue="") String content,
		        @RequestParam(value="rereply_replyno", defaultValue="0") int replyno,
		        @RequestParam(value="rereply_writer", defaultValue="0") int writer,
		        @RequestParam(value="rereply_prodno", defaultValue="0") int prodno) {
		    
		      
		      /** 2) 데이터 저장하기 */
		        // 저장할 값들을 Beans에 담는다.
		        Rereply input = new Rereply();
		        input.setContent(content);
		        input.setReplyno(replyno);
		        input.setWriter(writer);
		        input.setProdno(prodno);
		       
		        try {
		         // 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
		           itemindexService.addRereply(input);

		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      }
		        
		      /** 3) 결과를 확인하기 위한 JSON 출력 */
		      return webHelper.getJsonData();
		   }
	   
	// 댓글 삭제 (사실은 수정) 폼에 대한 action page
	   @RequestMapping(value="/reply_delete", method=RequestMethod.PUT)
	   public Map<String, Object> edit_reply(
		        @RequestParam(value="replyno", defaultValue="0") int replyno) {
		      /** 2) 데이터 저장하기 */
		        // 저장할 값들을 Beans에 담는다.
		        Reply input = new Reply();
		        input.setReplyno(replyno);
		        
		       
		        try {
		         // 데이터 수정.
		           itemindexService.editReply(input);

		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      }
		        
		      /** 3) 결과를 확인하기 위한 JSON 출력 */
		      return webHelper.getJsonData();
		   }
	   
		// 대댓글 삭제 폼에 대한 action page
	   @RequestMapping(value="/rereply_delete", method=RequestMethod.DELETE)
	   public Map<String, Object> delete_rereply(
		        @RequestParam(value="rereplyno", defaultValue="0") int rereplyno) {
		      /** 2) 데이터 저장하기 */
		        // 저장할 값들을 Beans에 담는다.
		        Rereply input = new Rereply();
		        input.setRereplyno(rereplyno);
		        
		       
		        try {
		         // 데이터 수정.
		           itemindexService.deleteRereply(input);

		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      }
		        
		      /** 3) 결과를 확인하기 위한 JSON 출력 */
		      return webHelper.getJsonData();
		   }

		// 찜하기 등록 폼에 대한 action page
	   @RequestMapping(value="/membprod_add", method=RequestMethod.POST)
	   public Map<String, Object> add_membprod(
		        @RequestParam(value="prodno", defaultValue="0") int prodno,
		        @RequestParam(value="membno", defaultValue="0") int membno) {
		      
		      /** 1) 사용자가 입력한 파라미터 유효성 검사 */
		      if (prodno==0)   { return webHelper.getJsonWarning("상품 번호 없음"); }
		      if (membno==0)   { return webHelper.getJsonWarning("멤버 번호 없음"); }
		      
		      /** 2) 데이터 저장하기 */
		        // 저장할 값들을 Beans에 담는다.
		        Membprod input = new Membprod();
		        input.setProdno(prodno);
		        input.setMembno(membno);
		       
		        try {
		         // 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
		           itemindexService.addMembprod(input);

		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      }
		       
		        Membprod input_01 = new Membprod();
		        input_01.setProdno(prodno);

			    // 조회결과를 저장할 객체 선언
			    List<Membprod> output = null;
			    try {
			  	   // 데이터 조회
			        output = itemindexService.getMembprodList(input_01);
			    } catch (Exception e) {
			    	return webHelper.getJsonError(e.getLocalizedMessage());
			    }
		        
		      /** 3) 결과를 확인하기 위한 JSON 출력 */
			    Map<String, Object> data = new HashMap<String, Object>();
			       
			       data.put("item", output);
			       return webHelper.getJsonData(data);
		   }
	   
		// 찜하기 삭제 폼에 대한 action page
	   @RequestMapping(value="/membprod_delete", method=RequestMethod.DELETE)
	   public Map<String, Object> delete_rereply(
			   	@RequestParam(value="prodno", defaultValue="0") int prodno,
		        @RequestParam(value="membno", defaultValue="0") int membno) {
		   
		   /** 1) 사용자가 입력한 파라미터 유효성 검사 */
		      if (prodno==0)   { return webHelper.getJsonWarning("상품 번호 없음"); }
		      if (membno==0)   { return webHelper.getJsonWarning("멤버 번호 없음"); }
		      
		      /** 2) 데이터 저장하기 */
		        // 저장할 값들을 Beans에 담는다.
		        Membprod input = new Membprod();
		        input.setProdno(prodno);
		        input.setMembno(membno);
		       
		        try {
		         // 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
		           itemindexService.deleteMembprod(input);

		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      }
		        
		        Membprod input_01 = new Membprod();
		        input_01.setProdno(prodno);

			    // 조회결과를 저장할 객체 선언
			    List<Membprod> output = null;
			    try {
			  	   // 데이터 조회
			        output = itemindexService.getMembprodList(input_01);
			    } catch (Exception e) {
			    	return webHelper.getJsonError(e.getLocalizedMessage());
			    }
		        
		      /** 3) 결과를 확인하기 위한 JSON 출력 */
			    Map<String, Object> data = new HashMap<String, Object>();
			       
			       data.put("item", output);
			       return webHelper.getJsonData(data);
		   }
	   
	   
	// 상품 등록 폼에 대한 action page
	   @RequestMapping(value="/Item_update", method=RequestMethod.POST)
	   public Map<String, Object> update_item(
			   @RequestParam(name="origin_image0", required=false) String origin_image0,
			   @RequestParam(name="origin_image1", required=false) String origin_image1,
			   @RequestParam(name="origin_image2", required=false) String origin_image2,
			   @RequestParam(name="origin_image3", required=false) String origin_image3,
			   @RequestParam(name="origin_image4", required=false) String origin_image4,
			   @RequestParam(name="origin_image5", required=false) String origin_image5,
			   @RequestParam(name="origin_image6", required=false) String origin_image6,
			   @RequestParam(name="origin_image7", required=false) String origin_image7,
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
			   @RequestParam(value="seller", defaultValue="0") int seller,
			   @RequestParam(value="prodno", defaultValue="0") int prodno,
			   @RequestParam(value="item_delfee", defaultValue="0") int item_delfee) {
		
		   /** 1) 유효성 검사 */
			// 일반 문자열 입력 칼럽 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈문자열로 처리된다.
			if(!regexHelper.isValue(item_subject))	{return webHelper.getJsonWarning("상품 제목을 입력하세요.");}
			if(!regexHelper.isValue(item_content))	{return webHelper.getJsonWarning("상품 상세설명을 입력하세요.");}
			if(item_category==0)	{return webHelper.getJsonWarning("카테고리 분류를 선택해주세요.");}
			if(seller==0)	{return webHelper.getJsonWarning("로그인을 해주세요.");}
			if(image0==null && image1==null && image2==null && image3==null && image4==null && image5==null && image6==null 
					&& image7==null && origin_image0!="" && origin_image1!="" && origin_image2!="" && origin_image3!="" &&
					origin_image4!="" && origin_image5!="" && origin_image6!="" && origin_image7!="") {
				return webHelper.getJsonWarning("사진은 최소 1장 이상 등록해주세요.");
			}
						
			/** 2) 데이터 입력하기 */
		      /** Product 입력 */
			  // 데이터 입력에 필요한 조건값을 Beans에 저장하기
		      Product input_01 = new Product();
		      input_01.setProdno(prodno);
		      input_01.setCateno(item_category);
		      input_01.setSubject(item_subject);
		      input_01.setPrice(item_price);
		      input_01.setFee(item_delfee);
		      input_01.setDetail(item_content);
		      input_01.setProdcon(item_prodcon);
		      input_01.setHow(item_how);
		  	  
		      try {
		    	//데이터 수정
					itemregService.editProduct(input_01);
		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      }
		      
		      /** Hashtag 삭제 기존에 있던 해쉬태그를 모두 삭제하고 새로 받아온 값을 다시 등록한다. */
		      if(hash1.equals("") && hash2.equals("") && hash3.equals("") && hash4.equals("") && hash5.equals("")) {
		      log.debug("삭제할 해쉬태그 없음");
		      } else {
		    	  Hashtag input_02 = new Hashtag();
		      input_02.setProdno(prodno);
		      try {
		    	//데이터 삭제
					itemregService.deleteHashtag(input_02);
		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      }
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
					if(origin_image1!=null && !hash1.equals("")) {hash.add(hash1);}
					if(hash2!=null && !hash2.equals("")) {hash.add(hash2);}
					if(hash3!=null && !hash3.equals("")) {hash.add(hash3);}
					if(hash4!=null && !hash4.equals("")) {hash.add(hash4);}
					if(hash5!=null && !hash5.equals("")) {hash.add(hash5);}
					if(hash5!=null && !hash5.equals("")) {hash.add(hash5);}
					if(hash5!=null && !hash5.equals("")) {hash.add(hash5);}
					if(hash5!=null && !hash5.equals("")) {hash.add(hash5);}
					
					//for문으로 데이터 입력 처리
					for(int i = 0; i<hash.size(); i++) {
					Hashtag input1 = new Hashtag();
					input1.setTagname(hash.get(i));
					input1.setProdno(prodno);
						try {
					    	//데이터 저장
								itemregService.addHashtag(input1);
					      } catch (Exception e) {
					         return webHelper.getJsonError(e.getLocalizedMessage());
					      }  
				      }
					
					}
		      
		      /** 파일 수정하기 (사진이 수정되면 수정된 사진은 삭제하고(삭제될 사진의 fileno가 input에 담겨온다)
		       * 새로 등록된 사진은 새로 등록해준다. */
		      // 수정된 파일 삭제하기
		      List<String> origin_image= new ArrayList<String>();
		      if(origin_image0!=null && !origin_image0.equals("")) {origin_image.add(origin_image0);}
		      if(origin_image1!=null && !origin_image1.equals("")) {origin_image.add(origin_image1);}
		      if(origin_image2!=null && !origin_image2.equals("")) {origin_image.add(origin_image2);}
		      if(origin_image3!=null && !origin_image3.equals("")) {origin_image.add(origin_image3);}
		      if(origin_image4!=null && !origin_image4.equals("")) {origin_image.add(origin_image4);}
		      if(origin_image5!=null && !origin_image5.equals("")) {origin_image.add(origin_image5);}
		      if(origin_image6!=null && !origin_image6.equals("")) {origin_image.add(origin_image6);}
		      if(origin_image7!=null && !origin_image7.equals("")) {origin_image.add(origin_image7);}

				//실제 파일 삭제 구현
				//for문으로 삭제할 파일 불러와서 List에 담기
				List<Files> del_files = new ArrayList<Files>();
				
				for(int i = 0; i<origin_image.size(); i++) {
					Files temp = new Files();
					Files temp_output=null;
					//String 상태이므로 숫자형으로 바꿔준다.
					temp.setFileno(Integer.parseInt(origin_image.get(i)));

					try {
				    	//데이터 저장
							temp_output=itemregService.getFilesItem(temp);
				      } catch (Exception e) {
				         return webHelper.getJsonError(e.getLocalizedMessage());
				      }
					del_files.add(temp_output);
			      }
				
				//List담은 file객체 실제 파일 삭제하기
				for(int i = 0; i<del_files.size(); i++) {
					try {
						webHelper.deleteFile(del_files.get(i).getFilepath());
					} catch (Exception e) {
						return webHelper.getJsonWarning("파일 삭제에 실패했습니다.");
					}
				}
				
				//썸네일도 지워주기
				for(int i = 0; i<del_files.size(); i++) {
					try {
						webHelper.deleteFile(del_files.get(i).getThumbnailPath());
					} catch (Exception e) {
						return webHelper.getJsonWarning("썸네일 파일 삭제에 실패했습니다.");
					}
				}

				//for문으로 DB 데이터 삭제 처리
				for(int i = 0; i<origin_image.size(); i++) {
					Files temp_01 = new Files();
					//String 상태이므로 숫자형으로 바꿔준다.
					temp_01.setFileno(Integer.parseInt(origin_image.get(i)));
					try {
				    	//데이터 저장
							itemregService.deleteFiles(temp_01);
							temp_01=null;
				      } catch (Exception e) {
				         return webHelper.getJsonError(e.getLocalizedMessage());
				      } 
			      }
				
				//대표이미지가 바뀌었으면 대표이미지 등록
				if(image0!=null) {
					// 저장된 결과를 조회하기 위한 객체
					Files f = null;
					try {
						f = webHelper.saveMultipartFile(image0);
				        f.setFname("product"+prodno);
				        f.setReftable("product");
				        f.setRefid(prodno);
				        
				        /** [신규] 파일 형식이 이미지인 경우 썸네일 이미지 생성하기 */
				        if (f != null && f.getType().indexOf("image") > -1) {
				            // 필요한 이미지 사이즈로 썸네일을 생성할 수 있다.
				            String thumbnailPath = null;
				            try {
				                thumbnailPath = webHelper.createThumbnail(f.getFilepath(), 600, 600, true);
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
				
				//나머지 새로 등록된 파일 등록
				List<MultipartFile> files= new ArrayList<MultipartFile>();
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
				        f.setFname("product"+prodno+String.format("%d", System.currentTimeMillis()));
				        f.setReftable("product");
				        f.setRefid(prodno);
				        
				        /** [신규] 파일 형식이 이미지인 경우 썸네일 이미지 생성하기 */
				        if (f != null && f.getType().indexOf("image") > -1) {
				            // 필요한 이미지 사이즈로 썸네일을 생성할 수 있다.
				            String thumbnailPath = null;
				            try {
				                thumbnailPath = webHelper.createThumbnail(f.getFilepath(), 600, 600, true);
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
				        itemregService.addFiles(f);			        
				      } catch (NullPointerException e) {
				            e.printStackTrace();
				            return webHelper.getJsonWarning("업로드 된 파일이 없습니다.");
				      } catch (Exception e) {
				         return webHelper.getJsonError(e.getLocalizedMessage());
				      }

				}
				
	      return webHelper.getJsonData();
	   }
	   
	    /** 상품의 숨김상태를 바꿔주는 페이지 */
	    @RequestMapping(value="/item_index_update", method=RequestMethod.PUT)
	    public Map<String, Object> hideItem(
	    		@RequestParam(value="prodno", defaultValue="0") int prodno,
	    		@RequestParam(value="tradecon") String tradecon) {
	        /** 1) 거래완료된 상품은 상태 변경 막기*/
	    		if(prodno==0) {		
	    			return webHelper.getJsonWarning("상품번호가 없습니다.");
	    		}
	    	/** 2) 데이터 수정 **/
	    	try {
	    		Product input = new Product();
	    		input.setProdno(prodno);
	    		if(tradecon.trim().equals("S")) {
	    			input.setTradecon("J");
	    		} else {
	    			input.setTradecon("S");
	    		}
	    			
	    		
	    			// 데이터 수정 --> 
	              itemindexService.editProduct(input);

	         } catch (Exception e) {
	            return webHelper.getJsonError(e.getLocalizedMessage());
	         }
	           
	         /** 3) 결과를 확인하기 위한 JSON 출력 */
	         return webHelper.getJsonData();
	      }
	    
	    /** 상품 삭제 페이지 */
	    @RequestMapping(value="/item_index_delete", method=RequestMethod.DELETE)
	    public Map<String, Object> deleteItem(
	    		@RequestParam(value="prodno", defaultValue="0") int prodno,
	    		@RequestParam(value="tradecon", defaultValue="") String tradecon) {
	    	
	    	/** 1) 거래완료된 상품은 상태 변경 막기*/
 		if(prodno==0) {		
 			return webHelper.getJsonWarning("상품번호가 없습니다.");
 		} else if (tradecon.trim().equals("W")) {
 			return webHelper.getJsonWarning("판매가 완료된 상품은 삭제할 수 없습니다.");
 		}
 		
 		/** 2) 데이터 삭제 */
 		Product input = new Product();
 		input.setProdno(prodno);
 		input.setTradecon(tradecon);
 		
 		Files f = new Files();
 		f.setRefid(prodno);
 		f.setReftable("product");
 		List<Files> files = null;
 		
 		try {
 			files = itemindexService.getFilesListItem(f);
 			if (files.size() > 0) {
	        		filesProductService.deleteRefFiles(f);  // 테이블에서 데이터 삭제
		            for (Files file : files) {
		            	webHelper.deleteFile(file.getFilepath());
		            	webHelper.deleteFile(file.getThumbnailPath());
		            }
	        	}
 			productService.deleteProduct(input);
			} catch (Exception e) {
				return webHelper.getJsonError(e.getLocalizedMessage());
			}
 		
 		return webHelper.getJsonData();
	    }	   
}
