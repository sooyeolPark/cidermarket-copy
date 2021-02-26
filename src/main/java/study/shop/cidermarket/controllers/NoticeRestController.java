package study.shop.cidermarket.controllers;

import java.util.Arrays;
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
import study.shop.cidermarket.model.Bbs;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.service.BbsService;
import study.shop.cidermarket.service.FilesService;

@Slf4j
@RestController
public class NoticeRestController {
   /** WebHelper 주입 */
   // -> import org.springframework.beans.factory.annotation.Autowired;
   @Autowired WebHelper webHelper;
   
   /** RegexHelper 주입 */
   @Autowired RegexHelper regexHelper;
   
   /** Service 패턴 구현체 주입 */
   @Autowired
   @Qualifier("bbsNoticeService")
   BbsService bbsNoticeService;
   
   @Autowired
   @Qualifier("filesBbsService")
   FilesService filesBbsService;
   
   /** 목록 페이지 */
   @RequestMapping(value="/notice", method=RequestMethod.GET)
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
      Bbs input = new Bbs();
      input.setTitle(keyword);
      
      List<Bbs> output = null;
      PageData pageData = null;
      
      try {
         // 전체 게시글 수 조회
         totalCount = bbsNoticeService.getBbsCount(input);
         // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
         pageData = new PageData(nowPage, totalCount, listCount, pageCount);
         
         // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
         Bbs.setOffset(pageData.getOffset());
         Bbs.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = bbsNoticeService.getBbsList(input);
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
   
   /** 상세 페이지 */
   @RequestMapping(value="/notice/{bbsno}", method=RequestMethod.GET)
   public Map<String, Object> get_item(@PathVariable("bbsno") int bbsno) {
      /** 1) 데이터 조회하기 */
      // 데이터 조회에 필요한 조건값을 Beans에 저장하기
      Bbs input = new Bbs();
      input.setBbsno(bbsno);
      
      // 조회 결과를 저장할 객체 선언
      Bbs output = null;
      try {
         // 데이터 조회
         output = bbsNoticeService.getBbsItem(input);
      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
      
      /** 2) JSON 출력하기 */
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("item", output);
      return webHelper.getJsonData(data);
   }
   
   
   /** 관리자 공지사항 목록 페이지 */
   @RequestMapping(value="/admin/notice", method=RequestMethod.GET)
   public Map<String, Object> get_list_adm(
         // 검색어
         @RequestParam(value="keyword", required=false) String keyword,
         @RequestParam(value="page", defaultValue="1") int nowPage,
         // 한페이지당 표시할 목록 수
         @RequestParam(value="listCount", defaultValue="10") int listCount) {
      
      /** 1) 페이지 구현에 필요한 변수값 생성 */
      int totalCount = 0;      // 전체 게시글 수
      int pageCount = 5;      // 한 그룹당 표시할 페이지 번호 수
      
      /** 2) 데이터 조회하기 */
      // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
      Bbs input = new Bbs();
      input.setTitle(keyword);
      
      List<Bbs> output = null;
      PageData pageData = null;
      
      try {
         // 전체 게시글 수 조회
         totalCount = bbsNoticeService.getBbsCount(input);
         // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
         pageData = new PageData(nowPage, totalCount, listCount, pageCount);
         
         // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
         Bbs.setOffset(pageData.getOffset());
         Bbs.setListCount(pageData.getListCount());

         // 데이터 조회하기
         output = bbsNoticeService.getBbsList(input);
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
   
   /** 관리자 공지사항 상세 페이지 */
   @RequestMapping(value="/admin/notice/{bbsno}", method=RequestMethod.GET)
   public Map<String, Object> get_item_adm(@PathVariable("bbsno") int bbsno) {
      /** 1) 데이터 조회하기 */
      // 데이터 조회에 필요한 조건값을 Beans에 저장하기
      Bbs input = new Bbs();
      input.setBbsno(bbsno);
      
      // 조회 결과를 저장할 객체 선언
      Bbs output = null;
      try {
         // 데이터 조회
         output = bbsNoticeService.getBbsItem(input);
      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
      
      /** 2) JSON 출력하기 */
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("item", output);
      return webHelper.getJsonData(data);
   }
   
   /** 작성 폼에 대한 action 페이지 */
   @RequestMapping(value="/admin/notice", method=RequestMethod.POST)
   public Map<String, Object> post(
         @RequestParam(value="title", defaultValue="") String title,
         @RequestParam(value="content", defaultValue="") String content,
         @RequestParam(required=false) MultipartFile photo) {

      /** 1) 사용자가 입력한 파라미터 유효성 검사 */
      // 일반 문자열 입력 컬럼 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈 문자열로 처리된다.
      if (!regexHelper.isValue(title))   { return webHelper.getJsonWarning("제목을 입력하세요."); }
      if (!regexHelper.isValue(content))   { return webHelper.getJsonWarning("내용을 입력하세요."); }
      if (photo == null) {return webHelper.getJsonWarning("이미지를 첨부하세요.");}

      /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        Bbs input = new Bbs();
        input.setTitle(title);
        input.setContent(content);

        // 저장된 결과를 조회하기 위한 객체
        Bbs output = null;
        Files f = null;

        try {
         // 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
           bbsNoticeService.addBbs(input);

           // 데이터 조회
           output = bbsNoticeService.getBbsItem(input);

           // 파일 업로드
           f = webHelper.saveMultipartFile(photo);
           f.setFname("bbs"+output.getBbsno());
           f.setReftable("bbs");
           f.setRefid(output.getBbsno());
           
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

           filesBbsService.addFiles(f);
           f = filesBbsService.getFilesItem(f);
      } catch (NullPointerException e) {
            e.printStackTrace();
            return webHelper.getJsonWarning("업로드 된 파일이 없습니다.");
      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }

        

      /** 3) 결과를 확인하기 위한 JSON 출력 */
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("item", output);
      map.put("file", f);
      return webHelper.getJsonData(map);
   }
   
   /** 수정 폼에 대한 action 페이지 */
   @RequestMapping(value="/admin/notice", method=RequestMethod.PUT)
   public Map<String, Object> PUT(
         @RequestParam(value="bbsno", defaultValue="0") int bbsno,
         @RequestParam(value="title", defaultValue="") String title,
         @RequestParam(value="content", defaultValue="") String content,
         @RequestParam(required=false) MultipartFile photo) {
      
      /** 1) 사용자가 입력한 파라미터 유효성 검사 */
      if (bbsno == 0)                  { return webHelper.getJsonWarning("글번호가 없습니다."); }
      // 일반 문자열 입력 컬럼 --> String으로 파라미터가 선언되어 있는 경우는 값이 입력되지 않으면 빈 문자열로 처리된다.
      if (!regexHelper.isValue(title))   { return webHelper.getJsonWarning("제목을 입력하세요."); }
      if (!regexHelper.isValue(content))   { return webHelper.getJsonWarning("내용을 입력하세요."); }
      
      /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        Bbs input = new Bbs();
        input.setBbsno(bbsno);
        input.setTitle(title);
        input.setContent(content);
        log.debug("----" +bbsno+"   " + title);
        
        // 저장된 결과를 조회하기 위한 객체
        Bbs output = null;
        Files f = new Files();
		f.setRefid(bbsno);
		f.setReftable("bbs");
        
        try {
        	filesBbsService.deleteFiles(f); // 데이터 삭제
            // 데이터 저장 --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
            bbsNoticeService.editBbs(input);
            
            output = bbsNoticeService.getBbsItem(input);
            
            // 파일 업로드
            f = webHelper.saveMultipartFile(photo);
            f.setFname("bbs"+output.getBbsno());
            f.setReftable("bbs");
            f.setRefid(output.getBbsno());
            
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

            filesBbsService.addFiles(f);
            f = filesBbsService.getFilesItem(f);
      } catch (Exception e) {
         return webHelper.getJsonError(e.getLocalizedMessage());
      }
        
      /** 3) 결과를 확인하기 위한 JSON 출력 */
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("item", output);
      map.put("file", f);
      return webHelper.getJsonData(map);
   }
   
   /** 삭제 처리 */
    @RequestMapping(value = "/admin/notice", method = RequestMethod.DELETE)
    public Map<String, Object> delete(
            @RequestParam(value="bbsno", defaultValue="") String[] bbsno,
            @RequestParam(value="count", defaultValue="0") int count) {
        
        /** 1) 파라미터 유효성 검사 */
        // 이 값이 존재하지 않는다면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
        if (bbsno == null) {
            return webHelper.getJsonWarning("삭제할 글이 없습니다.");
        }
        
        int[] arr = null;
        if (bbsno[0].equals("on")) {
        	bbsno = Arrays.copyOfRange(bbsno, 1, count+1);
        } 
        arr = Arrays.stream(bbsno).mapToInt(Integer::parseInt).toArray();
        
        for (int i = 0; i<count; i++) {
        	System.out.println("arr.length=" + arr.length + ", bbsno["+i+"]=" + bbsno[i]+", arr["+i+"]=" + arr[i]+ "\n");
        }
        for (int i = 0; i<count; i++) {

	        /** 2) 데이터 삭제하기 */
	        // 데이터 삭제에 필요한 조건값을 Beans에 저장하기
	        Bbs input = new Bbs();
	        input.setBbsno(arr[i]);
	        
	        Files f = new Files();
			f.setRefid(arr[i]);
			f.setReftable("bbs");
	
	        try {
	           bbsNoticeService.deleteBbs(input); // 데이터 삭제
	           filesBbsService.deleteRefFiles(f); // 데이터 삭제
	        } catch (Exception e) {
	            return webHelper.getJsonError(e.getLocalizedMessage());
	        }
        }
        
        /** 3) 결과를 확인하기 위한 JSON 출력 */
        // 확인할 대상이 삭제된 결과값만 OK로 전달
        return webHelper.getJsonData();
    }
    
    
}