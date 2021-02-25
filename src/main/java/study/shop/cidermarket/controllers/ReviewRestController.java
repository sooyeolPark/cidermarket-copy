package study.shop.cidermarket.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.helper.PageData;
import study.shop.cidermarket.helper.RegexHelper;
import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Member;
import study.shop.cidermarket.model.Review;
import study.shop.cidermarket.service.RecordService;
import study.shop.cidermarket.service.ReviewService;

@Slf4j
@RestController
public class ReviewRestController {
	/** Helper 주입 */
	@Autowired
	WebHelper webHelper;
	@Autowired
	RegexHelper regexHelper;

	/** Service 패턴 구현체 주입 */
	@Autowired
	@Qualifier("reviewService")
	ReviewService reviewService;
	
	@Autowired
	@Qualifier("recordService")
	RecordService recordService;
	
	/** myStore Review목록 페이지 */
//---------------------------------------------------------------------------------------------	
	@RequestMapping(value = "/Review", method = RequestMethod.GET)
	public Map<String, Object> get_list(
			// 검색어
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "page", defaultValue = "1") int nowPage) {
		
		
		HttpSession session = webHelper.getRequest().getSession();
	      int myNum = (int)session.getAttribute("myNum");
		
		
		/** 1) 페이지 구현에 필요한 변수값 생성 */
		int totalCount = 0; // 전체 게시글 수
		int listCount = 5; // 한 페이지당 표시할 목록 수
		int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수

		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Review input = new Review();
	    //input.setContent(keyword);
	    //input.setReceiver(myNum);
	      
	      
	      
		List<Review> output = null;
		PageData pageData = null;

		try {
			
	         // 전체 게시글 수 조회
	         totalCount = reviewService.getReviewCount(input);
	         // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
	         pageData = new PageData(nowPage, totalCount, listCount, pageCount);
	         
	         // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
	         Review.setOffset(pageData.getOffset());
	         Review.setListCount(pageData.getListCount());
			 

			// 데이터 조회하기
			output = reviewService.getReviewList(input);
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}

		/** 3) JSON 출력하기 */
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("item", output);
		data.put("keyword", keyword);
		data.put("pageData", pageData);

		return webHelper.getJsonData(data);
	}
	
	
	
	// --------------------------------------------------------------------------------작성폼에
	// 대한 action페이지
	@RequestMapping(value = "/reviewWrite", method = RequestMethod.POST)
	public Map<String, Object> post(
			@RequestParam(value = "prodno", required = false) int prodno,
			@RequestParam(value = "regdate", required = false) String regdate,
			@RequestParam(value = "rate", required = false) int rate,
			@RequestParam(value = "content", required = false) String content,
			@RequestParam(value = "recono", required = false) int recono,
			@RequestParam(value = "receiver", required = false) int receiver) {

		HttpSession session = webHelper.getRequest().getSession();
		int myNum = (int) session.getAttribute("myNum");

		/** 1) 유효성 검사 */
		// 일반 문자열 입력 칼럽 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈문자열로 처리된다.
		if (!regexHelper.isValue(content)) {
			return webHelper.getJsonWarning("리뷰내용을 입력해주세요");
		}

		// 숫자형으로 선언된 파라미터()
		/** 2) 데이터 입력하기 */
		/** Product 입력 */
		// 데이터 입력에 필요한 조건값을 Beans에 저장하기
		Review input = new Review();
		input.setProdno(prodno);
		input.setRegdate(regdate);
		input.setRate(rate);
		input.setContent(content);
		input.setRecono(recono);
		input.setSender(myNum);
		input.setReceiver(receiver);
		// 세션 구현한 뒤 추가

		// 조회 결과를 저장할 객체 선언
		Review output = null;

		try {
			// 데이터 저장
			// --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 pk값이 저장된다.
			reviewService.addReview(input);

			// 데이터 조회
			output = reviewService.getReviewItem(input);
			
			// 별점 평균 저장할 객체 선언
			float avgRate = 0;
			// 별점 평균점수를 받아와 member테이블에 저장할 객체 선언
			Member input_rate = new Member();
			
			// 별점 데이터 불러오기
			avgRate = reviewService.getRate(input);
			
			// 별점 데이터 Member 테이블에 저장
			input_rate.setRate(avgRate);
			input_rate.setMembno(output.getReceiver());
			
			reviewService.updateRate(input_rate);
			log.debug("----------------------" + output.getRegdate() + "-------------------");
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
		

		/** 파일 Path 입력 */
		// 파일이 있으면 ArrayList에 담는다.
		/*
		 * List<MultipartFile> files= new ArrayList<MultipartFile>(); if(image0!=null)
		 * {files.add(image0);} if(image1!=null) {files.add(image1);} if(image2!=null)
		 * {files.add(image2);} if(image3!=null) {files.add(image3);} if(image4!=null)
		 * {files.add(image4);} if(image5!=null) {files.add(image5);} if(image6!=null)
		 * {files.add(image6);} if(image7!=null) {files.add(image7);}
		 */

		// for문으로 데이터 입력 처리
		/*
		 * for(int i = 0; i<files.size(); i++) { // 저장된 결과를 조회하기 위한 객체 Files f = null;
		 * try { f = webHelper.saveMultipartFile(files.get(i));
		 * f.setFname("product"+output.getProdno()+i); f.setReftable("product");
		 * f.setRefid(output.getProdno());
		 * 
		 *//** [신규] 파일 형식이 이미지인 경우 썸네일 이미지 생성하기 *//*
													 * if (f != null && f.getType().indexOf("image") > -1) { // 필요한 이미지
													 * 사이즈로 썸네일을 생성할 수 있다. String thumbnailPath = null; try {
													 * thumbnailPath = webHelper.createThumbnail(f.getFilepath(), 220,
													 * 220, false); } catch (Exception e) { e.printStackTrace(); return
													 * webHelper.getJsonWarning("썸네일 이미지 생성에 실패했습니다."); } // 썸네일 경로를
													 * URL로 변환 String thumbnailUrl =
													 * webHelper.getUploadUrl(thumbnailPath); // 리턴할 객체에 썸네일 정보 추가
													 * f.setThumbnailPath(thumbnailPath);
													 * f.setThumbnailUrl(thumbnailUrl); } //files 테이블에 데이터 입력
													 * filesProductService.addFiles(f);
													 */
		/*
		 * } catch (NullPointerException e) { e.printStackTrace(); return
		 * webHelper.getJsonWarning("업로드 된 파일이 없습니다."); } catch (Exception e) { return
		 * webHelper.getJsonError(e.getLocalizedMessage()); }
		 */
		/*
		 * }
		 */
		/** 3) JSON 출력하기 */
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("item", output);
		return webHelper.getJsonData(data);
	}

	

		

}
