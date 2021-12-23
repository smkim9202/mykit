package controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Item;
import logic.Review;
import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("review")
public class ReviewController {
	@Autowired
	ShopService service;
	
	//[1.리뷰작성]
	@GetMapping("write")
	public ModelAndView iditckGetWrite(String userid, Integer itemid, HttpSession session) {
		ModelAndView mav = new ModelAndView(); //기본 뷰는 url로부터 설정됨.
		Review review = new Review();
		User user = service.userSelectOne(userid);
		Item item = service.getItem(itemid);
		mav.addObject("user", user); //user객체 전달
		mav.addObject("item", item);
		mav.addObject("review", review);
		return mav;
	}
	@RequestMapping("write")
	public ModelAndView iditckWrite(@Valid Review review, BindingResult bresult, HttpServletRequest request, 
			String userid, Integer itemid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println(userid);
		System.out.println(itemid);
		User user = service.userSelectOne(userid);
		Item item = service.getItem(itemid);
		mav.addObject("user", user);
		mav.addObject("item", item);
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		service.reviewrite(review);
		User loginUser = (User)session.getAttribute("loginUser");
		mav.setViewName("redirect:list?id=" + loginUser.getUserid());
		return mav;
	}
	@RequestMapping("imgupload")
	public String imgupload(MultipartFile upload, String CKEditorFuncNum, HttpServletRequest request, Model model) {
		String path = request.getServletContext().getRealPath("/") + "review/imgfile/"; //업로드될 서버의 폴더 위치의 절대 경로
		File f = new File(path);
		if(!f.exists()) f.mkdirs();
		if(!upload.isEmpty()) {
			File file = new File(path, upload.getOriginalFilename());
			try {
				upload.transferTo(file); //파일 업로드
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		String fileName = request.getContextPath() + "/review/imgfile/" + upload.getOriginalFilename();
		model.addAttribute("fileName", fileName);
		model.addAttribute("CKEditorFuncNum", CKEditorFuncNum);
		return "ckedit";
	}
	
	//[2.리뷰 목록] - mypage -> list (로그인필수)
	@RequestMapping("list") // Get, Post 둘다
	public ModelAndView idckmylist(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Review> reviewlist = service.reviewList(id);
		mav.addObject("reviewList", reviewlist);
		return mav;
	}
	
	//[3.상세]
	@GetMapping("detail")
	public ModelAndView detail(Integer num) {
		ModelAndView mav = new ModelAndView();
		if (num != null) {
			Review review = service.getReview(num);
			System.out.println(review);
			Item item = service.getItem(review.getItemid());
			mav.addObject("itemname", item.getItemname());
			mav.addObject("review", review);
		}
		return mav;
	}
	
	//[4.리뷰 수정]
	@GetMapping({"update", "delete"})
	public ModelAndView getReview(Integer num, String userid,  Integer itemid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(num != null) {
			Review review = service.getReview(num);
			User loginUser = (User)session.getAttribute("loginUser");
		    if(loginUser==null) {//로그아웃
				throw new LoginException("로그인 후 이용해주세요!","../user/userlogin");
			}
		    else if((loginUser.getUserid().equals(review.getUserid())) //작성자 
	    			|| (loginUser.getUserid().equals("admin"))) {//관리자
			}else {//로그인유저 아니고, 관리자도 아닐경우
				throw new LoginException("권한이 없습니다.","../user/main");
			}
			mav.addObject("review", review);
		}
		return mav;
	}
	@PostMapping("update")
	public ModelAndView update(@Valid Review review, BindingResult bresult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			System.out.println(mav);
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		try {
			service.reviewUpdate(review, request);
			System.out.println(review);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("리뷰 수정을 실패 했습니다.", "list?id="+review.getUserid());
		}
		mav.setViewName("redirect:detail?num=" + review.getRenum());
		return mav;
	}
	
	//[5.리뷰 삭제]
	@PostMapping("delete")
	public ModelAndView delete(Review review, BindingResult bresult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		int num = review.getRenum();
		try {
			service.reviewDelete(num);
			mav.setViewName("redirect:list?id=" + review.getUserid());
		}catch(Exception e){
			e.printStackTrace();
			throw new LoginException("리뷰 삭제를 실패했습니다.", "detail?num="+review.getRenum());
		}
		return mav;
	}
	
	@GetMapping("itemreview")
	public ModelAndView itemreview(String id) { //아이템 번호
		ModelAndView mav = new ModelAndView();
		List<Review> reviewlist = service.reviewItemList(id);
		double avgreview = service.avgReview(id);
		mav.addObject("avgreview", avgreview);
		mav.addObject("reviewlist", reviewlist);
		return mav;
	}
}
