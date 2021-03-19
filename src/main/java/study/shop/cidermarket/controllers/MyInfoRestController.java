package study.shop.cidermarket.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Product;
import study.shop.cidermarket.service.FilesService;
import study.shop.cidermarket.service.ItemIndexService;
import study.shop.cidermarket.service.ItemregService;
import study.shop.cidermarket.service.MyInfoService;
import study.shop.cidermarket.service.ProductService;

@Slf4j
@RestController
public class MyInfoRestController {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Qualifier("MyInfoService")
   @Autowired MyInfoService myInfoService;
   
   @Autowired 
   @Qualifier("productService")
   ProductService productService;
   
   @Autowired
   @Qualifier("itemindexService")
   ItemIndexService itemindexService;
   
   @Autowired   
   @Qualifier("filesProductService")
   FilesService filesProductService;
   
	@Autowired   
	@Qualifier("itemregService")
	ItemregService itemregService;
   
   //-----------프로필  변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_profile", method=RequestMethod.POST)
   public Map<String, Object> id(Model model,
	   @RequestParam(name="origin_image0", required=false) String origin_image0,
	   @RequestParam(name="image0", required=false) MultipartFile image0,
	   @RequestParam(value="nickname", defaultValue="") String nickname) {
   
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
   
		Member input = new Member();
		input.setMembno(myNum);
		
		
		Member output = null;
		
	   	try {
   			// 일치하는 데이터 조회
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}

	    /** 파일 수정하기 (사진이 수정되면 수정된 사진은 삭제하고(삭제될 사진의 fileno가 input에 담겨온다)
	       * 새로 등록된 사진은 새로 등록해준다. */
	      // 수정된 파일 삭제하기
	     
	   	
	   	
	   if(origin_image0 != null) {
		
		   int origin_image1 = Integer.parseInt(origin_image0);
		   
		   //실제 파일 삭제 구현
			Files temp = new Files();
			Files temp_output=null;
			//String 상태이므로 숫자형으로 바꿔준다.
			temp.setFileno(origin_image1);

			try {
		    	//데이터 저장
					temp_output=itemregService.getFilesItem(temp);
		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      }

			try {
				webHelper.deleteFile(temp_output.getFilepath());
			} catch (Exception e) {
				return webHelper.getJsonWarning("파일 삭제에 실패했습니다.");
			}
		


			Files temp_01 = new Files();
			//String 상태이므로 숫자형으로 바꿔준다.
			temp_01.setFileno(origin_image1);
			try {
		    	//데이터 저장
					itemregService.deleteFiles(temp_01);
					temp_01=null;
		      } catch (Exception e) {
		         return webHelper.getJsonError(e.getLocalizedMessage());
		      } 
	   } 
		
		//일반적인 사진 추가하기 =========================
		List<MultipartFile> files= new ArrayList<MultipartFile>(); 
		if(image0!=null) {files.add(image0);}


		if(files.size()>0) {
			//for문으로 데이터 입력 처리
			for(int i = 0; i<files.size(); i++) {
				// 저장된 결과를 조회하기 위한 객체
				Files f = null;
				try {
					f = webHelper.saveMultipartFile(files.get(i));
			        f.setFname("member"+myNum+String.format("%d", System.currentTimeMillis()));
			        f.setReftable("member");
			        f.setRefid(myNum);

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
   
 //------------ID 변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_id", method=RequestMethod.PUT)
   public Map<String, Object> id(Model model,
   		@RequestParam(value="nickname", defaultValue="") String nickname) {
   	
	   
	   if (!regexHelper.isValue(nickname))     { return webHelper.getJsonWarning("닉네임을 입력하세요"); }
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setNickname(nickname);
   	
   	Member output = null;
   	
   	try {
   			// 일치하는 데이터 조회
			int result = myInfoService.getMemberCount(input);
			if (result == 1) {
				return webHelper.getJsonError("이미 등록된 아이디 입니다.");
			} 
		myInfoService.editNickName(input);
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   
   //------------Intro 변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_intro", method=RequestMethod.PUT)
   public Map<String, Object> intro(Model model,
   		@RequestParam(value="intro", defaultValue="") String intro) {
   	
	   
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setIntro(intro);
   	
   	Member output = null;
   	
   	try {

		myInfoService.editIntro(input);
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }

   //------------shopaddress 변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_shopaddress", method=RequestMethod.PUT)
   public Map<String, Object> shopaddress(Model model,
   		@RequestParam(value="shopaddress", defaultValue="") String shopaddress) {
   	
	   if (!regexHelper.isValue(shopaddress))     { return webHelper.getJsonWarning("상점주소를 입력하세요."); }
       if (!regexHelper.isEngNum(shopaddress))  { return webHelper.getJsonWarning("상점주소는 영어와 숫자로만 가능합니다."); }

	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setShopaddress(shopaddress);
   	
   	Member output = null;
   	
   	try {
			// 일치하는 데이터 조회
		int result = myInfoService.getShopaddressCount(input);
		if (result == 1) {
			return webHelper.getJsonError("이미 등록된 주소 입니다.");
		} 

		myInfoService.editShopaddress(input);
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   
   //-----------email 변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_email", method=RequestMethod.PUT)
   public Map<String, Object> email(Model model,
   		@RequestParam(value="email", defaultValue="") String email) {
   	
	   
	   if (!regexHelper.isValue(email))     { return webHelper.getJsonWarning("이메일을 입력하세요."); }
       if (!regexHelper.isEmail(email))       { return webHelper.getJsonWarning("이메일 형식이 아닙니다."); }

   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setEmail(email);
   	
   	Member output = null;
   	
   	try {
			// 일치하는 데이터 조회
		int result = myInfoService.getEmailCount(input);
		if (result == 1) {
			return webHelper.getJsonError("이미 등록된 이메일 입니다.");
		} 

		myInfoService.editEmail(input);
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   //------------Tel 변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_tel", method=RequestMethod.PUT)
   public Map<String, Object> tel(Model model,
   		@RequestParam(value="tel", defaultValue="") String tel) {
   	
	   if (!regexHelper.isValue(tel))     { return webHelper.getJsonWarning("연락처를 입력하세요."); }
       if (!regexHelper.isCellPhone(tel))       { return webHelper.getJsonWarning("연락처형식이 아닙니다."); }
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setTel(tel);
   	
   	Member output = null;
   	
   	try {
			// 일치하는 데이터 조회
		int result = myInfoService.getTelCount(input);
		if (result == 1) {
			return webHelper.getJsonError("이미 등록된 번호 입니다.");
		} 

		myInfoService.editTel(input);
		output = myInfoService.getMemberItem(input);
		
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   
   
   
   
   //------------Password변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_password", method=RequestMethod.PUT)
   public Map<String, Object> password(Model model,
   		@RequestParam(value="password", defaultValue="") String password,
	   @RequestParam(value="newpassword", defaultValue="") String newpassword) {
   	
	   
	   if (!regexHelper.isValue(newpassword))     { return webHelper.getJsonWarning("패스워드를 입력하세요."); }
       if (!regexHelper.isPassword(newpassword))       { return webHelper.getJsonWarning("비밀번호 형식과 다릅니다."); }

	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setPassword(password);
   	
   	
   	
   	Member output = null;
   	
   	try {
			// 일치하는 데이터 조회
		int result = myInfoService.getCheckPassword(input);
		if (result == 0) {
			return webHelper.getJsonError("비밀번호가 일치하지 않습니다.");
		} 
		else if( result == 1) {
			
		input.setPassword(newpassword);
		myInfoService.editPassword(input);
		output = myInfoService.getMemberItem(input);
			}
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   
   //------------SMS변경 페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_SMS", method=RequestMethod.PUT)
   public Map<String, Object> sms(Model model,
	   @RequestParam(value="sms", defaultValue="") int[] sms) {
   	
	   

	   
	 //checkbox 에서 전달된 파라미터 배열 꺼내기 
	 //합계를 더해서 전달
	   int sumVal = 0;
		  for (int i=0; i<sms.length; i++){ 
			  sumVal += sms[i]; 
		  }
		  
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setSms(sumVal);
   	
   	
   	
   	Member output = null;
   	
   	try {

		myInfoService.editSMS(input);
		output = myInfoService.getMemberItem(input);
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
   	
   	/** 2) View 처리 */
    Map<String, Object> data = new HashMap<String, Object>();
    data.put("item", output);
   	
	return webHelper.getJsonData(data);
   }
   

//-----------회원탈퇴페이지 ----------------------------------------
   @RequestMapping(value="/myinfo_out", method=RequestMethod.PUT)
   public Map<String, Object> OUT(Model model,
   		@RequestParam(value="outmember", defaultValue="") String outmember) {
   	
	   
   	//Session에서 내 회원번호 가져오기 
		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");
	   
	   
   	/** 1) 데이터 조회하기 */
   	Member input = new Member();
   	input.setMembno(myNum);
   	input.setOutmember(outmember);
   	
   	try {
			// 일치하는 데이터 조회		
		input.setOutmember(outmember);
		myInfoService.editOutmember(input);
			
	} catch (Exception e) {
		return webHelper.getJsonError(e.getLocalizedMessage());
	}
   	
   	Product input_pro = new Product();
   	input_pro.setSeller(myNum);
   	List<Product> output = new ArrayList<Product>();
	try {
		output = productService.getProductOutList(input_pro);
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	if(output!=null) {
		for(int i=0; i<output.size(); i++) {
			int prodno = output.get(i).getProdno();
			String tradecon = output.get(i).getTradecon(); 
			/** 1) 거래완료된 상품은 상태 변경 막기*/
    		if(prodno==0) {		
    			return webHelper.getJsonWarning("상품번호가 없습니다.");
    		} else if (tradecon.trim().equals("W")) {
    			break;
    		}
    		
    		/** 2) 데이터 삭제 */
    		Product input_pro2 = new Product();
    		input_pro2.setProdno(prodno);
    		input_pro2.setTradecon(tradecon);
    		
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
    			productService.deleteProduct(input_pro2);
			} catch (Exception e) {
				return webHelper.getJsonError(e.getLocalizedMessage());
			}
		}
	}
		
   	
	session.invalidate();
	return webHelper.getJsonData();
   }
}