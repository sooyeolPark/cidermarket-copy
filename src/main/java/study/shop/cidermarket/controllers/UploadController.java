package study.shop.cidermarket.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import study.shop.cidermarket.helper.WebHelper;
import study.shop.cidermarket.model.Files;

@Controller
public class UploadController {
	// --> import org.springframework.beans.factory.annotation.Autowired; 
	@Autowired WebHelper webHelper;
	
	/** WebHelper를 활용하는 업로드 처리를 위한 <form>을 구성하는 페이지 */
	@RequestMapping(value="/upload/use_helper.cider", method=RequestMethod.GET)
	public String useHelper() {
		return "upload/use_helper";
	}
	
	/** WebHelper를 활용하는 업로드 처리에 대한 action 페이지 */
	@RequestMapping(value="/upload/use_helper_ok.cider", method=RequestMethod.POST)
	public ModelAndView useHelperOk(Model model,
			@RequestParam(required=false) MultipartFile photo) {
		
		/** 1) 업로드 처리 */
		// 업로드 결과가 저장된 Beans를 리턴받는다.
		Files item = null;
		try {
			item = webHelper.saveMultipartFile(photo);
		} catch (NullPointerException e) {
			e.printStackTrace();
			return webHelper.redirect(null, "업로드 된 파일이 없습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			return webHelper.redirect(null, "업로드에 실패했습니다.");
		}
		
		/** [신규] 파일 형식이 이미지인 경우 썸네일 이미지 생성하기 */
		if (item != null && item.getType().indexOf("image") > -1) {
			// 필요한 이미지 사이즈로 썸네일을 생성할 수 있다.
			String thumbnailPath = null;
			
			try {
				thumbnailPath = webHelper.createThumbnail(item.getFilepath(), 100, 100, false);
			} catch (Exception e) {
				e.printStackTrace();
				return webHelper.redirect(null, "썸네일 이미지 생성에 실패했습니다.");
			}
			
			// 썸네일 경로를 URL로 변환
			String thumbnailUrl = webHelper.getUploadUrl(thumbnailPath);
			// 리턴할 객체에 썸네일 정보 추가
			item.setThumbnailPath(thumbnailPath);
			item.setThumbnailUrl(thumbnailUrl);
		}
		
		/** 2) View 처리 */
		model.addAttribute("item", item);
		return new ModelAndView("upload/use_helper_ok");
	}
}
